From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [RFC PATCH] ucm: Add support for device positions
Date: Tue, 03 Jan 2017 14:58:47 +0000
Message-ID: <1483455527.4555.12.camel@loki>
References: <1483423758-8986-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 3076B2666FE
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 15:58:51 +0100 (CET)
In-Reply-To: <1483423758-8986-1-git-send-email-mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2017-01-03 at 14:09 +0800, mengdong.lin@linux.intel.com wrote:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> Users can provide prosition info of audio devices as a device value. This
> will help the sound server to choose an audio devices from some candidates
> based on the their locations and the status of the machine.
> 
> The value name is the "Postion",

We should change this to "Location" and use "Position" for x,y,z
coordinates of the device to help for beam forming etc (separate patch
series for Position).


>  and its value should be a composition of
> "Top", "Bottom", "Left", "Right", "Front" and "Back". For example, a
> speaker may have a position like "Front Top".
> 
> The postion value can be got by either of the two APIs:
> - snd_use_case_get(), via identifier 'Postion/device', to get the original
>   position string defined by the user.
> - snd_use_case_geti(), via identifier '_devpos/device', to get the integer
>   value of the position. If the user has not define a position, 0 will be
>   returned that means an unknown position.
> 
> Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> diff --git a/include/use-case.h b/include/use-case.h
> index 8911645..b3b451b 100644
> --- a/include/use-case.h
> +++ b/include/use-case.h
> @@ -165,6 +165,28 @@ extern "C" {
>  #define SND_USE_CASE_TQ_VOICE		"Voice"		/**< Voice Tone Quality */
>  #define SND_USE_CASE_TQ_TONES		"Tones"		/**< Tones Tone Quality */
>  
> +
> +/**
> + * Device Position bits
> + *
> + * 0 is reserved for unknown position in each dimesion. Users can get the
> + * integer value of the device postion by API snd_use_case_geti() via
> + * identifier '_devpos/device', and the returned value is a compostion of
> + * three dimesions.
> + *
> + * NOTE: Users can also get the position string like "Top Left" by API
> + * snd_use_case_get() via identifier 'Position/device".
> + */
> +#define SND_USE_CASE_POS_LEFT           (1<<0)
> +#define SND_USE_CASE_POS_RIGHT          (2<<0)
> +#define SND_USE_CASE_POS_HORIZON_MASK   (0xffff<<0)
> +#define SND_USE_CASE_POS_TOP            (1<<4)
> +#define SND_USE_CASE_POS_BOTTOM         (2<<4)
> +#define SND_USE_CASE_POS_VERTICAL_MASK  (0xffff<<4)
> +#define SND_USE_CASE_POS_FRONT          (1<<8)
> +#define SND_USE_CASE_POS_BACK           (2<<8)
> +#define SND_USE_CASE_DEPTH_MASK         (0xffff<<8)

These are a little restrictive. It would be best to copy the other
examples and use strings as users can easily append new locations by
adding a string to a value list (without having to update any UCM core
code).

We would have a set of the common default locations so that sound
servers could use present this info to users in meaningful ways, bespoke
locations could also be presented to users (but only in string format). 

SectionDevice."Mic".0 {

	EnableSequence [
	     ....
	]

	DisableSequence [
             ....
	]

	Value {
		Location "Left"
		Position "19.5, 34.2, 3.1"
	}
}

Using the above format means we just return the value of location to the
client. We dont have to do any parsing or validation. Same applies for
position.

Liam 


> +
>  /** use case container */
>  typedef struct snd_use_case_mgr snd_use_case_mgr_t;
>  
> @@ -319,6 +341,10 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
>   *        trick upper software layers to e.g. automatically mute speakers when
>   *        headphones are plugged in, but that's application policy
>   *        configuration that doesn't belong to UCM configuration files.
> + *  - Position
> + *       Position of the device, a composition of "Left", "Right", "Top",
> + *       "Bottom", "Front" and "Back". For example, a device speaker may
> + *        have a position like "Front Top".
>   */
>  int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
>                       const char *identifier,
> diff --git a/src/ucm/main.c b/src/ucm/main.c
> index 2d33886..d196a57 100644
> --- a/src/ucm/main.c
> +++ b/src/ucm/main.c
> @@ -801,6 +801,26 @@ long device_status(snd_use_case_mgr_t *uc_mgr,
>          return 0;
>  }
>  
> +/* get the device postion */
> +long device_position(snd_use_case_mgr_t *uc_mgr, const char *device_name)
> +{
> +	struct use_case_device *dev;
> +	struct list_head *pos, *base;
> +
> +	if (uc_mgr->active_verb == NULL)
> +		return -EINVAL;
> +
> +	base = &uc_mgr->active_verb->device_list;
> +	list_for_each(pos, base) {
> +		dev = list_entry(pos, struct use_case_device, list);
> +		if (strcmp(dev->name, device_name) == 0)
> +			return dev->position;
> +	}
> +
> +	/* cannot find the device */
> +	return -1;
> +}
> +
>  long modifier_status(snd_use_case_mgr_t *uc_mgr,
>                       const char *modifier_name)
>  {
> @@ -1645,6 +1665,19 @@ int snd_use_case_geti(snd_use_case_mgr_t *uc_mgr,
>  		} else if (identifier[0] == '_')
>  			err = -ENOENT;
>  #endif
> +		} else if (check_identifier(identifier, "_devpos")) {
> +			if (!str) {
> +				err = -EINVAL;
> +				goto __end;
> +			}
> +
> +			err = device_position(uc_mgr, str);
> +			if (err >= 0) {
> +				*value = err;
> +				err = 0;
> +			} else {
> +				err = -EINVAL;
> +			}
>  		} else
>                          err = -ENOENT;
>                  if (str)
> diff --git a/src/ucm/parser.c b/src/ucm/parser.c
> index 4dc35c3..fc035c3 100644
> --- a/src/ucm/parser.c
> +++ b/src/ucm/parser.c
> @@ -55,6 +55,22 @@ static const char * const component_dir[] = {
>  	NULL,		/* terminator */
>  };
>  
> +struct position {
> +	int val;
> +	const char *id;
> +};
> +
> +/* device positions */
> +static struct position positions[] = {
> +	{ SND_USE_CASE_POS_LEFT, "Left" },
> +	{ SND_USE_CASE_POS_RIGHT, "Right" },
> +	{ SND_USE_CASE_POS_TOP, "Top" },
> +	{ SND_USE_CASE_POS_BOTTOM, "Bottom" },
> +	{ SND_USE_CASE_POS_FRONT, "Front" },
> +	{ SND_USE_CASE_POS_BACK, "Back" },
> +	{ 0, NULL },	/* terminator */
> +};
> +
>  static int filename_filter(const struct dirent *dirent);
>  static int is_component_directory(const char *dir);
>  
> @@ -62,6 +78,30 @@ static int parse_sequence(snd_use_case_mgr_t *uc_mgr,
>  			  struct list_head *base,
>  			  snd_config_t *cfg);
>  
> +static unsigned int parse_position(struct list_head *value_list)
> +{
> +	struct list_head *pos;
> +	struct ucm_value *val;
> +	int i, position = 0;
> +
> +	list_for_each(pos, value_list) {
> +		val = list_entry(pos, struct ucm_value, list);
> +		if (strncmp("Position", val->name, MAX_IDENTIFIER) == 0) {
> +			i = 0;
> +			while (positions[i].id) {
> +				if (strstr(val->data, positions[i].id))
> +					position |= positions[i].val;
> +				i++;
> +			}
> +
> +			return position;
> +		}
> +	}
> +
> +	/* unknown position */
> +	return 0;
> +}
> +
>  /*
>   * Parse string
>   */
> @@ -870,6 +910,7 @@ static int parse_device(snd_use_case_mgr_t *uc_mgr,
>  				uc_error("error: failed to parse Value");
>  				return err;
>  			}
> +			device->position = parse_position(&device->value_list);
>  			continue;
>  		}
>  	}
> diff --git a/src/ucm/ucm_local.h b/src/ucm/ucm_local.h
> index 299a5b9..2537a1d 100644
> --- a/src/ucm/ucm_local.h
> +++ b/src/ucm/ucm_local.h
> @@ -42,6 +42,7 @@
>  
>  #define MAX_FILE		256
>  #define MAX_CARD_LONG_NAME	80
> +#define MAX_IDENTIFIER		32	/* Max length of identifier string */
>  #define ALSA_USE_CASE_DIR	ALSA_CONFIG_DIR "/ucm"
>  
>  #define SEQUENCE_ELEMENT_TYPE_CDEV	1
> @@ -139,6 +140,7 @@ struct use_case_device {
>  
>  	char *name;
>  	char *comment;
> +	int position; /* bits of SND_USE_CASE_POS_, 0 for unknown position */
>  
>  	/* device enable and disable sequences */
>  	struct list_head enable_list;

From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [PATCH - UCM 2/2] ucm: add binary file parse
Date: Tue, 13 Jan 2015 03:04:06 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A8336E90@SHSMSX101.ccr.corp.intel.com>
References: <1421040077-3494-1-git-send-email-han.lu@intel.com>
 <1421040077-3494-2-git-send-email-han.lu@intel.com>
 <s5htwzw834q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6093326147E
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 04:04:33 +0100 (CET)
In-Reply-To: <s5htwzw834q.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

BR,
Han Lu

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, January 12, 2015 10:50 PM
> To: Lu, Han
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] [PATCH - UCM 2/2] ucm: add binary file parse
> 
> At Mon, 12 Jan 2015 13:21:17 +0800,
> han.lu@intel.com wrote:
> >
> > From: "Lu, Han" <han.lu@intel.com>
> >
> > Signed-off-by: Lu, Han <han.lu@intel.com>
> 
> The most important part is missing -- the patch description.  Please give a
> more detailed description, i.e. what this patch does, why this is needed and
> how it's implemented.  (And what does BCSETF mean?  Is another form of
> WTF? :)
> 
Sorry, I have added description and resend the patch, please review. Thanks.
> 
> thanks,
> 
> Takashi
> 
> >
> > diff --git a/src/ucm/main.c b/src/ucm/main.c index 37ae4c8..1496b22
> > 100644
> > --- a/src/ucm/main.c
> > +++ b/src/ucm/main.c
> > @@ -160,11 +160,45 @@ static int open_ctl(snd_use_case_mgr_t *uc_mgr,
> >  	return 0;
> >  }
> >
> > +static int binary_file_parse(snd_ctl_elem_value_t *dst,
> > +			      const char *filepath)
> > +{
> > +	int err = 0;
> > +	FILE *in;
> > +	long len;
> > +	char *res;
> > +	unsigned int idx;
> > +
> > +	in = fopen(filepath, "r");
> > +	if (!in) {
> > +		err = -errno;
> > +		goto __fail;
> > +	}
> > +	fseek(in, 0L, SEEK_END);
> > +	len = ftell(in);
> > +	rewind(in);
> > +	if (len > 512)
> > +		len = 512;
> > +	res = calloc(1, (size_t)len);
> > +	if (res == NULL) {
> > +		err = -ENOMEM;
> > +		goto __fail_nomem;
> > +	}
> > +	fread(res, (size_t)len, 1, in);
> > +	for (idx = 0; idx < len; idx++)
> > +		snd_ctl_elem_value_set_byte(dst, idx, *(res + idx));
> > +	free(res);
> > +      __fail_nomem:
> > +	fclose(in);
> > +      __fail:
> > +	return err;
> > +}
> > +
> >  extern int __snd_ctl_ascii_elem_id_parse(snd_ctl_elem_id_t *dst,
> >  					 const char *str,
> >  					 const char **ret_ptr);
> >
> > -static int execute_cset(snd_ctl_t *ctl, const char *cset)
> > +static int execute_cset(snd_ctl_t *ctl, const char *cset, int isbin)
> >  {
> >  	const char *pos;
> >  	int err;
> > @@ -194,7 +228,10 @@ static int execute_cset(snd_ctl_t *ctl, const char
> *cset)
> >  	err = snd_ctl_elem_info(ctl, info);
> >  	if (err < 0)
> >  		goto __fail;
> > -	err = snd_ctl_ascii_value_parse(ctl, value, info, pos);
> > +	if (isbin)
> > +		err = binary_file_parse(value, pos);
> > +	else
> > +		err = snd_ctl_ascii_value_parse(ctl, value, info, pos);
> >  	if (err < 0)
> >  		goto __fail;
> >  	err = snd_ctl_elem_write(ctl, value); @@ -239,6 +276,7 @@ static int
> > execute_sequence(snd_use_case_mgr_t *uc_mgr,
> >  				goto __fail_nomem;
> >  			break;
> >  		case SEQUENCE_ELEMENT_TYPE_CSET:
> > +		case SEQUENCE_ELEMENT_TYPE_BCSETF:
> >  			if (cdev == NULL) {
> >  				const char *cdev1 = NULL, *cdev2 = NULL;
> >  				err = get_value3(&cdev1, "PlaybackCTL", @@
> -274,7 +312,7 @@
> > static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
> >  					goto __fail;
> >  				}
> >  			}
> > -			err = execute_cset(ctl, s->data.cset);
> > +			err = execute_cset(ctl, s->data.cset, s->isbin);
> >  			if (err < 0) {
> >  				uc_error("unable to execute cset '%s'\n", s-
> >data.cset);
> >  				goto __fail;
> > diff --git a/src/ucm/parser.c b/src/ucm/parser.c index
> > d7517f6..686c883 100644
> > --- a/src/ucm/parser.c
> > +++ b/src/ucm/parser.c
> > @@ -306,6 +306,17 @@ static int parse_sequence(snd_use_case_mgr_t
> *uc_mgr ATTRIBUTE_UNUSED,
> >  			continue;
> >  		}
> >
> > +		if (strcmp(cmd, "bcsetf") == 0) {
> > +			curr->type = SEQUENCE_ELEMENT_TYPE_BCSETF;
> > +			curr->isbin = 1;
> > +			err = parse_string(n, &curr->data.cset);
> > +			if (err < 0) {
> > +				uc_error("error: bcsetf requires a string!");
> > +				return err;
> > +			}
> > +			continue;
> > +		}
> > +
> >  		if (strcmp(cmd, "usleep") == 0) {
> >  			curr->type = SEQUENCE_ELEMENT_TYPE_SLEEP;
> >  			err = snd_config_get_integer(n, &curr->data.sleep);
> diff --git
> > a/src/ucm/ucm_local.h b/src/ucm/ucm_local.h index 87f14a2..80d7335
> > 100644
> > --- a/src/ucm/ucm_local.h
> > +++ b/src/ucm/ucm_local.h
> > @@ -47,6 +47,7 @@
> >  #define SEQUENCE_ELEMENT_TYPE_CSET	2
> >  #define SEQUENCE_ELEMENT_TYPE_SLEEP	3
> >  #define SEQUENCE_ELEMENT_TYPE_EXEC	4
> > +#define SEQUENCE_ELEMENT_TYPE_BCSETF	5
> >
> >  struct ucm_value {
> >          struct list_head list;
> > @@ -63,6 +64,7 @@ struct sequence_element {
> >  		char *cset;
> >  		char *exec;
> >  	} data;
> > +	int isbin;          /* Indicate cset is binary array or ascii array */
> >  };
> >
> >  /*
> > --
> > 1.9.1
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >

From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
Subject: Re: [RFC] New method for adding AC97
	SNDRV_CTL_ELEM_TYPE_ENUMERATED controls
Date: Thu, 10 Feb 2005 17:22:14 +0000
Message-ID: <1108056133.4533.161.camel@cearnarfon>
References: <1108053190.4533.140.camel@cearnarfon>
	 <s5hbras1guc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hbras1guc.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-02-10 at 17:10, Takashi Iwai wrote:

> Instead, we can pass the pointer of the enum record (cast to unsigned
> long) in private_value field, so that the enum texts can be given
> separately.  For example,
> 
> struct ac97_enum {
> 	unsigned char reg;
> 	unsigned char shift_l;
> 	unsigned char shift_r;
> 	unsigned short mask;
> 	const char **texts;
> };
> 
> static int snd_ac97_info_enum(snd_kcontrol_t *kcontrol,
> 				snd_ctl_elem_info_t *info)
> {
> 	struct ac97_enum *rec = (struct ac97_enum *)kcontrol->priavate_value;
> 	...
> 	strcpy(uinfo->value.enumerated.name, rec->texts[uinfo->value.enumerated.item]);
> 	...
> }

That's fine with me and cleaner.

I'll submit a patch.

Liam



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

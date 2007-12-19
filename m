From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] Dmux mixer conflict
Date: Wed, 19 Dec 2007 09:07:56 -0500
Message-ID: <476925BC.90008@embeddedalley.com>
References: <47684C45.2080601@embeddedalley.com> <s5hd4t3vxsz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp101.biz.mail.mud.yahoo.com (smtp101.biz.mail.mud.yahoo.com
	[68.142.200.236]) by alsa0.perex.cz (Postfix) with SMTP id 3245824615
	for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2007 15:07:50 +0100 (CET)
In-Reply-To: <s5hd4t3vxsz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Tim Gardner <tim.gardner@canonical.com>, Jose_De_La_Rosa@Dell.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 18 Dec 2007 17:40:05 -0500,
> Matthew Ranostay wrote:
>   
>> DMUX mixers need to be created before input source mixers, otherwise 
>> some STAC9228 codecs fail to record correctly or at all.
>>
>> ---
>> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
>>     
>
> The fix looks doubtful.  The order of mixer elements should be
> irrelevant with the functionality.
>
> I suspect it might be the result of failure of 'alsactl restore'.
> Some distros don't call alsactl properly with -F option.
> (This option is set default in the latest HG version now.)
>
>
> Takashi
>
>   
>> diff -r fbe3540c8df4 pci/hda/patch_sigmatel.c
>> --- a/pci/hda/patch_sigmatel.c	Tue Dec 18 18:05:52 2007 +0100
>> +++ b/pci/hda/patch_sigmatel.c	Tue Dec 18 15:27:34 2007 -0700
>> @@ -834,15 +834,16 @@ static int stac92xx_build_controls(struc
>>  	if (err < 0)
>>  		return err;
>>  
>> -	for (i = 0; i < spec->num_mixers; i++) {
>> -		err = snd_hda_add_new_ctls(codec, spec->mixers[i]);
>> -		if (err < 0)
>> -			return err;
>> -	}
>>  	if (spec->num_dmuxes > 0) {
>>  		stac_dmux_mixer.count = spec->num_dmuxes;
>>  		err = snd_ctl_add(codec->bus->card,
>>  				  snd_ctl_new1(&stac_dmux_mixer, codec));
>> +		if (err < 0)
>> +			return err;
>> +	}
>> +
>> +	for (i = 0; i < spec->num_mixers; i++) {
>> +		err = snd_hda_add_new_ctls(codec, spec->mixers[i]);
>>  		if (err < 0)
>>  			return err;
>>  	}
>>     
>
>   
Ok thanks, I tried that and now it works as before.

-Matt Ranostay

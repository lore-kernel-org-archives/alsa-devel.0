From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: Re: [alsa-cvslog] CVS: BEFORE REVERT  [SUCCESS]
   C-Media CMI9761 -A- type, WORKING MASTER, PCM ON 1. DXS SLIDER!
Date: Thu, 17 Feb 2005 19:06:56 +0100
Message-ID: <4214DD40.3070102@gmx.de>
References: <E1D1Ttl-0000lb-In@sc8-pr-cvs1.sourceforge.net>	<4213BB44.5060702@gmx.de> <s5hbrajs9zj.wl@alsa2.suse.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hbrajs9zj.wl@alsa2.suse.de>
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

Takashi Iwai wrote:
> At Wed, 16 Feb 2005 22:29:40 +0100,
> thomas schorpp wrote:
> 
>>- arts works with pcm fine
>>- working master vol slider(!) (kmix)
>>- working pcm vol regulation on 1. dxs slider (rest 3 no sound reaction)
> 
> 
> (snip)
> 
> 
>>>Revert the last addition for CM9761A support.  The codec doesn't
>>>support the real control of Master
>>
>>yes, it does fine for my chip , sorry.
>>
>>/PCM volumes, too.
> 
> 
> Hmm, I'm really confused.  Both the comments above look
> contradictionary.

me too ;). so let me first excuse for that "thing" i called patch v0.1 
tonight. im sorry i cant afford a prebuild-kernel distributors 
requirements and better read your comprehensive docs on the homepage 
before coding again. i thank you again for getting my chip to work based 
on 1.73 cvs. i can live with custom patched kernels for my own needs.

although i would gladly help you out by providing verified infos on this 
newer chip 1000s of users may have got, so you can work out a common 
solution.

so much for priorities and requirements.

> 
> Let me ask again:  In the older version, does PCM volume work, that
> is, it really changes the output volume (not only mute/unmute)?
> Does Master volume work as well on your chip?

which version?  i repeat my notices from tonight:

2.6.10 kernel.org kernel:
- master vol slider drives real volume at least for looped through 
lines. (dont know if a real hardware gain driver exists, i cant find the 
list mentioned sw volume code.)
- master pcm slider exists but seems no affect, but typical hardware 
switching noise on enable/disable knob
- no output on pcm dac audio (tried workarounds for hours)

patch.c cvs rev 1.73 et al:
- master vol slider drives real volume for looped through lines. no 
affect on pcm.
-alsa pcm volume working on dxs 1 slider.
-oss pcm volume working on dxs 2 slider.
- master pcm slider missing. (which code determines this?)

rev 1.74:
- master / pcm sliders missing, cant affect any volumes, lines looped 
through, input regulateable with cd and aux input sliders.
- pcm not working.

> 
> 
> Note that the Master and PCM volumes are _removed_ because they don't
> work and are only confusing.  It's intentional.  They _must_ disappear
> in the latest version.
> 
> If CM9761-A- provides the real PCM/Master volume control, we should
> get them back again.  But, this essential information has been
> missing.   Please let me know _this_ clearly above all subtle things!
> 

see above. "real" means hardware, yes?

btw: you got my 2 mails from tonight? windos driver reports rev 8D for 
this chip.

pls answer this question: what are those 32bit xxxxxxxx_rev ids?
have you defined it?
where do you get it from the chip?
cant find the function asking the chip. ac97->id reads only defines 
doesnt it?

> 
> 
>>>Instead, fixed the default multi-channel register setting now.
>>>
>>
>>why?
>>not verified. source of info? are you sure thats the -A- type, you got 
>>for testing? who verified?
> 
> 
> Very much confision of debug information...

ok. you stated you got rev 83 mine should be 8d.
that would be clearer then.

> 
> 
> 
>>oops! sound gone after doing this:
> 
> 
> How about the attached patch?

would try it, but pls comment those reg bit setting(?) in short.
you stated you got no register specs, is this guessed?

tom

> 
> 
> Takashi
> 
> 
> ------------------------------------------------------------------------
> 
> Index: alsa-kernel/pci/ac97/ac97_patch.c
> ===================================================================
> RCS file: /suse/tiwai/cvs/alsa/alsa-kernel/pci/ac97/ac97_patch.c,v
> retrieving revision 1.76
> diff -u -r1.76 ac97_patch.c
> --- alsa-kernel/pci/ac97/ac97_patch.c	16 Feb 2005 18:25:30 -0000	1.76
> +++ alsa-kernel/pci/ac97/ac97_patch.c	17 Feb 2005 11:11:01 -0000
> @@ -2038,8 +2038,8 @@
>  
>  	/* CM9761 has no Master and PCM volume although the register reacts */
>  	ac97->flags |= AC97_HAS_NO_MASTER_VOL | AC97_HAS_NO_PCM_VOL;
> -	snd_ac97_write_cache(ac97, AC97_MASTER, XXXXXXX 0x8000 XXXXXXXXXX); <----(?)
> -	snd_ac97_write_cache(ac97, AC97_PCM, 0x8000);
> +	snd_ac97_write_cache(ac97, AC97_MASTER, 0x8808);
> +	snd_ac97_write_cache(ac97, AC97_PCM, 0x8808);
>  
>  	ac97->spec.dev_flags = 0; /* 1 = model 82 revision B */
>  	if (ac97->id == AC97_ID_CM9761_82) {



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

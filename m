From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: Re: [alsa-cvslog] CVS: BEFORE REVERT  [SUCCESS]
   C-Media CMI9761 -A- type, WORKING MASTER, PCM ON 1. DXS SLIDER!
Date: Thu, 17 Feb 2005 20:12:44 +0100
Message-ID: <4214ECAC.8040003@gmx.de>
References: <E1D1Ttl-0000lb-In@sc8-pr-cvs1.sourceforge.net>	<4213BB44.5060702@gmx.de>	<s5hbrajs9zj.wl@alsa2.suse.de>	<4214DD40.3070102@gmx.de> <s5hvf8rqb7k.wl@alsa2.suse.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hvf8rqb7k.wl@alsa2.suse.de>
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
> At Thu, 17 Feb 2005 19:06:56 +0100,
> thomas schorpp wrote:
> 
>>Takashi Iwai wrote:
>>
>>>At Wed, 16 Feb 2005 22:29:40 +0100,
>>>thomas schorpp wrote:
>>>
>>>
>>>>- arts works with pcm fine
>>>>- working master vol slider(!) (kmix)
>>>>- working pcm vol regulation on 1. dxs slider (rest 3 no sound reaction)
>>>
>>>
>>>(snip)
>>>
>>>
>>>
>>>>>Revert the last addition for CM9761A support.  The codec doesn't
>>>>>support the real control of Master
>>>>
>>>>yes, it does fine for my chip , sorry.
>>>>
>>>>/PCM volumes, too.
>>>
>>>
>>>Hmm, I'm really confused.  Both the comments above look
>>>contradictionary.
>>
>>me too ;). so let me first excuse for that "thing" i called patch v0.1 
>>tonight. im sorry i cant afford a prebuild-kernel distributors 
>>requirements and better read your comprehensive docs on the homepage 
>>before coding again. i thank you again for getting my chip to work based 
>>on 1.73 cvs. i can live with custom patched kernels for my own needs.
>>
>>although i would gladly help you out by providing verified infos on this 
>>newer chip 1000s of users may have got, so you can work out a common 
>>solution.
>>
>>so much for priorities and requirements.
>>
>>
>>>Let me ask again:  In the older version, does PCM volume work, that
>>>is, it really changes the output volume (not only mute/unmute)?
>>>Does Master volume work as well on your chip?
>>
>>which version? 
> 
> 
> I meant the last working version you tried before (now I assume 2.6.10
> kernel?)
> 

changed motherboard, running 2.6.10.

> 
>>i repeat my notices from tonight:
>>
>>2.6.10 kernel.org kernel:
>>- master vol slider drives real volume at least for looped through 
>>lines. (dont know if a real hardware gain driver exists, i cant find the 
>>list mentioned sw volume code.)
> 
> 
> The looped-through lines = analog inputs like Line, Mic, CD?

yes.

> And the Master volume does NOT affect the PCM playback volume?

does not on any version. just playing a clip with xmms (oss-iface) 
volume regulation only with dxs 2 slider. verified.

> 
> 
>>- master pcm slider exists but seems no affect, but typical hardware 
>>switching noise on enable/disable knob
on 2.6.10.
> 
> 
> OK.
> 
> 
>>- no output on pcm dac audio (tried workarounds for hours)
> 
> 
> Err, with 2.6.10, you got no PCM playback output?

no output, verified with arts and xmms and xine, aplay warns about rate 
setting, ecasound with no complain messages.
> 
> 
> 
>>patch.c cvs rev 1.73 et al:
>>- master vol slider drives real volume for looped through lines. no 
>>affect on pcm.
> 
> 
> So, it has no influence on PCM...  Interesting.
> Possibly there is a mysterious register bit switch to turn this on/off
> :)  (For example, STAC9750/51 controls the PCM-bypass mode by misusing
> GENERAL_PURPOSE register bit 15.)

agree. due to hardware like clicking sound on enable/disable the slider, 
there should be hardware, good.

but how to find register and affecting bitsetting?

> 
> 
>>-alsa pcm volume working on dxs 1 slider.
>>-oss pcm volume working on dxs 2 slider.
> 
> 
> The assignment of DXS channels are quite casual.

not understood, got too few background on that.
> 
> 
>>- master pcm slider missing. (which code determines this?)
> 
> 
> In ac97_codec.c:check_volume_resolution().
> This means that AC97_PCM register returns only a certain value
> (0xX808).  So, the expected behavior.

understood, thx.

> 
> 
>>rev 1.74:
>>- master / pcm sliders missing, cant affect any volumes, lines looped 
>>through, input regulateable with cd and aux input sliders.
> 
> 
> This is intentional.
> 
> 
>>- pcm not working.
> 
> 
> This is not :)
> 
> 
> 
>>>Note that the Master and PCM volumes are _removed_ because they don't
>>>work and are only confusing.  It's intentional.  They _must_ disappear
>>>in the latest version.
>>>
>>>If CM9761-A- provides the real PCM/Master volume control, we should
>>>get them back again.  But, this essential information has been
>>>missing.   Please let me know _this_ clearly above all subtle things!
>>>
>>
>>see above. "real" means hardware, yes?
> 
> 
> Yes.
> 
> 
>>btw: you got my 2 mails from tonight? windos driver reports rev 8D for 
>>this chip.
> 
> 
> Hmm?  I see a string "REV_50" in the screenshot.

no. thats the vias rev:

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
         Subsystem: Unknown device 1849:9761

> 
> 
>>pls answer this question: what are those 32bit xxxxxxxx_rev ids?
> 
> 
> Which value do you mean?

that:

#define AC97_ID_AK4540		0x414b4d00 <--- source? chip asked?

> 
> If it's ac97->id, this is just the combination of vendor_id1 (7c) and
> vondor_id2 (7e) registers as (vendor_id1<<16) | (device_id2).
> AFAIK, CM9761 has three different models and each of
> them has different vendor ID2 value: 0x4978, 0x4982 and 0x4983.
> Yours looks like the last one.

i assume it should be 0x498d for mine then (windos driver screenshot).

> 
> 
>>have you defined it?
>>where do you get it from the chip?
>>cant find the function asking the chip. ac97->id reads only defines 
>>doesnt it?
> 
> 
> I don't understand your question here.

thx answered.

> 
> 
> 
>>>>>Instead, fixed the default multi-channel register setting now.
>>>>>
>>>>
>>>>why?
>>>>not verified. source of info? are you sure thats the -A- type, you got 
>>>>for testing? who verified?
>>>
>>>
>>>Very much confision of debug information...
>>
>>ok. you stated you got rev 83 mine should be 8d.
>>that would be clearer then.
> 
> 
> The value is just taken from the vendor_id2 register value (the lower
> byte).

ok.

> 
> 
>>>>oops! sound gone after doing this:
>>>
>>>
>>>How about the attached patch?
>>
>>would try it, but pls comment those reg bit setting(?) in short.
>>you stated you got no register specs, is this guessed?
> 
> 
> Yes, just a guess from cmedia's driver code and trial-and-error.

ok.

> 
> 
> Takashi
> 
> 

thx
tom


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

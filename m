From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [RFC/RFT] HDMI/DP CEA-861-E+ channel allocations
	0x20+
Date: Tue, 05 Nov 2013 16:18:22 +0200
Message-ID: <5278FE2E.8010802@iki.fi>
References: <52742070.1080904@iki.fi> <s5hhabrvua2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B693261178
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 15:24:07 +0100 (CET)
In-Reply-To: <s5hhabrvua2.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Fengguang Wu <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

05.11.2013 15:43, Takashi Iwai kirjoitti:
> At Fri, 01 Nov 2013 23:43:12 +0200,
> Anssi Hannula wrote:
>>
>> Hi all!
>>
>> Currently we allow the use of CA values up to 0x31 as defined in
>> CEA-861-E/F. However, only CA values up to 0x19 are defined in
>> CEA-861-B/C/D.
>>
>> HDMI specification 1.4b specifies that the CA field is to be filled
>> according to CEA-861-D, and DisplayPort 1.1a according to CEA-861-C.
>>
>> The ELD (EDID-Like Data) format as specified by Intel HDA specification
>> 1.0a has a speaker allocation bitmask that only accommodates speakers
>> present in CEA-861-D; all of the 0x20+ CAs contain speakers that do not
>> have a corresponding bit in ELD.
>>
>> Using a CA value unsupported by sink will cause either a completely
>> silent output or stereo output, so I think we should try to prevent
>> selecting such channel maps, if feasible.
>>
>> However, before doing anything, I wonder if they are actually supported
>> by some newer receivers (mine is 4 years old). It'd be good if someone
>> with a newish receiver could try the below :)
>> To test this, one can run (replacing XX and YY with appropriate values
>> from "aplay -L") on *sound git master*:
>> speaker-test -c6 -Dhdmi:CARD=XX,DEV=YY -m FL,FR,RL,RR,FLH,FRH
>> If you get some output for the RL/RR speakers, that should mean that
>> 0x20+ CAs are supported. If there is no output except on FL/FR and there
>> is proper output without the "-m FL,FR,RL,RR,FLH,FRH", this means that
>> 0x20+ CAs are not supported.
>>
>> I think there are about these options for us to take:
>> a) drop 0x20+ CAs from channel_allocations altogether
>> b) put the 0x20+ CAs under a module parameter
>> c) only allow 0x20+ CAs if any CEA-861-E+ only speakers are specified
>>    in EDID. However, as ELD doesn't have bits for these, we'd have to
>>    employ some non-standard bits in ELD or communicate directly with
>>    video driver.
>> d) do nothing, allow the 0x20+ CAs.
>>
>> IMHO we should do something, since players using ALSA channel mapping
>> could just automatically select a manual channel map that uses an
>> unsupported 0x20+ CA if the source audio stream contains such channels...
>>
>> WDYT?
> 
> Practical options as of now are either (b) or (d).
> 
> Extending EDID in a non-standard way is no-go.  Better to put finger
> away.  OTOH, if we're going to that direction, we should rather build
> a better / more direct communication way with the graphics driver,
> instead.  This would make things in Intel graphics easier, too, for
> example.

Yeah, another benefit of that would be getting the sink
manufacturer/product/name etc on the older (i.e. all but the very
latest) ATI/AMD cards. Of course that is a rather limited benefit, and
I'm not sure this 0x20+ CAs stuff is worth it either...

> And (a) isn't the best option, obviously.
> 
> Now the question is whether (b) or (d).  Can 0x20+ CA be chosen by
> default from any applications without extra setup?  If it can be done
> only via user's manual configuration or option, it's essentially
> user's responsibility.  If so, adding an option to the module is
> nothing but one more annoyance.  Then I'd take (d).
> 
> If 0x20+ can be selected automatically in some situations, it'd make
> sense to block it as default, so (b) would be the choice.  But I guess
> it won't happen normally.

Well, I guess not many applications have ALSA chmap support yet, so the
answer is "not chosen by default" for now.

I'm going to probably be writing ALSA chmap support for XBMC, and I will
probably try to set a channel map according to the source audio stream
channel map (if possible) to avoid software remapping, though. I don't
have the exact behavior planned out yet, though, but unless 0x20+ CAs
are blocked by ALSA, I think I'll just avoid using the E+ speaker
positions by default for HDMI in XBMC ALSA code.

For the record, the E+ speaker positions are FLH, FRH, FCH, FLW, FRW,
TC, so they aren't very common. And since HDMI 1.x supports just 8 PCM
channels, using those in discrete PCM mode means dropping some of the
standard 7.1 speakers (passthrough is of course a different story).

Also, even though Peter's receiver accepted the CAs, the receiver
channel mapping was somewhat weird (e.g. front wide channels were mapped
to rear speakers).

I guess I'm leaning towards (d)...

-- 
Anssi Hannula

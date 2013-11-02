From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [RFC/RFT] HDMI/DP CEA-861-E+ channel allocations
 0x20+
Date: Sat, 02 Nov 2013 17:29:41 +0200
Message-ID: <52751A65.3090705@iki.fi>
References: <52742070.1080904@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id D23302615DD
 for <alsa-devel@alsa-project.org>; Sat,  2 Nov 2013 16:29:46 +0100 (CET)
In-Reply-To: <52742070.1080904@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Fengguang Wu <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

01.11.2013 23:43, Anssi Hannula kirjoitti:
> Hi all!
> 
> Currently we allow the use of CA values up to 0x31 as defined in
> CEA-861-E/F. However, only CA values up to 0x19 are defined in
> CEA-861-B/C/D.
> 
> HDMI specification 1.4b specifies that the CA field is to be filled
> according to CEA-861-D, and DisplayPort 1.1a according to CEA-861-C.
> 
> The ELD (EDID-Like Data) format as specified by Intel HDA specification
> 1.0a has a speaker allocation bitmask that only accommodates speakers
> present in CEA-861-D; all of the 0x20+ CAs contain speakers that do not
> have a corresponding bit in ELD.
> 
> Using a CA value unsupported by sink will cause either a completely
> silent output or stereo output, so I think we should try to prevent
> selecting such channel maps, if feasible.
> 
> However, before doing anything, I wonder if they are actually supported
> by some newer receivers (mine is 4 years old). It'd be good if someone
> with a newish receiver could try the below :)
> To test this, one can run (replacing XX and YY with appropriate values
> from "aplay -L") on *sound git master*:
> speaker-test -c6 -Dhdmi:CARD=XX,DEV=YY -m FL,FR,RL,RR,FLH,FRH
> If you get some output for the RL/RR speakers, that should mean that
> 0x20+ CAs are supported. If there is no output except on FL/FR and there
> is proper output without the "-m FL,FR,RL,RR,FLH,FRH", this means that
> 0x20+ CAs are not supported.

We tested with Peter's Marantz NR1402 (introduced 2011), and it does
seem to support 0x20+ CAs (it drops unmappable channels, but doesn't
fall back to stereo only either so it clearly recognizes the mappings).

> I think there are about these options for us to take:
> a) drop 0x20+ CAs from channel_allocations altogether
> b) put the 0x20+ CAs under a module parameter
> c) only allow 0x20+ CAs if any CEA-861-E+ only speakers are specified
>    in EDID. However, as ELD doesn't have bits for these, we'd have to
>    employ some non-standard bits in ELD or communicate directly with
>    video driver.
> d) do nothing, allow the 0x20+ CAs.
> 
> IMHO we should do something, since players using ALSA channel mapping
> could just automatically select a manual channel map that uses an
> unsupported 0x20+ CA if the source audio stream contains such channels...

So I guess dropping them completely would be not be very nice... not
immediately sure what would be the best way forward, then, though...

> WDYT?
> 


-- 
Anssi Hannula

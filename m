Return-Path: <SRS0=ZrTp=W5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA63C3A59E
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 21:40:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B98B22CF7
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 21:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eh+Jfftn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B98B22CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatomb.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D2E01671;
	Mon,  2 Sep 2019 23:39:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D2E01671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567460411;
	bh=CDbeVI7/POkBp66A4O0JHszx09vgnxhTdSqIPNpDirQ=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eh+JfftnW0yhYymWwhMY8uEpugcbDnJM8rsoKQDFUPbSqfgUpEEJPQnX2+Bc5tyuI
	 mTy7WhUOusZMcNVptiuNnwvuQI1WXLmaRSY4QkubfKpOKKRySHwwcgMw6dxEsrBX/v
	 6qRqGD4LzsVqCOMbh/I6wqNIkXSYaTJ3AXGv9lBs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3B56F80394;
	Mon,  2 Sep 2019 23:39:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82252F803D0; Mon,  2 Sep 2019 23:39:18 +0200 (CEST)
Received: from mail1.xn--80adja5bqm.su (xn--80adja5bqm.su [45.62.210.217])
 by alsa1.perex.cz (Postfix) with ESMTP id 3F0C6F80392
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2019 23:39:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F0C6F80392
Received: by mail1.xn--80adja5bqm.su (Postfix, from userid 1000)
 id 65763209D35A; Mon,  2 Sep 2019 23:39:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.xn--80adja5bqm.su 65763209D35A
Date: Mon, 2 Sep 2019 23:39:12 +0200
From: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
To: Takashi Iwai <tiwai@suse.de>
Message-Id: <20190902213912.GA6630@xn--80adja5bqm.su>
References: <20190819195714.GA2737@xn--80adja5bqm.su>
 <s5hef1dthbk.wl-tiwai@suse.de>
 <20190822203031.GA22363@xn--80adja5bqm.su>
 <s5h5zmg48u2.wl-tiwai@suse.de>
 <20190829103805.GA1525@xn--80adja5bqm.su>
 <s5hsgpk2os6.wl-tiwai@suse.de>
 <20190830114510.GA10027@xn--80adja5bqm.su>
 <s5hzhjqzvu5.wl-tiwai@suse.de>
 <20190901192737.GB28125@xn--80adja5bqm.su>
 <s5hlfv7jj2r.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <s5hlfv7jj2r.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Surround speaker connection on Acer 8951G
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Takashi,

On Mon, Sep 02, 2019 at 08:41:48AM +0200, Takashi Iwai wrote:
> > Simpler...yes and no :) From what I have seen, all "default" Pulse profiles are
> > replaced by the UCM, meaning that if I wanted them, I'd have to replicate
> > all of them in my conf. It would work though. 
> 
> You just need to override codec->card->longname to some unique string
> and use it as UCM profile name.
> Check alc1220_fixup_gb_dual_codecs() as an example.

no, no, that's not what I meant. I did understand how to tell PulseAudio
which UCM to load, i.e. via the longname just as you wrote above.

However, what I then observed was: PulseAudio loads my UCM configuration and
pavucontrol lists only the profiles which I have specified in the UCM.

So what I was trying to say is that I lose all the stock profiles that
PulseAudio creates automatically and that list is quite long (i.e. 
Analog Surround 5.1 Output + Analog Stereo Input, same for 5.0, 4.1, 4.0 and
so on), basically the stock profiles get dropped in favor of the ones that I 
provide in the UCM.
 
> > Meanwhile I also figured out that /proc/asound/card0/codec#0 is
> > providing this info as well:
> > 
> >   IO[1]: enable=0, dir=1, wake=0, sticky=0, data=0, unsol=0
> > 
> > So the value seems to be 0 and I can add an explicit SET_GPIO_DATA verb quirk
> > to set it in addition to SET_GPIO_DIRECTION, right?
> 
> Yes.  You need to set SET_GPIO_MASK=0x02, SET_GPIO_DIRECTION=0x02 and
> SET_GPIO_DATA=0x00 for that bit.

Thanks a lot, I read the hda-intel spec on GPIOs a couple of times, but I
was somehow not getting the idea about the GPIO MASK, now it's clear what
I was missing. I'll add those three verbs to my quirk.

[...] 
> > The above seems to work quite well for me and does exactly what I want, 
> > PulseAudio presents all the autogenerated profiles and handles mic and line 
> > jacks itself, at the same time all unwanted speakers get muted as soon as I 
> > plug in my headphones into the jack pin that is shared with my surround
> > speakers. Of course Pulse does not "know" anything about the headphones and
> > does not switch profiles, but I don't mind since the user experience is
> > as expected.
> 
> Hm, OK, this amount of changes are acceptable.  The hardware behavior
> itself is weird, and we have already tricky code, so it's no problem
> to keep some yet another tricky code as long as it's described enough
> in the comments and the changelog.

Great, thank you! I will prepare a patch then, I like this approach a lot
more than the UCM variant.
 
> > My earlier attempt was to send the pin widget control verbs directly, however
> > then the pin got reconnected as soon as playback started.
> > This does not happen when I use snd_hda_set_pin_ctl_cache(), but I am not 
> > quite sure about the cache, should I use the _cache function or the
> > uncached one?
> 
> This should work, AFAIK.  The *_set_pin_ctl_cache() remembers the last
> written value, as its name stands.  That's restored again at the PM
> resume, for example.
> 
> The PM resume does re-trigger the jack detection callback, so it'll be
> written up again in anyway, though.

Thanks for the explanation, seems I picked the right function.
 
> > Another thing I am not sure about is, if I somehow disrupt power management by 
> > doing what I do? I saw that for instance restore_shutup_pins() does modify 
> > those connections as well and I would basically overwrite whatever it did
> > in the case that the user plugs/unplugs the headphones.
> 
> This should be fine as-is.  The shutup_pins() clears pins temporarily
> and the pins are resumed to the cached values in return.

I was more thinking of the scenario that shutup_pins() cleared them,
some time afterwards the user unplugs headphones which triggers my jack-detect 
callback where I reconnect the pins, although the "shutup" condition is still
valid. Maybe I'm overthinking it. If this is not a problem, then I'm indeed
almost done - easier than I thought :)
 
> One thing to be improved would be to drop the surround jack control.
> Adjust the pin config to different value with the fixed pin
> connection, so that the auto-parser won't create the "Surround Jack"
> control.  This isn't needed by PA or else, otherwise it may be
> confusing.

Hmm, if I understand you correctly, then you are referring to bits 31:30
Port Connectivity? 

It does not seem to work that way... I tried all combinations and I either
lose jack detect support or I lose the 5.1 profile in Pulse.

With these settings snd_hda_jack_detect_state() never returns HDA_JACK_PRESENT:
0x91130012 [Fixed] Speaker at Int Rear
0xd1130012 [Both] Speaker at Int Rear

I can plug or unplug, I get called, but I always receive HDA_JACK_PHANTOM

snd_hda_jack_detect_state() works fine with "no physical connection to port":
0x51130012 [N/A] Speaker at Int Rear

But with the above pin setting I "lose" the 5.1 profile in Pulse...

Which leaves me with with what I had before:
0x11130012 [Jack] Speaker at Int Rear

Am I missing something or did you mean some other setting? Should I be
using a different function instead of snd_hda_jack_detect_state() to
check my jack state in the callback?


I will study the kernelnewbies howto a bit more  (it's my first
kernel patch submissoin) and will follow up with a patch soon.

Thank you very much for your help! I would not have come so far
without your support, really happy that my audio finally works :)

Kind regards,
Jin

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

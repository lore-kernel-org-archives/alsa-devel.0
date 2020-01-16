Return-Path: <SRS0=iD9L=3F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49203C33CB1
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 07:54:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BCC20748
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 07:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VQOogcPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BCC20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBDE8179F;
	Thu, 16 Jan 2020 08:54:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBDE8179F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579161293;
	bh=87FEo8sqP3pLxoYPuCmN1kyNAS2kGyly/yaPpKfXckU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VQOogcPicsbJs4q4/R29QnPmWC2lw1EM2ayD28T5fQ6uMdUlG1YMo2/YGiQXzM1+Y
	 hXuKrxSFIHoNduQglQS00Z4G0VkBWtAC9mhlZ/IN1VQ+1Fhu2ZL7ZAKPjXs/0dATdV
	 IY+BAPwxaJm2IMy6ZhUkEXOeGpvKgB0GX6R7eL6I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2F63F8014D;
	Thu, 16 Jan 2020 08:54:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8FB5FF8014E; Thu, 16 Jan 2020 08:53:59 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47383F800B9
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 08:53:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47383F800B9
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Jan 2020 23:53:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,325,1574150400"; d="scan'208";a="257180162"
Received: from kekkonen.fi.intel.com ([10.237.72.68])
 by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2020 23:53:48 -0800
Message-ID: <dd56684f55230c28af99a36736e53144a84e4d87.camel@linux.intel.com>
From: Jaska Uimonen <jaska.uimonen@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>, "Sridharan, Ranjani"
 <ranjani.sridharan@intel.com>
Date: Thu, 16 Jan 2020 09:42:24 +0200
In-Reply-To: <s5heevzq3wn.wl-tiwai@suse.de>
References: <CAFQqKeV3fG8=DaV4_rGDL3QH7gG9zEHwS9T41aOag+-cNN9wnQ@mail.gmail.com>
 <s5hlfq8pkza.wl-tiwai@suse.de>
 <CAFQqKeWu+Xmg_j7CgETnu_Y-dcFMXWbC5jyaXR6N7v-d5GwzwA@mail.gmail.com>
 <s5heevzq3wn.wl-tiwai@suse.de>
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Cc: "Vehmanen, Kai" <kai.vehmanen@intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>, "Uimonen,
 Jaska" <jaska.uimonen@intel.com>,
 Pierre-louis Bossart <pierre-louis.bossart@intel.com>
Subject: Re: [alsa-devel] Question about runtime PM for HDA codecs
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

On Thu, 2020-01-16 at 08:03 +0100, Takashi Iwai wrote:
> On Wed, 15 Jan 2020 21:28:20 +0100,
> Sridharan, Ranjani wrote:
> > [1  <text/plain; UTF-8 (7bit)>]
> > 
> > On Wed, Jan 15, 2020 at 11:40 AM Takashi Iwai <tiwai@suse.de>
> > wrote:
> > 
> >     On Wed, 15 Jan 2020 19:15:40 +0100,
> >     Sridharan, Ranjani wrote:
> >     >
> >     > Hi Takashi,
> >     >
> >     > Can I please bother you with a question about how to handle
> > the
> >     situation
> >     > with runtime PM for HDA codec on one of the Intel CML-based
> > platforms
> >     with
> >     > an ALC285 codec.
> >     > Basically, the problem we're facing is that when using the
> > SOF driver,
> >     > jack detection doesn't seem to work as intended because the
> > codec gets
> >     > suspended right after the headset is plugged in.
> >    
> >     The codec going to the runtime suspend is actually the right
> >     behavior.  Even the bus goes down if the codec has
> > AC_PWRST_CLKSTOP
> >     and AC_PWRST_EPSS capabilities, the link goes also down.  But
> > this
> >     means that the irq is still triggered upon the jack detection
> > event
> >     even in D3 state.
> >     I guess this implementation is missing in SOF DSP side.
> > 
> > We do have the WAKEEN feature implemented in SOF for capturing the
> > jack
> > detecting events when the SOF device is in D3. We have this feature
> > working as
> > expected on some previous platforms.
> 
> Which codec was it?
> 
> > The problem specific to the ALC285 codec.
> 
> AFAIK, there is no specific change to ALC285 that is relevant with
> runtime PM.
> 
> 
> >     > After a bit of experimenting, what we found was that calling
> >     > snd_hda_set_power_save() with a delay of 0 or something > 0,
> > both help
> >     with
> >     > fixing the problem.
> >     >
> >     > But, I have a basic question about this. What is the
> > expectation for
> >     > enabling the codec runtime PM?
> >     > I see that the legacy driver calls snd_hda_set_power_save()
> > based on the
> >     > CONFIG_SND_HDA_POWER_SAVE_DEFAULT value. In the case of SOF,
> > we do not
> >     > explicitly set this value so it is 0 by default. Also, when
> > the codec is
> >     > registered, the runtime PM for the codec is enabled by
> > default without
> >     > checking if the power_save delay is set to 0 or not. And
> > later when the
> >     > snd_hda_set_power_save() is called from the legacy HDA driver
> > probe, it
> >     > sets the use of auto suspend and the delay to be used based
> > on the
> >     config.
> >    
> >     The runtime setup purely depends on the user's configuration. 
> > As
> >     default, kernel may set to certain value via Kconfig, and some
> > codecs
> >     (e.g. HDMI) prefer the runtime PM enablement as default.  Other
> > than
> >     that, it's supposed to be set explicitly via sysfs, typically
> > from
> >     udev rules.
> >    
> >     The driver initial code does set up some default value from
> > historical
> >     reasons, but basically the setup is done from user-space.
> >    
> >     > Would it be correct to remove the pm_runtime_enable() call
> >     > in snd_hda_codec_register() and let the codec runtime PM
> > enabling be set
> >     > with the call to snd_hda_set_power_save() for both the legacy
> > HDA driver
> >     > and the SOF driver?
> >    
> >     The basic problem isn't about how the runtime PM is set.  It
> > can be
> >     changed at any time, and the driver should work no matter how
> > it is
> >     set.
> > 
> > In this case then, I suppose it is up to the SOF driver to set the
> > auto
> > suspend delay to define the expected default behaviour?
> 
> Yes and no.  User can still set the value and the driver still needs
> to behave correctly no matter what value is set.
> 
Takashi, AFAIK with legacy Intel HDA you are always setting
suspend_delay to 0 ("PM off") or some value in seconds. So I don't 
even know how you would configure immeadiate suspend with legacy HDA.

With SOF we we're able to cause this immediate suspend for the codec by
not calling any HDA delay setting function (sof probe vs. intel hda
probe).
 
This has been working so far, but we noticed that Mic Jack detection
with some codecs didn't like this immediate suspend and we also got
some informal info from Realtek folks that the reason could be the
quick suspend. And indeed if I set HDA suspend delay from SOF 
to SOF default 2s or 0 (PM off) the Mic Jack starts to work.

So setting the delay from SOF solves the Mic Jack issue, but there is 
static "default power save" function in hda_intel.c, which involves 
PM quirks and value set in CONFIG_SND_HDA_POWER_SAVE_DEFAULT. So I
would like to call this function and not duplicate the quirks in SOF
code. Not sure if these platforms in the quirks will ever run SOF
though...

br,
Jaska

> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

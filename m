Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E38FC433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:05:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF17206B7
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="p3Rdkno2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e6MqBh2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF17206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DE3018B6;
	Thu, 25 Jun 2020 12:04:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DE3018B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593079518;
	bh=cqKAv9qws7oySEOVlWplW2ricLwasNNsR/fTGOzuRQs=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p3Rdkno2eKxdtbKWXGqLiYmXUNJA6n1IAGBOZqCWVTp3+rlQsS2ORjSBkXPUCe0MB
	 uJt+G6hCKehCajBf/AUGe3KSG94mGc20m1ZoFt2/I1Tafa9RV2ZzEkjX5NLzKV1Wpl
	 trFM/L3t5xAWK0War09a8dJX0Uk4uhk7ib23ihBU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF830F80218;
	Thu, 25 Jun 2020 12:04:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0CF19F80234; Thu, 25 Jun 2020 12:04:26 +0200 (CEST)
Received: from forward5-smtp.messagingengine.com
 (forward5-smtp.messagingengine.com [66.111.4.239])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A252F80158
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 12:04:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A252F80158
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="e6MqBh2d"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailforward.nyi.internal (Postfix) with ESMTP id A49001941464;
 Thu, 25 Jun 2020 06:04:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Thu, 25 Jun 2020 06:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=whmIcANl4bHcMFxCxZv/aQn4hKsWDnYXmWOHQIzhh
 +w=; b=e6MqBh2dr1SRaF8nXxjlm50IfgNo6YaA1mm8HAXFOuqWu32S/VqU3cdSd
 3X6lkX22M/LOG6UHVV7ZOpoO5oFOH/A1m9Fpf60dB3Y79qPi+j2CX8QAlfymeYze
 5hsjaJM+RIZipTr4zk6owV6FQVgfO9jSh/CBzMJe1GBe2Cy+61yVrOmf9Vds+X3+
 AhXQfJtyUcRavpl5Sed7JNExT45fbLopdVfD8M6aAc8heXNvRbak/Ap7C08Zj1Dl
 7ou3BEyxO0eic0CT0CeuEz20PQPfgw7+mB7TBtR6XjvaNU0JLzgVi5AxqTCmfK9J
 ZI3Vp+TCJkcFv1V0DxRTkh6nGsGcw==
X-ME-Sender: <xms:nHb0Xm3EafhXmVHfhZcvp_4epDkOEurppCgCTol5t2AIWj0VOD4heA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudekledgvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepvfgrnhhu
 ucfmrghskhhinhgvnhcuoehtrghnuhhksehikhhirdhfiheqnecuggftrfgrthhtvghrnh
 epgfelkefhjeevtddvledtkeelvefhfeejteegkeffffefudeugfelffeiueegveefnecu
 ffhomhgrihhnpehprghtrhgvohhnrdgtohhmpdhlihgsvghrrghprgihrdgtohhmnecukf
 hppeduleeirddvgeegrdduledurddutdenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehtrghnuhhksehikhhirdhfih
X-ME-Proxy: <xmx:nHb0XpGs9K3Xnh-QPCQtJdc_WG8O7glrhZoz25EngWpqiettZn3yow>
 <xmx:nHb0Xu4XRK86bptaA9TmcSUm1WO85jsZ3Rkmym_oE_-_XMfDm18CYg>
 <xmx:nHb0Xn1wyYWpKHzvhogTio62gs-73Ufon3q8v1Xoy02WGJMIpPBfWQ>
 <xmx:oHb0XpBjJ4aza98RIMgXtoy-_RbgbmflTGWGOq-0BgwvAYimw-JFSQ>
Received: from laptop (unknown [196.244.191.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id A31543280059;
 Thu, 25 Jun 2020 06:04:11 -0400 (EDT)
Message-ID: <1e37052c8d86662dbcf0eedd7d138d0c15a00abc.camel@iki.fi>
Subject: Re: [pulseaudio-discuss] [PATCH] ALSA: hda/hdmi: Add Intel silent
 stream support
From: Tanu Kaskinen <tanuk@iki.fi>
To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>,  Arun Raghavan
 <arun@arunraghavan.net>
Date: Thu, 25 Jun 2020 13:04:07 +0300
In-Reply-To: <s5h7dvviq4q.wl-tiwai@suse.de>
References: <1592954796-12449-1-git-send-email-harshapriya.n@intel.com>
 <s5hr1u4lxee.wl-tiwai@suse.de>
 <f2da25c0-c740-4d44-ab66-6017622f7dde@perex.cz>
 <7dd38f98-e74a-94c0-6888-523e6189c00b@linux.intel.com>
 <s5ho8p8ifcn.wl-tiwai@suse.de>
 <2404f45d-832d-69a0-fb3b-1981ae455f50@linux.intel.com>
 <s5hftakid2e.wl-tiwai@suse.de>
 <3bfd1d2f-a2f0-4321-8f9d-2b9f265dcebd@www.fastmail.com>
 <s5h7dvviq4q.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Harsha Priya <harshapriya.n@intel.com>, kai.vehmanen@intel.com,
 alsa-devel@alsa-project.org, Emmanuel Jillela <emmanuel.jillela@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, 2020-06-25 at 09:03 +0200, Takashi Iwai wrote:
> On Thu, 25 Jun 2020 02:18:58 +0200,
> Arun Raghavan wrote:
> > +pulseaudio-discuss for information
> > 
> > On Wed, 24 Jun 2020, at 1:33 PM, Takashi Iwai wrote:
> > > On Wed, 24 Jun 2020 19:05:14 +0200,
> > > Pierre-Louis Bossart wrote:
> > > > 
> > > > 
> > > > On 6/24/20 11:43 AM, Takashi Iwai wrote:
> > > > > On Wed, 24 Jun 2020 17:33:45 +0200,
> > > > > Pierre-Louis Bossart wrote:
> > > > > > It also doesn't have a UCM representation
> > > > > > so would force the use of amixer and manual configs, or the UCM file
> > > > > > would always set the mode.
> > > > > 
> > > > > But people usually use the distro kernels, so the situation is more or
> > > > > less equivalent; you'd have to adjust a module option manually if you
> > > > > want a different one from the default, and you'd have to be root to
> > > > > change it.
> > > > > 
> > > > > So, rather the question is how we should provide the setup of such
> > > > > parameter.  It's supposed to be a part of power management stuff that
> > > > > should be touched by either a smart PM tool or a manual override such
> > > > > as runtime PM setup?  Or can it be seen as a more casual tuning?
> > > > 
> > > > I am not aware of such tools. The only thing I know is that some of
> > > > the HDaudio power settings are already controlled by kernel
> > > > parameters, e.g.
> > > > 
> > > > /etc/modprobe.d/audio_powersave.conf
> > > > options snd_hda_intel power_save=1
> > > 
> > > Yes, it's been the primary knob for years to turn on/off the runtime
> > > PM for HD-audio and other legacy drivers.  This was used by powertop
> > > or some other power-aware daemons and tools, to be toggled dynamically
> > > per the power cable state or such.
> > > 
> > > And, how the silent stream feature should be seen?
> > > Should it be a system-wide root-only setup or adjustable per user?
> > > Would it be changed often?  Such questions and answers will lead us to
> > > the right direction, I hope.
> > 
> > For audio, would UCM not be the appropriate point for a system
> > integrator to decide how the audio device should be set up?
> > 
> > This would allow for a choice based on the situation in which the
> > device is actually being deployed without users having to muck
> > around with module parameters -- maybe someone wants want this
> > enabled for an HTPC setup, but not on a desktop connected to a
> > monitor.

Is UCM really an appropriate place for deciding the setting? The
default should be to disable the feature, and if that is done in UCM,
how is the user expected to enable it when needed? I'm not aware of an
easy way to tweak the UCM configuration (modifying distro-provided
files is not good).

I don't really get the talk about system integrators. This seems like
an end-user setting to me.

> Right, that's my concern.  Many users with HDMI monitor that is
> capable of audio don't use HDMI audio because they don't need it
> and/or the output sucks.  For them, this feature is superfluous and
> harmful from the runtime PM POV.
> 
> If it were provided via UCM, would it be yet another UCM profile like
> HDMI+silentstream?  This can be confusing, too, I'm afraid.
> 
>  From the interface POV, as Kai suggested in another mail, the
> analogy to power_save option makes sense.  OTOH, power_save is the
> knob that is better to be enabled (as long as it works), silent stream
> is the feature that is needed only when required.  So it comes to the
> question which interface is easier to manage.

Having a separate UCM "profile" (do you mean a verb or a device?) seems
overkill. I think there could be a device-specific variable, like
SilentStreamControl, which would indicate that the device supports the
silent stream feature. The variable would also point to the mixer
control for enabling it.

That said, I don't see much need for involving UCM at all. UCM becomes
more relevant if we want PulseAudio to provide an API for controlling
this feature, but until that happens, just having a mixer control that
users can toggle seems sufficient to me. (I'm assuming that ALSA
remembers mixer settings between boots. I'm not sure if that's the
case, but I have the impression that the alsa-state thingy is
universally enabled and implements this.)

-- 
Tanu

https://www.patreon.com/tanuk
https://liberapay.com/tanuk


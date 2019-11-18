Return-Path: <SRS0=vuHx=ZK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587D1C432C3
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 19:21:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5766E2231A
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 19:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y32vK7gk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="QYCEcMnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5766E2231A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3FAD41674;
	Mon, 18 Nov 2019 20:21:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3FAD41674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574104910;
	bh=mJLkg+BwNtlCWc2s6SCQ4hASzkz8Hjo4K7F2aRaVyrk=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y32vK7gkEDZFEMZ5Bvyuy8PcIXZLL3zlo7Xw2+Kmrjrtpw4UcETe5ecghOnxi9wWO
	 +SCSvVziyzZKBE89XnvgrHFe0LHUAd3mSjxNHhwu6JfIszWSjbnoOnsjVJKr1dRIUD
	 +hhD6xmFebzGydXhn6EI6Aid4PFbuKAAoKEu6Fw4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2A21F80100;
	Mon, 18 Nov 2019 20:20:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07205F8013B; Mon, 18 Nov 2019 20:20:58 +0100 (CET)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C8B0F800F6
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2019 20:20:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C8B0F800F6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="QYCEcMnT"
Received: by mail-il1-x143.google.com with SMTP id s5so17074844iln.4
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2019 11:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U7Ui06g+vYWLjuCFnl1W/FEWQz+JLp0mrXs98iq71qA=;
 b=QYCEcMnTXVxAaFHs46qNzi1uuEuFJ0oDkmZI5UekGd2URrG63haDsV/eN2VMDVL02U
 0E0mjIPx3SeOpYVQJN9/Si1TRczB94btQ7GC2PU8A2xRIShQTjMH8vdDfQ2qefpPXxoJ
 9nVZnRuWsMLdzp5wYTQm0zF/FPwyUdkfZ80MPE6K+gPIiOP+5H1efQM8IfJQE8UkIaxB
 q/AWEQZP1yv9MBx8n4yEs+XhnNgVa7MxhjLdlvz//Bvt6N0ea020rE04y+nlEI4CFuhL
 VxSyoe/bjL56p4nbpKdlGlgH04OZn6dBMPsMpvMySBs6Qk4FCFsZNViNK+P9Y3Z9Kn8Y
 jR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U7Ui06g+vYWLjuCFnl1W/FEWQz+JLp0mrXs98iq71qA=;
 b=AOETBQJd8JVMOgaY3RyA0CpZJGds9RiBIka7LfVk4+JiAwijnMMtlAt34IdrqxtCiC
 Xa8+UEMizY+do/cg3rXbLHzHhTh0ShnZRVaNkdM0FqCgW5UcJ5QXNdlEMDtcfL5PJoa3
 v5jUiecZCc0B9NQrFqoK9Mq0rtlMjQPoP2h5JlpPjmLh/2jAyp6wlZMuUYSqZK0fUY1k
 G9vee4c4E6FQOoqd9ephE0b1GTxhy+H8Y/HdmRZFNDV8NnUKw4rIgVoPJoa+8IynOknw
 D4rtpjICDtcUMFgyWUb2eU/Cs2hOjoSIqYrMjD9PemL6hM5HA1Wtag4N56kD+Id7AEtS
 0P5Q==
X-Gm-Message-State: APjAAAUwn1nWoq/b/Got4keCUniOWTGjPbzHUZAb5opQvyGrj+p6Pey8
 UKJin+4EqUiHhrNPnOHlnxpzPL8F4YH63jqc4Nakng==
X-Google-Smtp-Source: APXvYqyG5hn7shXE3YkSs0C7CHyCoGqA5RuW1VhHQNlrpLFyuJ5d9gp65oXDS93Qw+fUP+MMY1k9Ew9dwwU4UekO938=
X-Received: by 2002:a92:8108:: with SMTP id e8mr17250171ild.209.1574104852400; 
 Mon, 18 Nov 2019 11:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20191117085308.23915-1-tiwai@suse.de>
 <20191117085308.23915-8-tiwai@suse.de>
 <3b407a02-b791-52a4-2335-e21d8ab732dd@linux.intel.com>
 <s5hy2wdyq3t.wl-tiwai@suse.de>
In-Reply-To: <s5hy2wdyq3t.wl-tiwai@suse.de>
From: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Date: Mon, 18 Nov 2019 11:20:41 -0800
Message-ID: <CAFQqKeWgqHwrCSSbLrkuCHkBww2g4dsBcF93SDN_ZK_-KSe5tg@mail.gmail.com>
To: Takashi Iwai <tiwai@suse.de>
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 7/8] ALSA: pcm: Add card sync_irq field
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

On Mon, Nov 18, 2019 at 10:54 AM Takashi Iwai <tiwai@suse.de> wrote:

> On Mon, 18 Nov 2019 17:38:49 +0100,
> Pierre-Louis Bossart wrote:
> >
> >
> >
> > On 11/17/19 2:53 AM, Takashi Iwai wrote:
> > > Many PCI and other drivers performs snd_pcm_period_elapsed() simply in
> > > its interrupt handler, so the sync_stop operation is just to call
> > > synchronize_irq().  Instead of putting this call multiple times,
> > > introduce the common card->sync_irq field.  When this field is set,
> > > PCM core performs synchronize_irq() for sync-stop operation.  Each
> > > driver just needs to copy its local IRQ number to card->sync_irq, and
> > > that's all we need.
> >
> > Maybe a red-herring or complete non-sense, but I wonder if this is
> > going to get in the way of Ranjani's multi-client work, where we could
> > have multiple cards created but with a single IRQ handled by the
> > parent PCI device?
> >
> > Ranjani, you may want to double-check this and chime in, thanks!
>
> The synchronize_irq() is fairly safe to call multiple times, and I
> don't think any problem by invoking it for multi-clients sharing the
> same IRQ.  For example, Digigram miXart driver creates multiple card
> objects from a single PCI entry, and I already thought of that
> possibility; they set the same card->sync_irq value to all card
> objects, which eventually will call synchronize_irq() multiple times.
>  From the performance POV, this shouldn't be a big problem, because
> the place calling this is only at hw_params, prepare and hw_free,
> neither are hot-path.
>
Thanks for the clarification, Takashi. But just wondering how would one
pass on the sync_irq when the snd_card is created? Typically in the case of
the Intel platforms, the card->dev points to the platform device for the
machine driver that registers the card and the PCI device is the parent of
the machine drv platform device.

Thanks,
Ranjani
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

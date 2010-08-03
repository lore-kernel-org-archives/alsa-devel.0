From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: Wrong channel order with multichannel HDMI on
	NVIDIA MCP7A
Date: Tue, 3 Aug 2010 13:15:28 -0700
Message-ID: <AANLkTike8b4P=4MTADbSKfYovTEg+9Nwyw2qFjBozT3c@mail.gmail.com>
References: <201007251951.39362.anssi.hannula@iki.fi>
	<201007280542.09231.anssi.hannula@iki.fi>
	<201007291741.15187.anssi.hannula@iki.fi>
	<201008032201.47487.anssi.hannula@iki.fi>
	<s5hbp9j5vvx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1149E24425
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 22:15:29 +0200 (CEST)
Received: by yxm8 with SMTP id 8so1873333yxm.38
	for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2010 13:15:29 -0700 (PDT)
In-Reply-To: <s5hbp9j5vvx.wl%tiwai@suse.de>
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
Cc: Anssi Hannula <anssi.hannula@iki.fi>, alsa-devel@alsa-project.org, Wei Ni <wni@nvidia.com>
List-Id: alsa-devel@alsa-project.org

> Well, this is one of my looong-standing TODOs.
> Originally I wanted to implement a new API to get/set the
> channel-mapping, mainly for HDMI.
> But, I've been recently too busy for other tasks (I can spend little
> time for ALSA), thus it's pending forever.

You would only need an API to get the channel mapping. The HDMI sink
will report its speaker configuration through a CEA code (section 7.4
of the spec), and if we parsed the EDID info we could present the
relevant channel order to user-space apps.

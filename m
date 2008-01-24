From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: Splitting up the HDA-INTEL modules
Date: Thu, 24 Jan 2008 15:20:40 -0200
Message-ID: <5f52f6d70801240920i892bcbek3af0f52db4a47442@mail.gmail.com>
References: <478CFD32.50405@harddisk.is-a-geek.org>
	<5f52f6d70801151120y76407dd4s4c876643ddc8ba95@mail.gmail.com>
	<s5h1w8ivvd4.wl%tiwai@suse.de>
	<5f52f6d70801160451p37a8c94ofbbbd2018f88531b@mail.gmail.com>
	<s5hejchvn0e.wl%tiwai@suse.de>
	<5f52f6d70801191119m27f20a6bn3183c44ddb3635bd@mail.gmail.com>
	<s5hfxwre22v.wl%tiwai@suse.de>
	<5f52f6d70801231146m2b668f6yd02df8422d78490d@mail.gmail.com>
	<5f52f6d70801240812kf432c74n7de6a960c906f186@mail.gmail.com>
	<s5hr6g72nv6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.225])
	by alsa0.perex.cz (Postfix) with ESMTP id D159F243BD
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 18:20:42 +0100 (CET)
Received: by nz-out-0506.google.com with SMTP id m22so223465nzf.2
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 09:20:41 -0800 (PST)
In-Reply-To: <s5hr6g72nv6.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Marco Schuster <marco@harddisk.is-a-geek.org>
List-Id: alsa-devel@alsa-project.org

On Jan 24, 2008 2:24 PM, Takashi Iwai <tiwai@suse.de> wrote:

> It depends on kernel config (CONFIG_SND_DYNAMIC_MINORS).  It's created
> as /dev/snd/hwC*D0 by udev, usually.

Right, I had a problem with my dev nodes, it now works past the device
opening and the ioctl is correctly handled by hda_hwdep_ioctl(). Some
problems with GET_CODEC_INFO now, I'll investigate.

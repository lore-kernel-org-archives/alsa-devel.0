From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-devel] Oops in 2.6.10-rc1
Date: Thu, 28 Oct 2004 15:29:34 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz>
References: <4180F026.9090302@g-house.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263059AbUJ1N2j@vger.kernel.org>
In-Reply-To: <4180F026.9090302@g-house.de>
To: Christian <evil@g-house.de>
Cc: alsa-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Oct 2004, Christian wrote:

>   [<c01fc7b8>] pci_enable_device_bars+0x28/0x40
>   [<c01fc7ef>] pci_enable_device+0x1f/0x40
>   [<e082729d>] snd_ensoniq_create+0x1d/0x480 [snd_ens1371]
>   [<e08469cf>] snd_card_new+0x1cf/0x2c0 [snd]

It's a bit dead-lock, because we cannot help you. It seems that
the pci structure passed to our code is broken. The driver has had
no changes in initialization for a long time.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

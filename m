From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 1/5] HDA : patch_sigmatel.c : cleanups
Date: Sat, 1 Sep 2007 11:11:24 +0300
Message-ID: <200709011111.24865.maximlevitsky@gmail.com>
References: <200708280454.29250.maximlevitsky@gmail.com>
	<s5hwsvg2aza.wl%tiwai@suse.de> <s5hps14ezvw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 0083C2433E
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Sep 2007 11:12:05 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so1012766mue
	for <alsa-devel@alsa-project.org>; Sat, 01 Sep 2007 02:12:05 -0700 (PDT)
In-Reply-To: <s5hps14ezvw.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, mranostay@embeddedalley.com
List-Id: alsa-devel@alsa-project.org

On Friday 31 August 2007 13:56:19 Takashi Iwai wrote:
> At Tue, 28 Aug 2007 12:46:01 +0200,
> I wrote:
> > 
> > At Tue, 28 Aug 2007 05:07:48 +0300,
> > Maxim Levitsky wrote:
> > > 
> > > From c9392b0293f7d39e40e4a5e07e7b140d5a385079 Mon Sep 17 00:00:00 2001
> > > From: Maxim Levitsky <maximlevitsky@gmail.com>
> > > Date: Mon, 27 Aug 2007 22:49:49 +0300
> > > Subject: [PATCH] HDA : patch_sigmatel.c : cleanups
> > 
> > OK, it's a nice clean-up.  Can be merged as is.
> 
> Now merged to ALSA HG tree.
> 
> If the fixes for other patches are ready, please let me know.
> I'll merge them to HG tree, too.
> 
> 
> Thanks,
> 
> Takashi
> 


Hi,

I run into unexpected problems:
latest hg adds a power saving mode to hda codec, and while the idea is nice, it plays very bad with my patches.

1) The analog loop-back becomes a nightmare, since power-saving code turns the codec off, but for loopback to function it has to be powered.
I tried to add a snd_hda_power_up/down calls to .put function, and while it did stop the unwanted powerdown of codec, on resume from ram , analog loopback vanishes.
any access to device (arecord/aplay or any mixer change make analog loop work again).
Can you tell me how I properly tell the core that user _uses_ the device, and device should be powered.

2) on resume all playback apps hang, and recording (arecord) exits with message "Resource temporary unavailable"
restarting apps help.

Looking for your comments,
	Best regards,
		Maxim Levitsky

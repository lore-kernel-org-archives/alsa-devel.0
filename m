From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: hda_intel: too quiet sound (regression)
Date: Mon, 26 Jul 2010 18:09:50 +0200
Message-ID: <4C4DB34E.9060702@gmail.com>
References: <4C4D9EDA.3060505@gmail.com> <s5htynmuvw4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id E3AD024773
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 18:09:53 +0200 (CEST)
Received: by bwz4 with SMTP id 4so3052205bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 09:09:53 -0700 (PDT)
In-Reply-To: <s5htynmuvw4.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, fengguang.wu@intel.com, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 07/26/2010 05:04 PM, Takashi Iwai wrote:
> Looks like a regression by the amp max value check.
> The following patch should fix the problem.

Works for me.

> ---
> From 7ccc3eface57b6e1773fce009dac8a3da081b8b1 Mon Sep 17 00:00:00 2001
> From: Takashi Iwai <tiwai@suse.de>
> Date: Mon, 26 Jul 2010 17:00:15 +0200
> Subject: [PATCH] ALSA: hda - Fix max amp cap calculation for IDT/STAC codecs
> 
> The commit afbd9b8448f4b7d15673c6858012f384f18d28b8
>     ALSA: hda - Limit the amp value to write
> introduced a regression for codec setups with amp offsets like IDT/STAC
> codecs.  The limit value should be a raw value without offset calculation.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Tested-by: Jiri Slaby <jirislaby@gmail.com>

thanks,
-- 
js

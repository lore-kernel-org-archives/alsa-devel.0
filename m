From: Daniel Drake <dsd@laptop.org>
Subject: Re: Conexant CX20582 HDA codec support
Date: Tue, 30 Jun 2009 19:48:33 +0100
Message-ID: <1246387713.5695.20.camel@polyethylene>
References: <1246277454.2182.6.camel@polyethylene>
	<s5hskhjnqzc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27])
	by alsa0.perex.cz (Postfix) with ESMTP id A5E1A103893
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 20:48:38 +0200 (CEST)
Received: by ey-out-2122.google.com with SMTP id 22so94072eye.47
	for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2009 11:48:37 -0700 (PDT)
In-Reply-To: <s5hskhjnqzc.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, 2009-06-29 at 14:50 +0200, Takashi Iwai wrote:
> Ideally, yes.
> If the codec tree looks similar as other Conexant codecs, you can adapt
> patch_conexant.c...


Thanks for the quick explanations to all my issues. Makes sense.

Our contacts at Conexant pointed us to this file:
http://www.linuxant.com/alsa-driver/alsa-driver-linuxant-1.0.19ppch12-1.noarch.rpm.zip

The patch_conexant.c inside includes support for CX20582 ("Pebble") and
a few more. Complete list:

	{ .id = 0x14f15061, .name = "CX2058? (Pebble)",
	  .patch = patch_cxtppch },
	{ .id = 0x14f15066, .name = "CX20582 (Pebble)",
	  .patch = patch_cxtppch },
	{ .id = 0x14f15067, .name = "CX20583 (Pebble 56-LQFP)",
	  .patch = patch_cxtppch },
	{ .id = 0x14f15068, .name = "CX20584 (Pebble)",
	  .patch = patch_cxtppch },
	{ .id = 0x14f15069, .name = "CX20585 (Pebble 56-QFN)",
	  .patch = patch_cxtppch },
	{ .id = 0x14f15070, .name = "CX20592 (Pelican)",
	  .patch = patch_cxtppch },
	{ .id = 0x14f15071, .name = "CX20593 (Pelican 56-LQFP)",
	  .patch = patch_cxtppch },
	{ .id = 0x14f15072, .name = "CX20594 (Pelican)",
	  .patch = patch_cxtppch },
	{ .id = 0x14f15073, .name = "CX20595 (Pelican 56-QFN)",
	  .patch = patch_cxtppch },
	{ .id = 0x14f15074, .name = "CX2059? (Pelican)",
	  .patch = patch_cxtppch },
	{ .id = 0x14f150D0, .name = "CX20688 (Cabo)",
	  .patch = patch_cxtppch },
	{ .id = 0x14f150D4, .name = "CX20692 (Huntington)",
	  .patch = patch_cxtppch },
	{ .id = 0x14f150D5, .name = "CX20693 (Huntington)",
	  .patch = patch_cxtppch },
	{ .id = 0x14f150D6, .name = "CX20694 (Huntington)",
	  .patch = patch_cxtppch },
	{ .id = 0x14f150D7, .name = "CX20695 (Huntington)",
	  .patch = patch_cxtppch },
	{ .id = 0x14f12bfa, .mfg = 2, .name = "HSF",
	  .patch = patch_cxthsfmodem },
	{ .id = 0x14f12c06, .mfg = 2, .name = "HSF",
	  .patch = patch_cxthsfmodem },
	{ .id = 0x14f10000, .mask = 0xffff0000, .mfg = 2, .name = "HSF",
	  .patch = patch_cxthsfmodem },

Perhaps a useful link to keep around in future if other people come
along looking for new codec support...

Over the next few days, I plan to extract the CX20584 support, get it
working on the XO-1.5 and then send you a patch.

Thanks,
Daniel

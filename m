From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Device tree support for WM8994 and WM9713.
Date: Tue, 22 Nov 2011 12:42:12 +0000
Message-ID: <20111122124212.GC30048@opensource.wolfsonmicro.com>
References: <CAJuYYwRZcbsRz-+2Swck=PUXT+iHeRWN3fu-R8C7tBYUb1Pgqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17F5524157
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 13:42:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAJuYYwRZcbsRz-+2Swck=PUXT+iHeRWN3fu-R8C7tBYUb1Pgqw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2011 at 11:28:32AM +0530, Thomas Abraham wrote:

> smdkv310 board uses wm8994 and wm9713 audio codecs. I wanted to check
> with you if there is any plan on adding device tree support for these
> two codecs.

I actually have this board.  What state is the -next code in with
respect to device tree, can I usefully run the board (and if I can a
recipie would be very helpful)?  Also, can you tell me where the
bootloader is in the SD card - I've got a binary but no source so I'd
like to start from a fresh card so Id

For WM9713 you shouldn't need any mention in the device tree as for the
way your boards are structured the normal AC'97 discovery mechanisms
should work fine.  However, 

For WM8994 if I can get the board booting with mainline we should be
able to get device tree support for the platform data fairly easily -
the main issue we've got with device tree at the minute is getting a
board which can usefully use it.  Though for your particular board I see
that the existing non-DT code doesn't need any platform data so I'd
expect that you don't need a specific binding at all.  I'll post a patch
that adds a stub binding today or tomorrow.

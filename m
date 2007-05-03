From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dmix does not mix small files??
Date: Thu, 3 May 2007 10:52:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0705031042180.8516@tm8103.perex-int.cz>
References: <49f264960705030014v7441c188y3d2ed918472c6085@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 926E824417
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2007 10:52:29 +0200 (CEST)
In-Reply-To: <49f264960705030014v7441c188y3d2ed918472c6085@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Prabhu Sivaraja <prabhu.sivaraja@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 3 May 2007, Prabhu Sivaraja wrote:

> Hi,
> 
> I've been stuck on this dmix problem for the past week and have tried
> everything under the sun. Please any help or comment is much appreciated.
> Thanks a lot.

For nice dmix support, it's better to have more periods than 2 and small 
ones. Your allowed configuration 2 x 32KB is not very good.

But judging from the current dmix code, this code may cause to skip large 
count of samples or your driver behaves badly:

/* If we have too litte periods, better to align the start  position
 * to the period boundary so that the interrupt can be handled  properly
 * at the right time.
 */
dmix->slave_appl_ptr = ((dmix->slave_appl_ptr + dmix->slave_period_size - 1)
                       / dmix->slave_period_size) * dmix->slave_period_size;


It's from changeset:

hangeset:   2109:349c0b0018b9
user:        tiwai
date:        Fri Mar 24 14:53:41 2006 +0000
files:       src/pcm/pcm_direct.c src/pcm/pcm_dmix.c
description:
Fix noisy output of dmix with two periods

Fixed the noisy output of dmix with two (or less) periods.
The dmix tends to give noise or XRUN when running with two periods
because of its implementation nature.  To avoid this, the start
position is aligned to the period size, so that the updates are synced
with interrupts of slave PCM.

> So in order to debug this I tried to decrease my period_size = 4KB but when
> I do this my hw_ptr never moves.

Driver problem?

					Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

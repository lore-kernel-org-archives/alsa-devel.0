From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] alsa-lib: Broken SNDRV_PCM_IOCTL_TTSTAMP
 entry
Date: Mon, 17 Dec 2007 08:58:39 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0712170858110.14817@tm8103.perex-int.cz>
References: <4765E3A0.4080008@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DF8A7103875
	for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2007 08:58:39 +0100 (CET)
In-Reply-To: <4765E3A0.4080008@embeddedalley.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthew Ranostay <mranostay@embeddedalley.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 16 Dec 2007, Matthew Ranostay wrote:

> Fixed a IOCTL entry that was broken with a recent update to alsa-driver.

This patch is broken. New ioctl is really new and not compatible with old.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project

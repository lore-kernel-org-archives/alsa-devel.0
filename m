From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] Remove PCM xfer_align parameter
Date: Tue, 8 Jan 2008 17:41:06 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801081738360.22730@tm8103.perex-int.cz>
References: <s5hy7bp2z5v.wl%tiwai@suse.de> <s5htzmd2xov.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id D1BE224B3F
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 17:41:07 +0100 (CET)
In-Reply-To: <s5htzmd2xov.wl%tiwai@suse.de>
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

On Thu, 20 Dec 2007, Takashi Iwai wrote:

> This patch removes the PCM xfer_align parameter.
> It's still present and won't break the kernel ABI.
> 
> Note that this patch won't be applied cleanly to HG, as it's generated
> in the middle of my patch stack (to fix snd_pcm_lib_write1 blocking
> bug).

Are you sure that this patch does not change compatibility with older 
applications? Otherwise, ACK.

Also, alsa-lib API should be updated to respect this (and time tick) 
changes.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

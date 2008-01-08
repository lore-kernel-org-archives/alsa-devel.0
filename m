From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] Remove indirect control access
Date: Tue, 8 Jan 2008 17:32:29 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801081728080.22730@tm8103.perex-int.cz>
References: <s5hy7bp2z5v.wl%tiwai@suse.de> <s5hve6t2xsu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id EBDDB24B37
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 17:32:29 +0100 (CET)
In-Reply-To: <s5hve6t2xsu.wl%tiwai@suse.de>
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

> Hi,
> 
> this is the patch to remove indirect control access.
> In this version, I left the pointers in snd_ctl_elem_* struct but
> added/changed comments because the pointer member might influence on
> alignment.  After confirming that it doesn't affect, we can get rid of
> them.

Ack, but I would increase also protocol version number to have a 
possibility to check the kernel API change in alsa-lib.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/4] ALSA: hda beep clean up
Date: Tue, 03 Jul 2012 18:31:55 +0200
Message-ID: <4FF31E7B.8030906@perex.cz>
References: <1341331397-21182-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id DCDDE24523
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2012 18:30:20 +0200 (CEST)
In-Reply-To: <1341331397-21182-1-git-send-email-tiwai@suse.de>
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

Date 3.7.2012 18:03, Takashi Iwai wrote:
> Hi,
> 
> this is a series of small cleanups of HD-audio beep code.
> Since the keyboard driver already handles the simultaneous outputs
> from the multiple input beep instances, there is no merit to have
> beep_mode=2 option to switch the beep input device.

Acked-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.

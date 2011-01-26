From: Fredrik Lingvall <fl@ifi.uio.no>
Subject: Re: hdspmixer
Date: Wed, 26 Jan 2011 11:04:52 +0100
Message-ID: <4D3FF1C4.8000704@ifi.uio.no>
References: <alpine.LNX.2.00.1101261044110.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 993F1244F9
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 11:04:55 +0100 (CET)
Received: by bwz10 with SMTP id 10so1225985bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 02:04:55 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1101261044110.6272@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Florian Faber <faber@faberman.de>
List-Id: alsa-devel@alsa-project.org

I did two things to build the hdspmixer I got from Florian.

1) Moved the #endif (at line 121)

#endif                /* __SOUND_HDSPM_H */

downto the last line of the hdspm.h

2) Changed

#include<alsa/sound/hdsp.h>

to

#include <sound/hdspm.h>

in HDSPMixerWindow.h

/Fredrik

On 01/26/11 10:49, Jaroslav Kysela wrote:
> Hi,
>
>  	working on new ALSA release, but it seems that 
> alsa-tools/hdspmixer is out of sync with current 
> linux/sound/hdsp.h / hdspm.h after this commit:
>
> commit e24e56795ea57e3dd7da45063ab71f04e231192d
> Author: Adrian Knoth <adi@drcomp.erfurt.thur.de>
> Date:   Sun Jan 9 19:42:59 2011 +0100
>
>      Add support for RME MADI, RayDAT and AIO
>
>      Merged the work by Florian Faber that's distributed separately as
>      hdspmixer64.
>
>      Code taken from 
> http://wiki.linuxproaudio.org/index.php/App:hdspmixer_64
>
>      Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
>      Signed-off-by: Takashi Iwai <tiwai@suse.de>
>
>  	Any clue what to do to get things fixed?
>
>  					Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: hdspmixer
Date: Wed, 26 Jan 2011 11:13:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101261108320.6272@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.1101261044110.6272@eeebox2.perex-int.cz>
	<4D3FF1C4.8000704@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1284224507
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 11:13:19 +0100 (CET)
In-Reply-To: <4D3FF1C4.8000704@ifi.uio.no>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fredrik Lingvall <fl@ifi.uio.no>
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Florian Faber <faber@faberman.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 26 Jan 2011, Fredrik Lingvall wrote:

> I did two things to build the hdspmixer I got from Florian.
>
> 1) Moved the #endif (at line 121)
>
> #endif                /* __SOUND_HDSPM_H */
>
> downto the last line of the hdspm.h

It's already in hdspm.h we have in the GIT kernel tree:

http://git.alsa-project.org/?p=alsa-kernel.git;a=blob;f=include/sound/hdspm.h;h=81990b2bcc981bb4f31cae44616aa052c5f1066e;hb=HEAD

> 2) Changed
>
> #include<alsa/sound/hdsp.h>
>
> to
>
> #include <sound/hdspm.h>
>
> in HDSPMixerWindow.h

I have both includes in HDSMixerWindow.h:

#include <alsa/sound/hdsp.h>
#include <alsa/sound/hdspm.h>

The hdspm.h is from the location above (added to alsa-lib/include/sound 
tree).

I think that you are using different kernel driver - so we are out of 
sync with the user space tools. What version of the hdsp/hdspm driver are 
you using?

 					Jaroslav

> On 01/26/11 10:49, Jaroslav Kysela wrote:
>> Hi,
>>
>>  	working on new ALSA release, but it seems that
>> alsa-tools/hdspmixer is out of sync with current
>> linux/sound/hdsp.h / hdspm.h after this commit:
>>
>> commit e24e56795ea57e3dd7da45063ab71f04e231192d
>> Author: Adrian Knoth <adi@drcomp.erfurt.thur.de>
>> Date:   Sun Jan 9 19:42:59 2011 +0100
>>
>>      Add support for RME MADI, RayDAT and AIO
>>
>>      Merged the work by Florian Faber that's distributed separately as
>>      hdspmixer64.
>>
>>      Code taken from
>> http://wiki.linuxproaudio.org/index.php/App:hdspmixer_64
>>
>>      Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
>>      Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>
>>  	Any clue what to do to get things fixed?
>>
>>  					Jaroslav
>>

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

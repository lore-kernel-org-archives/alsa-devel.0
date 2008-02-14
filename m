From: Linux Mercedes <linuxmercedes@gmail.com>
Subject: Trouble building alsa-lib
Date: Thu, 14 Feb 2008 10:01:24 -0600
Message-ID: <47B465D3.6040400@Gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FDD824581
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 17:01:07 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id w49so577128pyg.36
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 08:01:06 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm trying to build alsa from source.  I'm guessing (I was not able to 
find any instructions on how to build alsa) that I build alsa-lib 
first.  I'm compiling it  with gcc 4.2.1. However, when I build it, I 
get the following errors:

In file included from ../../include/local.h:105,
                 from control_local.h:22,
                 from cards.c:35:
../../include/sound/asound.h:148: warning: implicit declaration of 
function '_IO
R'
../../include/sound/asound.h:148: error: expected expression before 'int'
../../include/sound/asound.h:148: error: enumerator value for 
'SNDRV_HWDEP_IOCTL
_PVERSION' is not an integer constant
../../include/sound/asound.h:149: error: expected expression before 'struct'
../../include/sound/asound.h:149: error: enumerator value for 
'SNDRV_HWDEP_IOCTL
_INFO' is not an integer constant
../../include/sound/asound.h:150: error: expected expression before 'struct'
../../include/sound/asound.h:150: error: enumerator value for 
'SNDRV_HWDEP_IOCTL
_DSP_STATUS' is not an integer constant
../../include/sound/asound.h:151: warning: implicit declaration of 
function '_IO
W'
../../include/sound/asound.h:151: error: expected expression before 'struct'
../../include/sound/asound.h:152: error: enumerator value for 
'SNDRV_HWDEP_IOCTL
_DSP_LOAD' is not an integer constant
../../include/sound/asound.h:471: error: expected expression before 'int'
../../include/sound/asound.h:471: error: enumerator value for 
'SNDRV_PCM_IOCTL_P
VERSION' is not an integer constant
../../include/sound/asound.h:472: error: expected expression before 'struct'
../../include/sound/asound.h:472: error: enumerator value for 
'SNDRV_PCM_IOCTL_I
NFO' is not an integer constant
../../include/sound/asound.h:473: error: expected expression before 'int'
../../include/sound/asound.h:473: error: enumerator value for 
'SNDRV_PCM_IOCTL_T
STAMP' is not an integer constant
../../include/sound/asound.h:474: error: expected expression before 'int'
../../include/sound/asound.h:474: error: enumerator value for 
'SNDRV_PCM_IOCTL_T
TSTAMP' is not an integer constant
../../include/sound/asound.h:475: warning: implicit declaration of 
function '_IO
WR'
../../include/sound/asound.h:475: error: expected expression before 'struct'
../../include/sound/asound.h:475: error: enumerator value for 
'SNDRV_PCM_IOCTL_H
W_REFINE' is not an integer constant
../../include/sound/asound.h:476: error: expected expression before 'struct'
../../include/sound/asound.h:476: error: enumerator value for 
'SNDRV_PCM_IOCTL_H
W_PARAMS' is not an integer constant
../../include/sound/asound.h:477: warning: implicit declaration of 
function '_IO
'
../../include/sound/asound.h:477: error: enumerator value for 
'SNDRV_PCM_IOCTL_H
W_FREE' is not an integer constant
../../include/sound/asound.h:478: error: expected expression before 'struct'
../../include/sound/asound.h:478: error: enumerator value for 
'SNDRV_PCM_IOCTL_S
W_PARAMS' is not an integer constant
../../include/sound/asound.h:479: error: expected expression before 'struct'
../../include/sound/asound.h:479: error: enumerator value for 
'SNDRV_PCM_IOCTL_S
TATUS' is not an integer constant
../../include/sound/asound.h:480: error: expected expression before 
'sndrv_pcm_s
frames_t'
../../include/sound/asound.h:480: error: enumerator value for 
'SNDRV_PCM_IOCTL_D
ELAY' is not an integer constant
../../include/sound/asound.h:481: error: enumerator value for 
'SNDRV_PCM_IOCTL_H
WSYNC' is not an integer constant
../../include/sound/asound.h:482: error: expected expression before 'struct'
../../include/sound/asound.h:482: error: enumerator value for 
'SNDRV_PCM_IOCTL_S
YNC_PTR' is not an integer constant
../../include/sound/asound.h:483: error: expected expression before 'struct'
../../include/sound/asound.h:483: error: enumerator value for 
'SNDRV_PCM_IOCTL_C
HANNEL_INFO' is not an integer constant
../../include/sound/asound.h:484: error: enumerator value for 
'SNDRV_PCM_IOCTL_P
REPARE' is not an integer constant
../../include/sound/asound.h:485: error: enumerator value for 
'SNDRV_PCM_IOCTL_R
ESET' is not an integer constant
../../include/sound/asound.h:486: error: enumerator value for 
'SNDRV_PCM_IOCTL_S
TART' is not an integer constant
../../include/sound/asound.h:487: error: enumerator value for 
'SNDRV_PCM_IOCTL_D
ROP' is not an integer constant
../../include/sound/asound.h:488: error: enumerator value for 
'SNDRV_PCM_IOCTL_D
RAIN' is not an integer constant
../../include/sound/asound.h:489: error: expected expression before 'int'
../../include/sound/asound.h:489: error: enumerator value for 
'SNDRV_PCM_IOCTL_P
AUSE' is not an integer constant
../../include/sound/asound.h:490: error: expected expression before 
'sndrv_pcm_u
frames_t'
../../include/sound/asound.h:490: error: enumerator value for 
'SNDRV_PCM_IOCTL_R
EWIND' is not an integer constant
../../include/sound/asound.h:491: error: enumerator value for 
'SNDRV_PCM_IOCTL_R
ESUME' is not an integer constant
../../include/sound/asound.h:492: error: enumerator value for 
'SNDRV_PCM_IOCTL_X
RUN' is not an integer constant
../../include/sound/asound.h:493: error: expected expression before 
'sndrv_pcm_u
frames_t'
../../include/sound/asound.h:493: error: enumerator value for 
'SNDRV_PCM_IOCTL_F
ORWARD' is not an integer constant
../../include/sound/asound.h:494: error: expected expression before 'struct'
../../include/sound/asound.h:494: error: enumerator value for 
'SNDRV_PCM_IOCTL_W
RITEI_FRAMES' is not an integer constant
../../include/sound/asound.h:495: error: expected expression before 'struct'
../../include/sound/asound.h:495: error: enumerator value for 
'SNDRV_PCM_IOCTL_R
EADI_FRAMES' is not an integer constant
../../include/sound/asound.h:496: error: expected expression before 'struct'
../../include/sound/asound.h:496: error: enumerator value for 
'SNDRV_PCM_IOCTL_W
RITEN_FRAMES' is not an integer constant
../../include/sound/asound.h:497: error: expected expression before 'struct'
../../include/sound/asound.h:497: error: enumerator value for 
'SNDRV_PCM_IOCTL_R
EADN_FRAMES' is not an integer constant
../../include/sound/asound.h:498: error: expected expression before 'int'
../../include/sound/asound.h:498: error: enumerator value for 
'SNDRV_PCM_IOCTL_L
INK' is not an integer constant
../../include/sound/asound.h:499: error: enumerator value for 
'SNDRV_PCM_IOCTL_U
NLINK' is not an integer constant
../../include/sound/asound.h:558: error: expected expression before 'int'
../../include/sound/asound.h:558: error: enumerator value for 
'SNDRV_RAWMIDI_IOC
TL_PVERSION' is not an integer constant
../../include/sound/asound.h:559: error: expected expression before 'struct'
../../include/sound/asound.h:559: error: enumerator value for 
'SNDRV_RAWMIDI_IOC
TL_INFO' is not an integer constant
../../include/sound/asound.h:560: error: expected expression before 'struct'
../../include/sound/asound.h:560: error: enumerator value for 
'SNDRV_RAWMIDI_IOC
TL_PARAMS' is not an integer constant
../../include/sound/asound.h:561: error: expected expression before 'struct'
../../include/sound/asound.h:561: error: enumerator value for 
'SNDRV_RAWMIDI_IOC
TL_STATUS' is not an integer constant
../../include/sound/asound.h:562: error: expected expression before 'int'
../../include/sound/asound.h:562: error: enumerator value for 
'SNDRV_RAWMIDI_IOC
TL_DROP' is not an integer constant
../../include/sound/asound.h:563: error: expected expression before 'int'
../../include/sound/asound.h:563: error: enumerator value for 
'SNDRV_RAWMIDI_IOC
TL_DRAIN' is not an integer constant
../../include/sound/asound.h:673: error: expected expression before 'int'
../../include/sound/asound.h:673: error: enumerator value for 
'SNDRV_TIMER_IOCTL
_PVERSION' is not an integer constant
../../include/sound/asound.h:674: error: expected expression before 'struct'
../../include/sound/asound.h:674: error: enumerator value for 
'SNDRV_TIMER_IOCTL
_NEXT_DEVICE' is not an integer constant
../../include/sound/asound.h:675: error: expected expression before 'int'
../../include/sound/asound.h:675: error: enumerator value for 
'SNDRV_TIMER_IOCTL
_TREAD' is not an integer constant
../../include/sound/asound.h:676: error: expected expression before 'struct'
../../include/sound/asound.h:676: error: enumerator value for 
'SNDRV_TIMER_IOCTL
_GINFO' is not an integer constant
../../include/sound/asound.h:677: error: expected expression before 'struct'
../../include/sound/asound.h:677: error: enumerator value for 
'SNDRV_TIMER_IOCTL
_GPARAMS' is not an integer constant
../../include/sound/asound.h:678: error: expected expression before 'struct'
../../include/sound/asound.h:678: error: enumerator value for 
'SNDRV_TIMER_IOCTL
_GSTATUS' is not an integer constant
../../include/sound/asound.h:679: error: expected expression before 'struct'
../../include/sound/asound.h:679: error: enumerator value for 
'SNDRV_TIMER_IOCTL
_SELECT' is not an integer constant
../../include/sound/asound.h:680: error: expected expression before 'struct'
../../include/sound/asound.h:680: error: enumerator value for 
'SNDRV_TIMER_IOCTL
_INFO' is not an integer constant
../../include/sound/asound.h:681: error: expected expression before 'struct'
../../include/sound/asound.h:681: error: enumerator value for 
'SNDRV_TIMER_IOCTL
_PARAMS' is not an integer constant
../../include/sound/asound.h:682: error: expected expression before 'struct'
../../include/sound/asound.h:682: error: enumerator value for 
'SNDRV_TIMER_IOCTL
_STATUS' is not an integer constant
../../include/sound/asound.h:684: error: enumerator value for 
'SNDRV_TIMER_IOCTL
_START' is not an integer constant
../../include/sound/asound.h:685: error: enumerator value for 
'SNDRV_TIMER_IOCTL
_STOP' is not an integer constant
../../include/sound/asound.h:686: error: enumerator value for 
'SNDRV_TIMER_IOCTL
_CONTINUE' is not an integer constant
../../include/sound/asound.h:687: error: enumerator value for 
'SNDRV_TIMER_IOCTL
_PAUSE' is not an integer constant
../../include/sound/asound.h:869: error: expected expression before 'int'
../../include/sound/asound.h:869: error: enumerator value for 
'SNDRV_CTL_IOCTL_P
VERSION' is not an integer constant
../../include/sound/asound.h:870: error: expected expression before 'struct'
../../include/sound/asound.h:870: error: enumerator value for 
'SNDRV_CTL_IOCTL_C
ARD_INFO' is not an integer constant
../../include/sound/asound.h:871: error: expected expression before 'struct'
../../include/sound/asound.h:871: error: enumerator value for 
'SNDRV_CTL_IOCTL_E
LEM_LIST' is not an integer constant
../../include/sound/asound.h:872: error: expected expression before 'struct'
../../include/sound/asound.h:872: error: enumerator value for 
'SNDRV_CTL_IOCTL_E
LEM_INFO' is not an integer constant
../../include/sound/asound.h:873: error: expected expression before 'struct'
../../include/sound/asound.h:873: error: enumerator value for 
'SNDRV_CTL_IOCTL_E
LEM_READ' is not an integer constant
../../include/sound/asound.h:874: error: expected expression before 'struct'
../../include/sound/asound.h:874: error: enumerator value for 
'SNDRV_CTL_IOCTL_E
LEM_WRITE' is not an integer constant
../../include/sound/asound.h:875: error: expected expression before 'struct'
../../include/sound/asound.h:875: error: enumerator value for 
'SNDRV_CTL_IOCTL_E
LEM_LOCK' is not an integer constant
../../include/sound/asound.h:876: error: expected expression before 'struct'
../../include/sound/asound.h:876: error: enumerator value for 
'SNDRV_CTL_IOCTL_E
LEM_UNLOCK' is not an integer constant
../../include/sound/asound.h:877: error: expected expression before 'int'
../../include/sound/asound.h:877: error: enumerator value for 
'SNDRV_CTL_IOCTL_S
UBSCRIBE_EVENTS' is not an integer constant
../../include/sound/asound.h:878: error: expected expression before 'struct'
../../include/sound/asound.h:878: error: enumerator value for 
'SNDRV_CTL_IOCTL_E
LEM_ADD' is not an integer constant
../../include/sound/asound.h:879: error: expected expression before 'struct'
../../include/sound/asound.h:879: error: enumerator value for 
'SNDRV_CTL_IOCTL_E
LEM_REPLACE' is not an integer constant
../../include/sound/asound.h:880: error: expected expression before 'struct'
../../include/sound/asound.h:880: error: enumerator value for 
'SNDRV_CTL_IOCTL_E
LEM_REMOVE' is not an integer constant
../../include/sound/asound.h:881: error: expected expression before 'struct'
../../include/sound/asound.h:881: error: enumerator value for 
'SNDRV_CTL_IOCTL_T
LV_READ' is not an integer constant
../../include/sound/asound.h:882: error: expected expression before 'struct'
../../include/sound/asound.h:882: error: enumerator value for 
'SNDRV_CTL_IOCTL_T
LV_WRITE' is not an integer constant
../../include/sound/asound.h:883: error: expected expression before 'struct'
../../include/sound/asound.h:883: error: enumerator value for 
'SNDRV_CTL_IOCTL_T
LV_COMMAND' is not an integer constant
../../include/sound/asound.h:884: error: expected expression before 'int'
../../include/sound/asound.h:884: error: enumerator value for 
'SNDRV_CTL_IOCTL_H
WDEP_NEXT_DEVICE' is not an integer constant
../../include/sound/asound.h:885: error: expected expression before 'struct'
../../include/sound/asound.h:885: error: enumerator value for 
'SNDRV_CTL_IOCTL_H
WDEP_INFO' is not an integer constant
../../include/sound/asound.h:886: error: expected expression before 'int'
../../include/sound/asound.h:886: error: enumerator value for 
'SNDRV_CTL_IOCTL_P
CM_NEXT_DEVICE' is not an integer constant
../../include/sound/asound.h:887: error: expected expression before 'struct'
../../include/sound/asound.h:887: error: enumerator value for 
'SNDRV_CTL_IOCTL_P
CM_INFO' is not an integer constant
../../include/sound/asound.h:888: error: expected expression before 'int'
../../include/sound/asound.h:888: error: enumerator value for 
'SNDRV_CTL_IOCTL_P
CM_PREFER_SUBDEVICE' is not an integer constant
../../include/sound/asound.h:889: error: expected expression before 'int'
../../include/sound/asound.h:889: error: enumerator value for 
'SNDRV_CTL_IOCTL_R
AWMIDI_NEXT_DEVICE' is not an integer constant
../../include/sound/asound.h:890: error: expected expression before 'struct'
../../include/sound/asound.h:890: error: enumerator value for 
'SNDRV_CTL_IOCTL_R
AWMIDI_INFO' is not an integer constant
../../include/sound/asound.h:891: error: expected expression before 'int'
../../include/sound/asound.h:891: error: enumerator value for 
'SNDRV_CTL_IOCTL_R
AWMIDI_PREFER_SUBDEVICE' is not an integer constant
../../include/sound/asound.h:892: error: expected expression before 'int'
../../include/sound/asound.h:892: error: enumerator value for 
'SNDRV_CTL_IOCTL_P
OWER' is not an integer constant
../../include/sound/asound.h:893: error: expected expression before 'int'
../../include/sound/asound.h:893: error: enumerator value for 
'SNDRV_CTL_IOCTL_P
OWER_STATE' is not an integer constant
../../include/sound/asound.h:949: error: expected expression before 'struct'
../../include/sound/asound.h:949: error: enumerator value for 
'SNDRV_IOCTL_READV
' is not an integer constant
../../include/sound/asound.h:950: error: expected expression before 'struct'
../../include/sound/asound.h:950: error: enumerator value for 
'SNDRV_IOCTL_WRITE
V' is not an integer constant
In file included from ../../include/local.h:109,
                 from control_local.h:22,
                 from cards.c:35:
../../include/global.h:137: error: redefinition of 'struct timeval'
../../include/global.h:142: error: redefinition of 'struct timespec'
make[2]: *** [cards.lo] Error 1
make[2]: Leaving directory `/nj/alsa-source/alsa-lib/src/control'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/nj/alsa-source/alsa-lib/src'
make: *** [all-recursive] Error 1


(I know it's a lot of text, but I'm not sure how much is needed to 
determine what's wrong, not being overly familiar with alsa myself.)

Can someone help me out please?  Remember that since I'm using cygwin, 
it could be as simple as not having all the packages installed. 

Thanks,
Nathan

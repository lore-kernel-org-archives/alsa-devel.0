From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Some small fixes to
 make Playback Design products work
Date: Sun, 24 Mar 2013 12:50:57 +0200
Message-ID: <514EDA91.9000305@sonarnerd.net>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
 <514B79DA.6030203@sonarnerd.net> <514C1215.9010708@gmail.com>
 <7.0.0.16.2.20130322082602.0605cbc0@akdesigninc.com>
 <514E0A2A.1000201@sonarnerd.net>
 <7.0.0.16.2.20130323183543.0605ddb0@akdesigninc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id E9E8E265335
 for <alsa-devel@alsa-project.org>; Sun, 24 Mar 2013 11:50:59 +0100 (CET)
In-Reply-To: <7.0.0.16.2.20130323183543.0605ddb0@akdesigninc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Koch <andreas@akdesigninc.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>, demian@auraliti.com, ray@auraliti.com
List-Id: alsa-devel@alsa-project.org

On 03/24/2013 03:50 AM, Andreas Koch wrote:
> rate for PCM. If you plug that DAC into a Mac, the Mac will
> automatically select 705.6kHz for PCM and then nothing will work because
> the DAC doesn't support that in PCM. So then, the DAC would have to
> define 2 complete interfaces: one for PCM and one for DSD. That

OK, the difference is that I don't use UAC2 at all, but completely 
different protocol. So what I'm talking about is only how it looks from 
the driver towards the application...

DoP could be implemented similar way inside the UAC driver using for 
example snd_pcm_hw_rule_add() between SNDRV_PCM_HW_PARAM_FORMAT and 
SNDRV_PCM_HW_PARAM_RATE. And maybe enabled as quirks?

There are many devices having constraints between rate and channels. In 
this case we just have a constraint between rate and formats.

Looking at the UAC driver there seems to be something a bit related:
                 /* FIXME: there is no AC3 format defined yet */
                 // fp->formats = SNDRV_PCM_FMTBIT_AC3;
                 fp->formats = SNDRV_PCM_FMTBIT_U8; /* temporary hack to 
receive
  byte streams */


	- Jussi

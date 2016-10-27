From: Alan Young <consult.awy@gmail.com>
Subject: Accurate delay reporting from dshare
Date: Thu, 27 Oct 2016 11:15:58 +0100
Message-ID: <5811D3DE.8030901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 6271D26688A
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 12:16:04 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id b80so1896943wme.2
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 03:16:04 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

When the kernel reports current (playback) delay via a call to 
snd_pcm_status() or snd_pcm_delay() for a normal hardware PCM, then the 
delay value reported is the sum of space used in the ring buffer plus 
any delay reported from the underlying runtime driver.

snd_pcm_dshare_status() and snd_pcm_dshare_delay() discard this 
refinement and simply report the use of some ring buffer. Why does it do 
this and how could the reporting be improved? In particular I am 
struggling to understand the relationship between a dshare instance's 
(view of a) ring buffer and the slave (hw) PCM's ring buffer.

I understand that the *slowptr* configuration item can be set to get 
more accurate position updates as part of this reporting but I get the 
feeling that this will not on its own solve the problem. If it did then 
one could simply use the delay value reported by the slave PCM.

The context of these questions is using dshare to expose 4 logical 
stereo devices on a platform using an ARM-based SoC with a single 
8-channel hardware driver. I need to get the same level of delay report 
accuracy as I would do without using dshare.

Alan.

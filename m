From: Dan Hordern <dh.mailing.lists@gmail.com>
Subject: Get sound card available channels
Date: Thu, 25 Sep 2014 10:39:59 +1000
Message-ID: <CA+BmFj2fTUFYKoWnae=pV7oraRPg1YkVTKyh=jqAM+A0fbz54Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f67.google.com (mail-qg0-f67.google.com
 [209.85.192.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 00EED265112
 for <alsa-devel@alsa-project.org>; Thu, 25 Sep 2014 02:40:00 +0200 (CEST)
Received: by mail-qg0-f67.google.com with SMTP id q108so2093033qgd.6
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 17:40:00 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Hi,

We have a need for our process to poll/monitor the sound cards. This
process needs to provide a unique id for the sound card (e.g. some concat
of name+hardware address) which we can get using snd_ctl_t handle.

However, we also need to provide the number or rx/tx channels each sound
card provides. Doing this using the pcm hw_params after snd_pcm_open won't
work as the device may be in use.

Is there a way for this process to get the number of rx/tx channels without
needing to 'open' the device, e.g. using the snd_ctl_t handle?

One observation I have made is that there is a proc file ( cat
/proc/asound/card1/stream0) that seems to only be populated by the USB
soundcards I have and not the Intel builtin. This has all the information I
require but if it isn't a standard file we can't rely on it.

Thanks

From: sonntex <sonntex@gmail.com>
Subject: snd_pcm_hw_params resets microphone boost
Date: Thu, 8 Nov 2018 00:28:37 +0300
Message-ID: <CAPeTicNf-d_h0KM9CmT0UX4KFf7RfEuwMN2QuRSEPLEMuyK9bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com
 [209.85.219.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B30226751A
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2018 22:28:50 +0100 (CET)
Received: by mail-yb1-f178.google.com with SMTP id z2-v6so7479012ybj.2
 for <alsa-devel@alsa-project.org>; Wed, 07 Nov 2018 13:28:50 -0800 (PST)
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

I have small program that captures audio from a microphone. As my
microphone is very sensitive, I prefer to mute the microphone boost before
capturing. I open alsamixer and set volume of the microphone boost to zero,
save settings and exit. Then I execute my program. I see that it resets
volume of the microphone boost in snd_pcm_hw_params. What should I do
resolve this problem? Where can I find default value and change it?

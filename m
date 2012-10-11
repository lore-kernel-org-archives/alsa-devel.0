From: kartik natarajan <kartik8n8@gmail.com>
Subject: Arecord issue
Date: Thu, 11 Oct 2012 18:24:48 +0530
Message-ID: <CAAe3XR3rDQb4U8EUq5COCHH5oAtXR2tVcFROBVTN0rsZvJdt+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f179.google.com (mail-ia0-f179.google.com
 [209.85.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B8CF265128
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2012 14:54:50 +0200 (CEST)
Received: by mail-ia0-f179.google.com with SMTP id k25so1140848iah.38
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2012 05:54:49 -0700 (PDT)
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
    I am working on a 2.6.37 kernel and on a DM365 davinci board with a
tlv320aic3254 audio codec (i2c control lines, i2s data transfer)
I wanted to get the audio up on my board so got the alsa-lib and alsa-utils
1.0.25 compiled them and got the aplay to work fine.
When I got to working on the arecord things haven't worked fine. I have
traced all the calls and have reached so far;
codec gets set properly
davinci_pcm_trigger executes with success
snd_pcm_sw_params() executes successfully.
aplay calls begin_wave()
aplay calls pcm_read() that invokes  snd_pcm_readi()
Finally my app seems to not go beyond the snd_pcm_start()

Any assistance shall be highly appreciated!

Thanks in advance,
N.Kartik

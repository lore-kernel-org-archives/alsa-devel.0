From: Diego Sueiro <diego.sueiro@gmail.com>
Subject: Sound Card driver for audio codec, mux and dsp.
Date: Wed, 17 Jul 2013 10:17:11 -0300
Message-ID: <CAMCfZKGJYKvnToaSMp6TEHyOHEa4u5+vwSk4EMQvKiNbzVyT7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 56CF326546D
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 15:17:32 +0200 (CEST)
Received: by mail-ie0-f169.google.com with SMTP id 10so3938040ied.14
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 06:17:31 -0700 (PDT)
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

Hi there,

I need to develop a solution to expose to userspace a single sound
card with mixer controls for:

Audio codec : sgtl5000
Audio mux: used to select an audio source on sgtl5000 LINE_IN.
Audio dsp :sta309a

How can I implement this drivers? Should I have to create a sound-card
driver which is going to register and control the other drivers
(codec, mux, dsp)?

Is there some device driver or tutorial guide that I can use as an example?

I'm using the kernel 3.0.15 from Freescale [1].


[1] - http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/log/?h=imx_3.0.15_android

Kind Regards,

--
*dS
Diego Sueiro

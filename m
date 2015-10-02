From: Paolo Tagliavini <paolo.tagliavini@gmail.com>
Subject: ATMEL sam9g25 SSC in I2S slave mode on linux 4.1.1
	play only right channel
Date: Fri, 2 Oct 2015 15:08:26 +0200
Message-ID: <CAAFFdUkTdKeW7vmXRAqVKkGTUexJE7njHuht+Zdi9oDkFHQV6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f169.google.com (mail-yk0-f169.google.com
 [209.85.160.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 461AC266903
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 15:08:27 +0200 (CEST)
Received: by ykft14 with SMTP id t14so109721283ykf.0
 for <alsa-devel@alsa-project.org>; Fri, 02 Oct 2015 06:08:26 -0700 (PDT)
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

I'm working on my based sam9g25 design.
To have SPDIF output I used cs4265 codec instead of wm8731 as sem9g25
reference design.
Now I'm working on porting of cs4265 codec driver.
It work for play only right  channel, left channel is mute and not supplied
by SSC.
SSC is configured as I2S slave :
SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM

Do you know  this behaviour ? There is a patch for fix it ?

Thank you in advance.

From: Adish Kuvelker <adkuvi@gmail.com>
Subject: snd_pcm_hardware structure
Date: Wed, 23 Jun 2010 22:52:57 +0530
Message-ID: <AANLkTilJuFy_Iysklk-nsE_BzPzgHvQpGW0T3uGhulZt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 48E841037EA
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 19:23:01 +0200 (CEST)
Received: by vws20 with SMTP id 20so1168825vws.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 10:22:58 -0700 (PDT)
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

Hello,

I am developing a ALSA driver for the AtlasIII AC'97 Controller. The
AC'97 Controller FIFO is arranged as 16 32-bit entries. My PCM data
would be 16-bit samples and the driver will cater to 2-front channel
audio. I have configured the snd_pcm_hardware members as follows:
.formats = SNDDRV_PCM_FMTBIT_S16_LE
.period_bytes_max = 4,
.period_bytes_min = 64,
As I would need a minimum of 4-byte sample to be transferred and the
"period_bytes_max" value has been set considering the maximum size of
the FIFO in bytes. Is my understanding correct in doing these
settings?

Secondly, I am having slight problems in understanding the
"snd_pcm_hardware" members periods_min and periods_max. Can anyone
throw some more light on this in addition to what is explained in the
"Writing an Audio Driver"?

Regards;
Aadish

From: noman pouigt <variksla@gmail.com>
Subject: USB Gadget audio not working
Date: Tue, 20 Sep 2016 15:00:11 -0700
Message-ID: <CAES_P+9tg-Jgf3buOJwo1pGKX4USvoo6Fx_AEygMGiGaKVTeXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f172.google.com (mail-yw0-f172.google.com
 [209.85.161.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 5692A266D9C
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 00:00:13 +0200 (CEST)
Received: by mail-yw0-f172.google.com with SMTP id i129so23878619ywb.0
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 15:00:13 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ruslan.bilovol@gmail.com, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hello,

I am trying to use my device as a sound card and enabled
CONFIG_USB_AUDIO. However I don't know what kind
of device node should be added in the machine file?

I just want to record whatever is coming into the USB played
back by the host over USB.

I could get my device to be detected as a sound card i.e.
USB_AUDIO_CLASS in my ubuntu machine.

My understanding of USB audio is very less so I thought
below change should be sufficient.

Below are the only changes which i have done to enable USB_AUDIO.

Machine file:
{
.name = "something_random",
.stream_name = "USB Capture",
.cpu_dai_name = "snd-soc-dummy-dai",
.codec_dai_name = "snd-soc-dummy-dai",
.codec_name = "snd-soc-dummy",
.ignore_suspend = 1,
},

drivers/usb/gadget/u_uac1.c :
#define FILE_PCM_PLAYBACK "/dev/snd/pcmC0D0p"
#define FILE_PCM_CAPTURE "/dev/snd/pcmC0D0c"

in defconfig
CONFIG_USB_AUDIO=y

Please let me know if I am doing anything wrong.

Thanks,

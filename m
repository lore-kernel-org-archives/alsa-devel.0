From: Ran Shalit <ranshalit@gmail.com>
Subject: 'control ... is already present' message
Date: Fri, 11 Sep 2015 09:48:37 +0300
Message-ID: <CAJ2oMhJF9=jaJLhPAqGPg=yzh0WQoD6ire1-p-zeKRHKp---bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
 [209.85.213.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 15FB2261555
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2015 08:48:39 +0200 (CEST)
Received: by igbkq10 with SMTP id kq10so34622220igb.0
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2015 23:48:38 -0700 (PDT)
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

Hello,

I'm using 2 codecs (tlv320aic3x-codec)  each which both are registered
into same sound card, each as a single device.
After boot I have the following devices:

root@dm814x:~# cat /proc/asound/devices
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 17: [ 0- 1]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture

But I get the following error messeges during boot:
usbcore: registered new interface driver snd-usb-audio
Registered tvp5158 audio codec
PM: Adding info for platform:soc-audio.0
PM: Adding info for No Bus:TLV320AIC3X_2
asoc: tlv320aic3x-hifi <-> davinci-mcasp.2 mapping ok
snd_soc_instantiate_card 7
tlv320aic3x-codec 2-0019: tlv320aic3x-codec.2-0019: Failed to add PCM
Playback Volume: -16
asoc: failed to add dapm kcontrol Right HPCOM Mixer Line2L Bypass Switch: -16
asoc: failed to add dapm kcontrol Left HPCOM Mixer Line2L Bypass Switch: -16
asoc: failed to add dapm kcontrol Right HP Mixer Line2L Bypass Switch: -16
asoc: failed to add dapm kcontrol Left HP Mixer Line2L Bypass Switch: -16
asoc: failed to add dapm kcontrol Mono Mixer Line2L Bypass Switch: -16
asoc: failed to add dapm kcontrol Right Line Mixer Line2L Bypass Switch: -16
asoc: failed to add dapm kcontrol Left Line Mixer Line2L Bypass Switch: -16
asoc: failed to add kcontrol Right Line2R Mux
asoc: failed to add kcontrol Right Line1R Mux
asoc: failed to add kcontrol Right Line1L Mux
asoc: failed to add dapm kcontrol Right PGA Mixer Line1R Switch: -16
asoc: failed to add kcontrol Left Line2L Mux
asoc: failed to add kcontrol Left Line1R Mux
asoc: failed to add kcontrol Left Line1L Mux
asoc: failed to add dapm kcontrol Left PGA Mixer Line1L Switch: -16
asoc: failed to add kcontrol Right HPCOM Mux
asoc: failed to add kcontrol Right DAC Mux
asoc: failed to add kcontrol Left HPCOM Mux
asoc: failed to add kcontrol Left DAC Mux
PM: Adding info for No Bus:TLV320AIC3X_3
asoc: tlv320aic3x-hifi <-> davinci-mcasp.3 mapping ok
PM: Adding info for No Bus:card0
PM: Adding info for No Bus:pcmC0D1p
PM: Adding info for No Bus:pcmC0D1c
PM: Adding info for No Bus:pcmC0D0p
PM: Adding info for No Bus:pcmC0D0c
PM: Adding info for No Bus:controlC0
ALSA device list:
  #0: TI81XX SOUND0

What is the reason for the "asoc: failed to add dapm kcontrol" and the
" 'control ... already present" messeges ?
Is it becuase both codec are registered on same card (single card) ?

1. If I move each to be registered to its own card,  will it resolve
this issue ?

2. Should the following patch resolve this issue:
http://mailman.alsa-project.org/pipermail/alsa-devel/2010-November/033593.html

Regards,
Ran

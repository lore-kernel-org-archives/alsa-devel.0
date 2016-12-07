From: Joseph Wang <joequant@gmail.com>
Subject: Re: Cherry trail and Nau 88l24 codec
Date: Wed, 7 Dec 2016 03:01:03 -0500
Message-ID: <CAPoeEY98GP9VCQLPKSL0sUo3TDcgxHf65wCbR=T95wyJz2Ai7Q@mail.gmail.com>
References: <CAPoeEY_Tve2TAgBqY+MqPEUGnbadYHg9Z90DQ=YQumWebfW++A@mail.gmail.com>
 <62e35b1dac6b4000beb73d857f780f04@NTHCML01B.nuvoton.com>
 <CAPoeEY8=A949-cuVwfyov2GfpQc=hAjPsDG-suXmT_TDytOKBQ@mail.gmail.com>
 <30f62f0d-1e3e-0839-8d85-df9e209b5cf9@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id BAB0F26691A
 for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2016 09:01:07 +0100 (CET)
Received: by mail-qk0-f195.google.com with SMTP id y205so47116316qkb.1
 for <alsa-devel@alsa-project.org>; Wed, 07 Dec 2016 00:01:07 -0800 (PST)
In-Reply-To: <30f62f0d-1e3e-0839-8d85-df9e209b5cf9@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: CTLIN0@nuvoton.com, alsa-devel@alsa-project.org, KCHSU0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Making good progress.  I rebuilt and reinstalled my kernel, and the
firmware timeouts disappeared.  The system is seeing the card.  I'm getting
the attached errors.  While hitting random buttons in alsa mixer, I came up
with one combination that gave me static, but I couldn't replicate that.
However, it means that something is happening.

I used the following for mixer settings

#DSP routing
amixer -c0 sset 'codec_out0 mix 0 pcm0_in' on
amixer -c0 sset 'media0_out mix 0 media1_in' on
amixer -c0 sset 'media1_in Gain 0' 80%
amixer -c0 sset 'media1_in Gain 0 Ramp Delay' 50
amixer -c0 sset 'media1_in Gain 0' off
amixer -c0 sset 'pcm0_in Gain 0' 80%
amixer -c0 sset 'pcm0_in Gain 0 Ramp Delay' 50
amixer -c0 sset 'pcm0_in Gain 0' off
amixer -c0 sset 'codec_out0 Gain 0' 80%
amixer -c0 sset 'codec_out0 Gain 0 Ramp Delay' 50
amixer -c0 sset 'codec_out0 Gain 0' off

If someone has some ideas on what the mixer setting should be that would
useful.  Also, I can't seem to find documentation on how all of the
switches work.  If someone can point me to that this would also be very
useful.





[  305.825863]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[  305.826348]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[  305.826569]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[  305.828013]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[  305.828560]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[  305.828882]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[  305.830556]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[  305.831284]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[  305.831791]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[  305.834121] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[  305.835515] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[  305.837214] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[  305.838713] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[  305.848477] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port
[  305.873277] intel_sst_acpi 808622A8:00: Alloc for str 1 pipe 0x90

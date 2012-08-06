From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: multistreaming realtek hda codec
Date: Mon, 6 Aug 2012 16:42:31 +0800
Message-ID: <CAN8cciZ4+AOB_VpgzVEAWpmK0kd+nXS=QOPxUzPQsu4PLXh8Fg@mail.gmail.com>
References: <CAN8ccibnNy+GFAvUNu_3Xr4nN7BY3xyjOE4Msw=KGDZgRyCRew@mail.gmail.com>
 <CAN8cciZRDz-EMCqxZzH2vqbSQaqx=x0z6w6RHKymUBaZw+p+HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 041FC265372
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 10:12:46 +0200 (CEST)
Received: by qcse14 with SMTP id e14so1494930qcs.38
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 01:42:32 -0700 (PDT)
In-Reply-To: <CAN8cciZRDz-EMCqxZzH2vqbSQaqx=x0z6w6RHKymUBaZw+p+HA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: cepasp@rit.edu, alsa-devel@alsa-project.org, pulseaudio-discuss@lisr.freedesktop.org
List-Id: alsa-devel@alsa-project.org

>I have been trying to get a second codec working on a computer that has
two codecs - one for the front speakers,
>one for the rear panel line outs.  So far I haven't been able to get this
working.  I received this message from
the manufacturer of the board:

>"R&D has determined that the ability to have selectable or dual line-out
in the current hardware design is
>limited by Linux OS kernel. The HDA sound driver did not anticipate and
did not include support for two
>identical audio codecs (ALC888) in a system - therefore, the 2nd codec
cannot be successfully
>initialized. To fix this issue, the Linux kernel level sound driver
(controls function) would need to be
>modified to cover full functional control of the 2nd codec. This
modification is very challenging and
>involves time, risk, and potential unknown side effects - because we are
talking about modifying the
>kernel of the Linux OS and different version of kernel may have different
structures as well.

Do you mean multiple streaming ?

The ALC888 series are high-performance 7.1+2 Channel High Definition Audio
Codecs providing ten DAC channels that simultaneously support 7.1 sound
playback, plus 2 channels of independent stereo sound output (multiple
streaming) through the front panel stereo outputs

Both via and adi hda codecs support multiple streaming by independent
headphone, you just need to assign spec->alt_dac_nid and
spec->analog_stream_alt_playback in patch_realtek.c when the hda controller
support enough stream and hda codec has a  dac for the headphone.

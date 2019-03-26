From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: regression: bad sound card type detection in audio
	graph
Date: Tue, 26 Mar 2019 19:09:45 +0100
Message-ID: <17699625-dd15-afc7-780f-c7c2d4721525@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F11F5F80760
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 19:09:48 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: kuninori.morimoto.gx@renesas.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, olivier.moysan@st.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Hello Kuninori,

We are seeing a regression while rebasing on kernel V5.1 (from v4.19).
The regression is linked to your update of the audio graph to merge the
support of the normal and DPCM sound cards.

In our sound card (described here:
https://github.com/STMicroelectronics/linux/blob/v4.19-stm32mp/arch/arm/boot/dts/stm32mp157c-ev1.dts)

We declare a normal sound card using the WM8994 codec:

  Playback: CPU-DAI (SAI2a)-> CODEC-DAI/port0
  Record: CPU-DAI (SAI2B)<- CODEC-DAI/port1
  ...

The WM8994 codec is declared with 2 ports as it supports 2 interfaces.

When we probe the sound card we are detecting a wrong dai link type
because the condition
if (of_get_child_count(codec_port) > 1) return true. The dai link is
detected as DPCM instead of the expected normal link.

I checked your last commits sent on mailing list, seems that this
criteria is still valid.

Please could you elaborate a little bit on this criteria for the
normal/DPCM selection?

What is you feeling about this limitation. Do you see a way to refine
the condition to allow normal sound card with multi-port codecs. Or do
we have to migrate our sound card to DPCM.

Thanks in advance for your answer

Regards
Arnaud

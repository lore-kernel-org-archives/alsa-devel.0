From: Carlo Caione <carlo@endlessm.com>
Subject: RT5640 jack detection
Date: Tue, 22 Sep 2015 11:18:57 +0200
Message-ID: <CAL9uMOHM3tbdKT7s4panz8zyYxu35F38GLUtu9DSmgrQr=Ciqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A6E7261AE4
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 11:18:59 +0200 (CEST)
Received: by iofb144 with SMTP id b144so9430117iof.1
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 02:18:58 -0700 (PDT)
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
Cc: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Hi,
I'm working with the ALC5640-VB audio codec based on the Realtek
RT5640. On my setup the codec is only used for audio output through an
headphone jack, otherwise the audio should be routed via HDMI.

The problem is that the jack sensing only works when the codec is
actively playing something, that is when the bias set for the codec is
not SND_SOC_BIAS_OFF. When the codec is suspended and it is powered
off I'm not able to detect anymore the presence of the jack. Because
of this issue actively switching the audio from HDMI to HP when the
jack is inserted is not working.

The driver I'm using for the RT5640 in the .set_bias_level hook
function among other things is gating the I2S input clock and this
seems to prevent the generation of the IRQ signal I'm using to detect
the presence/absence of the jack (the culprit here is MX-FA[0] bit for
those interested).

I can easily modify the codec driver to avoid gating the I2S clock
when the bias is off but this seems in contrast with the whole DAPM
principle.

How this is usually supposed to be working?

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless

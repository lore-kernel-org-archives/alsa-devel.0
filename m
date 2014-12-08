From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: I2S frame configuration
Date: Mon, 08 Dec 2014 18:01:32 +0100
Message-ID: <5485D96C.3020900@ladisch.de>
References: <5485C5CA.8030402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 7C74726047C
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 18:01:34 +0100 (CET)
In-Reply-To: <5485C5CA.8030402@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: thomas chen <tchen61@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

thomas chen wrote:
> I am working on a ALSA interface to a particular codec over I2S
>
> the audio stream format is a bit peculiar...
>
> there are 24 BCLK cycle between transition of FSYNC...   howver, there ar=
e only 16 bit that are valid
>
> bit 0: ignore
> bit 1-16:   valid pcm data (MSB....LSB)
> bit 17-23: ignore

This is the 'original' I=B2S format.  The format where the sample begins
with the 1st BCLK usually is called left-justified (and uses the
opposite FSYNC polarity).

Having ignored bits is common.  (Typically, there are 32 BCLK cycles per
sample.)

In ASoC, this would be SND_SOC_DAIFMT_I2S and SND_SOC_DAIFMT_LEFT_J.


Regards,
Clemens

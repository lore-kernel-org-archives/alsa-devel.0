From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Low sample rates for SGTL5000 on i.MX28
Date: Thu, 13 Nov 2014 10:32:01 -0200
Message-ID: <CAOMZO5BAaL8cP+7NetvNyEiGfokiyLWdpXw3r=AJspLj1dfzxw@mail.gmail.com>
References: <546450E5.9090203@beamcommunications.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 71A1426530C
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 13:32:02 +0100 (CET)
Received: by mail-la0-f53.google.com with SMTP id mc6so13297231lab.12
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 04:32:02 -0800 (PST)
In-Reply-To: <546450E5.9090203@beamcommunications.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Craig McQueen <craig.mcqueen@beamcommunications.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 13, 2014 at 4:34 AM, Craig McQueen
<craig.mcqueen@beamcommunications.com> wrote:
> I'm testing the 3.18 kernel for i.MX28 EVK, which has an SGTL5000 CODEC. I
> notice that audio cannot be output at 8 kHz or 11.025 kHz, although the
> SGTL5000 data sheet table 8 indicates this should be possible.
>
> If I try to play or record at 8 kHz or 11.025 kHz, I get an error message:
>
>     # aplay test_8k.wav
>     [ 6168.910201] mxs_evk_startup: Skipped programming wolfson codec

Is this really a mainline kernel? I don't see any 'mxs_evk_startup' in mainline.

>     Playing WAVE 'test_8k.wav' : Signed 16 bit Little Endian, Rate 8000 Hz,
> Mono
>     [ 6168.941211] sgtl5000 0-000a: Invalid mclk frequency: 4.096MHz
>     [ 6168.947047] mxs-sgtl5000 sound.11: ASoC: machine hw_params failed:
> -22
>     aplay: set_params:1145: Unable to install hw params:
>     ...
>
> For an 8 kHz sample rate, I get
>
>     Invalid mclk frequency: 4.096MHz

I am not able to reproduce this bug here. I can play 8kHz file on the mx28evk:

root@freescale /home$ aplay mono_8k.wav
Playing WAVE 'mono_8k.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono

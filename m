From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Transmitting ac3 content via spdif
Date: Thu, 1 Nov 2012 23:58:27 -0200
Message-ID: <CAOMZO5BHfTS0T+SLRKDfv6hiQU9erqWjPGLJO51eQaGt0wH1tQ@mail.gmail.com>
References: <CAOMZO5AqmDEMOWO1JOaej4cgicyqvPeGfeTFO++Lu06VbNYewA@mail.gmail.com>
 <CAOMZO5DjztEe4FqEjPj-4Y2M8HB480Zp9J-_n6+69o0yT9hKDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F81F264F0D
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2012 02:58:28 +0100 (CET)
Received: by mail-oa0-f51.google.com with SMTP id n12so2980011oag.38
 for <alsa-devel@alsa-project.org>; Thu, 01 Nov 2012 18:58:27 -0700 (PDT)
In-Reply-To: <CAOMZO5DjztEe4FqEjPj-4Y2M8HB480Zp9J-_n6+69o0yT9hKDA@mail.gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <b29396@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 26, 2012 at 7:50 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Fri, Oct 26, 2012 at 5:30 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> Hi,
>>
>> I am trying to transmit ac3 content via spdif on a mx6 (on a yet
>> non-mainlined driver).
>>
>> Tried to force non-audio mode via iecset:
>>
>> # iecset audio 0
>> control "IEC958 Playback Default" (index -1) not found
>
> Ok, need to pass "-c 1" option to iecset:
>
> $ iecset -c 1 audio 0
> Mode: consumer
> Data: non-audio
> Rate: 44100 Hz
> Copyright: permitted
> Emphasis: none
> Category: general
> Original: 1st generation
> Clock: 1000 ppm
> root@imx6qsabrelite:/home# aplay -D hw:1,0 -f dat /home/mcxpk_audio_capture.ac3
> Playing raw data '/home/mcxpk_audio_capture.ac3' : Signed 16 bit
> Little Endian, Rate 48000 Hz, Stereo

Just to close this issue, in case someone else wants to do the same thing.

Managed to stream AC3 via HDMI using ac3dec tool:

ac3dec -D hw:1,0 -C test.ac3

Regards,

Fabio Estevam

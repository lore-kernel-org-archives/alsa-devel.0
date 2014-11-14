From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Pop and offsets at start of audio playback/record
 for SGTL5000 on i.MX28
Date: Fri, 14 Nov 2014 01:59:04 -0200
Message-ID: <CAOMZO5CXzFj__SE+pDkHwmAUMREzebuEWsQ1tHRjgKN8EAMPXw@mail.gmail.com>
References: <54655E35.9000807@beamcommunications.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DE7A2604E8
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 04:59:05 +0100 (CET)
Received: by mail-lb0-f179.google.com with SMTP id l4so12268400lbv.10
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 19:59:04 -0800 (PST)
In-Reply-To: <54655E35.9000807@beamcommunications.com>
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

On Thu, Nov 13, 2014 at 11:43 PM, Craig McQueen
<craig.mcqueen@beamcommunications.com> wrote:
> I'm testing the 3.14.19 kernel for i.MX28 EVK, which has an SGTL5000 CODEC.
> I've also tested on the 3.18-rc4 kernel and confirmed this issue still
> occurs.
>
>
> Playback
>
> When doing audio playback, I notice that the audio "fades in" over the first
> (approximately) 500 ms of playback. This is very noticeable and not ideal in
> certain applications (e.g. audio notifications that are of short duration).

It seems that this behaviour can be controlled by the SMALL_POP bit:
"Setting this bit slows down the VAG ramp from ~200ms to ~400ms to
reduce the startup
pop, but increases the turn on/off time."

Looking at the code I see its definition is wrong:

--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1307,8 +1307,7 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)

        /* enable small pop, introduce 400ms delay in turning off */
        snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
-                               SGTL5000_SMALL_POP,
-                               SGTL5000_SMALL_POP);
+                               SGTL5000_SMALL_POP, 1);

        /* disable short cut detector */
        snd_soc_write(codec, SGTL5000_CHIP_SHORT_CTRL, 0);
diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
index 2f8c889..bd7a344 100644
--- a/sound/soc/codecs/sgtl5000.h
+++ b/sound/soc/codecs/sgtl5000.h
@@ -275,7 +275,7 @@
 #define SGTL5000_BIAS_CTRL_MASK                        0x000e
 #define SGTL5000_BIAS_CTRL_SHIFT               1
 #define SGTL5000_BIAS_CTRL_WIDTH               3
-#define SGTL5000_SMALL_POP                     0x0001
+#define SGTL5000_SMALL_POP                     0

This change keeps the original intention of enabling 'small pop'. You
can try 'SGTL5000_SMALL_POP, 0);' to see if you get a quicker
response.

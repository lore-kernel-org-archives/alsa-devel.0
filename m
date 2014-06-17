From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: Sound issue in IMx6
Date: Tue, 17 Jun 2014 15:55:28 +0530
Message-ID: <CAKDJKT545O8jOWCOk-U=+OK5aQVft4rJ-0YH8bgujmdMcC782A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 02C7E265530
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 12:25:32 +0200 (CEST)
Received: by mail-pd0-f170.google.com with SMTP id z10so4005584pdj.1
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 03:25:29 -0700 (PDT)
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

Hi All,

In our android project, We are using IMx6 chip which is having SSI module
to send data to codec.

We are facing issues with PCM data which is getting passed to codec
getting changed sometimes (even though android is filling up same data).

Our use case is as follows:

Press key on keypad (PCM open  function gets called) and after 3secs
of inactivity PCM close function get called.
After doing this above activity,quite number of times we have seen
sometimes sound gets changed abruptly.

I have seen your commit in mainline which is fix to almost similar
behavior as I explained above in usecase.
Commit: ASoC: fsl: imx-ssi: omit ssi counter to avoid harm in
unbalanced situation
But still after applying above change issue gets seen sometimes.

After this I put some delay in "imx_ssi_trigger" function as below:
@@ -360,9 +360,9 @@ static int imx_ssi_trigger(struct
snd_pcm_substream *substream, int cmd,
                        scr |= SSI_SCR_RE;
                sier |= sier_bits;

-               if (++ssi->enabled == 1)
-                       scr |= SSI_SCR_SSIEN;
-
+               scr |= SSI_SCR_SSIEN;
+               mdelay(1);
                break;

        case SNDRV_PCM_TRIGGER_STOP:
@@ -374,9 +374,10 @@ static int imx_ssi_trigger(struct
snd_pcm_substream *substream, int cmd,
                        scr &= ~SSI_SCR_RE;
                sier &= ~sier_bits;

-               if (--ssi->enabled == 0)
+               if (!(scr & (SSI_SCR_TE | SSI_SCR_RE)))
                        scr &= ~SSI_SCR_SSIEN;
-
+                       mdelay(1);
                break;

and with this change I never seen issue. But looking like delay to put
is just a workaround. Even in datasheet it is not mentioned
to put any delay after SSI enabled/disabled. Please let me know if
anybody have any proper solution/hints for this issue.
Also, let me know if any more information requires.

We are using 3.0.35 kernel.

Regards
Manish Badarkhe

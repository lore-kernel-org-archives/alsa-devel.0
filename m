From: GitHub issues - opened <github@alsa-project.org>
Subject: Sound Blaster RX does not play sound in side channels
Date: Tue, 13 Aug 2019 19:45:08 +0200 (CEST)
Message-ID: <20190813174508.1C924F80273@alsa1.perex.cz>
References: <1565718304886940956-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A5B69F80120
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2019 19:45:05 +0200 (CEST)
In-Reply-To: <1565718304886940956-webhooks-bot@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

alsa-project/alsa-lib issue #9 was opened from logan001:

I don't have the card anymore but maybe someone else have it and can provide some help cause i like the card bass/treble control and if the bug is fixed i will buy it.
The card does not output side channels at all. 5.1 works but 7.1 side channels gives no sound with speaker-test -c 8
pulseaudio also gives no sound for side channels in speaker tests.
i don't know if its the right place to report this bug but i've tried on kernel bugzilla and there is no movement there.
the kernels i've tried 1 month ago are 4.18 and 5.1.15
here is the [alsainfo](https://bugzilla.kernel.org/attachment.cgi?id=283467) at that time

what i found strange is that alsamixer when i change the sound card had the side channels volume set at 0. its like by default was build intentionally without side channels support.

and yes i have that special cable with 3 jacks (sound card) to 4 jack (for speakers). i have it from an old audigy 2 zs if i remeber corectly. and the cable works since i tested 7.1 in windows without any issues.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/9
Repository URL: https://github.com/alsa-project/alsa-lib

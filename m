From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: wm97xx touch does not work after ac97 delayed dev reg
	removal
Date: Mon, 19 Jan 2015 16:46:00 +0100
Message-ID: <CAOLZvyE3tEec4QpdeYrJwNJEjcf18zodjF1XtQjzaeRdHA32wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 027CA260A56
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 16:46:45 +0100 (CET)
Received: by mail-wi0-f169.google.com with SMTP id bs8so17555624wib.0
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 07:46:41 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Lars,

Since commit 6794f709b7124ff1e574c4f4c9494418ab56c4b4
(ASoC: ac97: Drop delayed device registration) the wm9712 ts on
my MIPS DB1300 board doesn't work any more:

wm97xx-ts 0-0:wm9712-codec.1: Device with vendor 0000 is not a wm97xx
db1200-ac97 db1300-ac97.0: wm9712-hifi <-> au1xpsc_ac97.1 mapping ok
wm9712-codec wm9712-codec.1: ASoC: mux Differential Source has no paths
wm9712-codec wm9712-codec.1: ASoC: mux Capture Phone Mux has no paths
db1200-ac97 db1300-i2s.0: wm8731-hifi <-> au1xpsc_i2s.2 mapping ok

whereas before this patch:
[    1.820000] db1200-ac97 db1300-ac97.0: wm9712-hifi <->
au1xpsc_ac97.1 mapping ok
[    1.820000] wm9712-codec wm9712-codec.1: ASoC: mux Differential
Source has no paths
[    1.830000] wm9712-codec wm9712-codec.1: ASoC: mux Capture Phone
Mux has no paths
[    1.840000] wm97xx-ts 0-0:wm9712-codec.1: detected a wm9712 codec
[    1.850000] input: wm97xx touchscreen as
/devices/platform/db1300-ac97.0/0-0:wm9712-codec.1/input/input0
[    1.860000] db1200-ac97 db1300-i2s.0: wm8731-hifi <-> au1xpsc_i2s.2
mapping ok


Do you have any ideas how to solve this?

Thanks!
     Manuel

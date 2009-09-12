From: jassi brar <jassisinghbrar@gmail.com>
Subject: WM8580 DAI: Debugged
Date: Sat, 12 Sep 2009 17:05:57 +0900
Message-ID: <1b68c6790909120105rabd3309md476f7bef5338caa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f192.google.com (mail-qy0-f192.google.com
	[209.85.221.192])
	by alsa0.perex.cz (Postfix) with ESMTP id 182382464B
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Sep 2009 10:05:58 +0200 (CEST)
Received: by qyk30 with SMTP id 30so1540800qyk.5
	for <alsa-devel@alsa-project.org>; Sat, 12 Sep 2009 01:05:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,
    I have been making SMDK6410 I2S work with WM8580 codec.
In the process i debugged the wm8580 driver.

The patch is:-
 Last patch(Minor WM8580 enhancements)  _minus_  the MCLKRATIO/BCLKRATIO stuff
_plus_ the snd_soc_dai definition debugged.
The snd_soc_dai debugging is necessary if the Audio Capture is to
work with the CODEC driver.

Next comes the patch.....

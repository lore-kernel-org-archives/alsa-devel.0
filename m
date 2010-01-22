From: shariff <shariffsinbox@gmail.com>
Subject: Reg: Audio recording with twl4030 codec
Date: Fri, 22 Jan 2010 15:27:23 +0530
Message-ID: <1cbe56071001220157u5133ae91mf89dabb2f4da8fdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id DA55524396
	for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2010 10:57:25 +0100 (CET)
Received: by pwi4 with SMTP id 4so1518185pwi.32
	for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2010 01:57:23 -0800 (PST)
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
List-Id: alsa-devel@alsa-project.org

Hi all,

        I am working with OMAP3 based custom board that has twl4030 codec &
        using linux-2.6.29 kernel from opensource.

        I have some queries regarding Audio recording.

       Audio codec is connected to twl4030 as bellow

                                  TWL4030
                             |--------------------|
                             |                    |------ MAINMIC
      McBSP2  ------  |i2s/tdm         |
                             | ___________|

      --> One Analog MIC is connected to Main Mic and I am using Audio path
not the Voice path.

           After selecting Main Mic through amixer control.

           and recording audio using "arecord -c 1 -r 8000 -f S16_LE -t wav
-d 20 record-file.wav"

       --> Here record is successful but with lot of noise.

          1) Can we record Mono(1 channel) through I2S from TWL4030 codec?

          2) To record stereo(2 channels), do we need two Mic's ? (i.e do I
need Sub Mic also).

Regards,
Shariff

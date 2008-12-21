From: "Paulo Cavalcanti" <promac@gmail.com>
Subject: Sigmatel codec on Dell Vostro 1400
Date: Sun, 21 Dec 2008 19:33:50 -0200
Message-ID: <68720af30812211333j3a6f2b95x42f2b8549eb6155a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f16.google.com (mail-gx0-f16.google.com
	[209.85.217.16])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C2221037EC
	for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2008 22:33:51 +0100 (CET)
Received: by gxk9 with SMTP id 9so1025658gxk.8
	for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2008 13:33:51 -0800 (PST)
Content-Disposition: inline
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

Hi,

I have a Dell Vostro 1400 laptop, which uses the sigmatel codec
STAC9228.

This laptop has a digital built in mic and a connector for an external
analog mic.
It also has two headphones connectors.

Using yesterday's alsa tarball

model=ref or ref-no-jd  - sound in headphones only, external analog mic
works. No digital mic.

model=3stack,5stack   - no sound at all.

model=dell-3stack        - sound works for headphones and speakers (jack
detection mutes speakers when headphones are inserted), no analog external
mic, and digital mic works, but sound is really too low.

Therefore, I would be very pleased if I could either use the analog mic with
model=dell-3stack, or if the built in digital mic had a louder sound.


Using hda-verb-0.3, the pins are:

0xa - headphones (first connector - the one which works)
0xf - headphones (second connector - mute)
0xe - analog mic

The information from alsa-info is here:

 http://www.alsa-project.org/db/?f=6a64faf3cd93c8c805e868c33eff88aec29508c8

Thanks.

-- 
Paulo Roma Cavalcanti
LCG - UFRJ

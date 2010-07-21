From: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
Subject: Missing config option for SFFSDR_FPGA
Date: Wed, 21 Jul 2010 12:58:33 +0200
Message-ID: <86tynthzja.fsf@peer.zerties.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lin
Cc: vamos-dev@i4.informatik.uni-erlangen.de
List-Id: alsa-devel@alsa-project.org

Hi all!
      =20
        As part of the VAMOS[0] research project at the University of
Erlangen we are looking at multiple integrity errors in linux'
configuration system.

        I've been running a check on the sound/ sourcetree for
config Items not defined in Kconfig and found such a case. Sourcecode
blocks depending on these Items are not reachable from a vanilla
kernel -- dead code. I've seen such dead blocks made on purpose
e.g. while integrating new features into the kernel but generally
they're just useless.

There are two ifdef blocks, which do a check on CONFIG_SFFSDR_FPGA, but
this flag isn't defined anywhere. There is an select in
sound/soc/davinci[1], but Kconfig doesn't define the symbol, if there
isn't a config option for it. So this blocks can never be selected. I
don't think this is intended, so i didn't wrote a patch. Please just
notice it.

Regards
        Christian Dietrich

[0] http://vamos1.informatik.uni-erlangen.de/
[1] sound/soc/davinci/Kconfig:      select SFFSDR_FPGA                =20
    sound/soc/davinci/davinci-sffsdr.c:#ifdef CONFIG_SFFSDR_FPGA
    sound/soc/davinci/davinci-sffsdr.c:#ifndef CONFIG_SFFSDR_FPGA
    sound/soc/davinci/davinci-sffsdr.c:#ifndef CONFIG_SFFSDR_FPGA
--=20
(=CE=BB x . x x) (=CE=BB x . x x) -- See how beatiful the lambda is
No documentation is better than bad documentation
-- Das Ausdrucken dieser Mail wird urheberrechtlich verfolgt.

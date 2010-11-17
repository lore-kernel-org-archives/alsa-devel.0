From: Lars-Peter Clausen <lars@metafoo.de>
Subject: ASoC: Cyclic dependency between soc.h and soc-dapm.h
Date: Wed, 17 Nov 2010 15:33:18 +0100
Message-ID: <4CE3E7AE.7040308@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 015E02458D
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2010 15:33:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The commit "ASoC: Decouple DAPM from CODECs" introduced a cyclic dependency between
soc.h and soc-dapm.h which leads to the following compile error, if a driver includes
soc-dapm.h without having included soc.h before:

	In file included from include/sound/soc-dapm.h:19,
	                 from sound/soc/codecs/jz4740.c:25:
	include/sound/soc.h:484: error: field 'dapm' has incomplete type

If soc.h has been included before the error does not happen, but then soc-dapm.h
already got included trough soc.h, so the driver does not really have to include it
again.
So I wonder if soc-dapm.h should be made completely internal and not be included
anywhere else but soc.h anymore?
Or if the cyclic dependency should be broken somehow, maybe by introducing a third
header file?

- Lars

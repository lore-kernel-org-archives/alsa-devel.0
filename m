From: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
Subject: [PATCH 0/3] Removing dead code
Date: Wed, 21 Jul 2010 14:34:24 +0200
Message-ID: <cover.1279708102.git.qy03fugy__48177.6633220308$1279953018$gmane$org@stud.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from faui40.informatik.uni-erlangen.de
	(faui40.informatik.uni-erlangen.de [131.188.34.40])
	by alsa0.perex.cz (Postfix) with ESMTP id D8B2C10392B
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 14:34:26 +0200 (CEST)
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
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>, Julia Lawall <julia@diku.dk>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opens>
Cc: vamos-dev@i4.informatik.uni-erlangen.de
List-Id: alsa-devel@alsa-project.org

Hi all!
       
        As part of the VAMOS[0] research project at the University of
Erlangen we are looking at multiple integrity errors in linux'
configuration system.

        I've been running a check on the sound/ sourcetree for
config Items not defined in Kconfig and found 3 such cases. Sourcecode
blocks depending on these Items are not reachable from a vanilla
kernel -- dead code. I've seen such dead blocks made on purpose
e.g. while integrating new features into the kernel but generally
they're just useless.

        Each of the patches in this patchset removes on such dead
config Item, I'd be glad if you consider applying them. I've been
doing deeper analysis of such issues before and can do so again but
I'm not so sure they were fastly usefull.

        I build the patches against a vanilla kernel in order to
try if the kernel compiles with this patches

        Please keep me informed of this patch getting confirmed /
merged so we can keep track of it.

Regards

        Christian Dietrich

[0] http://vamos1.informatik.uni-erlangen.de/

Christian Dietrich (3):
  sound/oss: Remove dead CONFIG_SOFTOSS*
  sound/soc/atmel: Remove dead CONFIG_AT32_ENHANCED_PORTMUX
  sound/isa/gus: Remove dead CONFIG_SND_DEBUG_ROM

 sound/isa/gus/interwave.c        |    8 --------
 sound/oss/vidc.c                 |    3 ---
 sound/soc/atmel/playpaq_wm8510.c |    9 ---------
 3 files changed, 0 insertions(+), 20 deletions(-)

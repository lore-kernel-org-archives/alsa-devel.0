From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v4 0/5] ASoC: Move IO and kcontrols to the
	component level
Date: Tue, 22 Apr 2014 13:23:12 +0200
Message-ID: <1398165797-22997-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-072.synserver.de (smtp-out-082.synserver.de
 [212.40.185.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B18D261A92
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 13:23:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Changes since v3:
	* Removed the omap-hdmi compile fix that slipped in by accident.

v3 cover letter:

The only change in v3 is the renaming of the component IO mutex from 'mutex' to
'io_mutex'.

v2 cover letter:

This series contains the remaining patches from the previous series that have
not been applied yet. The series has been rebased ontop of asoc/for-next and
depends on topic/sta350, topic/core, topic/dapm, topic/cache and
topic/component.

Some minor updates were made to the patches and three new patches:
	* One new user of snd_kcontrol_chip() showed up, the patch converts it to
	  snd_soc_kcontrol_codec()
	* Change return type of snd_soc_write() from unsigned int to int
	* Remove ASoC level tracing

Original cover letter:

This series is the first step towards full componentisation of the ASoC core. It
moves both the IO abstraction layers within ASoC as well as the standard set of
kcontrols to the component level. This for example means we can get rid of
constructs like

	if (w->codec)
		snd_soc_read(....)
	else if(w->platform)
		snd_soc_platform_read(...)

Moving the kcontrols to the component level means we can use the same
implementation also for other non-CODEC components. E.g. there seems to be an
increasing amount of CPU components that have basic signal processing and things
like volume controls etc. whose register layout is similar to those used in
CODECs. Currently each CPU component driver re-implements these controls by
hand.

The first two patches introduce two new helper functions which hide the actual
implementation on how the CODEC or platform struct that register a control can
be obtained from the control. This means that when the actual implementation is
changed only the two helper functions need to be updated and not every single
driver. The patches that follow that are just cleanups removing unused IO stuff
and move all IO functions to soc-io.c. The next step is to make platforms also
components. And then finally first the IO abstraction layers in ASoC are unified
at the component level and then on top of that the kcontrol helpers are moved to
the component level.

The series depends on quite a few topic branches related to changes to the core
and cleanups for individual drivers. It is probably best to place it on top of
asoc-v3.15-2. The patch that moves the kcontrols to the component level also has
a runtime dependency on the not yet applied patches that move the ams-delta and
mfld_machine controls to the card level.
 
Lars-Peter Clausen (5):
  ASoC: Move IO abstraction to the component level
  ASoC: Move standard kcontrol helpers to the component level
  ASoC: Remove snd_soc_update_bits_locked()
  ASoC: dapm: Rename soc_widget_update_bits_locked() to
    soc_widget_update_bits()
  ASoC: Remove ASoC level IO tracing

 include/sound/soc-dapm.h    |   1 +
 include/sound/soc.h         |  51 +++++--
 include/trace/events/asoc.h |  92 -------------
 sound/soc/soc-core.c        | 285 +++++++++++++++++++++++++-------------
 sound/soc/soc-dapm.c        |  91 ++----------
 sound/soc/soc-io.c          | 327 ++++++++++++++++++++++++++------------------
 6 files changed, 447 insertions(+), 400 deletions(-)

-- 
1.8.0

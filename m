From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: trace: fix printing jack name" to the
	asoc tree
Date: Fri, 26 Feb 2016 11:46:59 +0900
Message-ID: <E1aZ8Ql-0006LD-Bk@finisterre>
References: <3238725.1iS2dg6EkI@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E7F38265274
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 03:47:02 +0100 (CET)
In-Reply-To: <3238725.1iS2dg6EkI@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: trace: fix printing jack name

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f4833a519aec793cf8349bf479589d37473ef6a7 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 24 Feb 2016 17:38:14 +0100
Subject: [PATCH] ASoC: trace: fix printing jack name

After a change to the snd_jack structure, the 'name' member
is no longer available in all configurations, which results in a
build failure in the tracing code:

include/trace/events/asoc.h: In function 'trace_event_raw_event_snd_soc_jack_report':
include/trace/events/asoc.h:240:32: error: 'struct snd_jack' has no member named 'name'

The name field is normally initialized from the card shortname and
the jack "id" field:

        snprintf(jack->name, sizeof(jack->name), "%s %s",
                 card->shortname, jack->id);

This changes the tracing output to just contain the 'id' by
itself, which slightly changes the output format but avoids the
link error and is hopefully still enough to see what is going on.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: fe0d128c57bf ("ALSA: jack: Allow building the jack layer without input device")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/trace/events/asoc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 317a1ed2f4ac..9130dd5a184a 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -231,13 +231,13 @@ TRACE_EVENT(snd_soc_jack_report,
 	TP_ARGS(jack, mask, val),
 
 	TP_STRUCT__entry(
-		__string(	name,		jack->jack->name	)
+		__string(	name,		jack->jack->id		)
 		__field(	int,		mask			)
 		__field(	int,		val			)
 	),
 
 	TP_fast_assign(
-		__assign_str(name, jack->jack->name);
+		__assign_str(name, jack->jack->id);
 		__entry->mask = mask;
 		__entry->val = val;
 	),
@@ -253,12 +253,12 @@ TRACE_EVENT(snd_soc_jack_notify,
 	TP_ARGS(jack, val),
 
 	TP_STRUCT__entry(
-		__string(	name,		jack->jack->name	)
+		__string(	name,		jack->jack->id		)
 		__field(	int,		val			)
 	),
 
 	TP_fast_assign(
-		__assign_str(name, jack->jack->name);
+		__assign_str(name, jack->jack->id);
 		__entry->val = val;
 	),
 
-- 
2.7.0

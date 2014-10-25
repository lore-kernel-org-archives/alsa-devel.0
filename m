From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 0/8] ASoC: dapm: Cleanups and speed-ups
Date: Sat, 25 Oct 2014 17:41:55 +0200
Message-ID: <1414251723-25050-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-127.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ABF226059A
 for <alsa-devel@alsa-project.org>; Sat, 25 Oct 2014 17:42:09 +0200 (CEST)
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

Only as few minor cleanup changes since v1. No change in functionallity.

Original cover letter from v1:

This series contains a few cleanups and speed-ups for the DAPM
implementation.  It starts with removing some dead or outdated code and
optimizing some lesser used operations.

The first larger change introduced by this series is the categorization of
widgets into sinks, sources, supplies and normal widgets. This is all the
information the main DAPM algorithm needs and using these categories makes
the code simpler and faster and hopefully easier to understand.

The second major change is to use more aggressive caching on the connected
input and output paths of a widget. It takes advantage of the fact that
typically only as subsection of the DAPM graph changes per operation. This
allows to drastically reduce the number of neighbor and path checks for some
DAPM operations. The change is most effective when the system is idle and
when changing the graph routing for a widget with multiple inputs. This e.g.
happens a lot when switching the audio profile. It still has quite good
improvements for other operations as well and typically leads to at least a
50% reduction of path and neighbor checks.

Some before and after DAPM stats. All testing was done with the ADAU1761.
Before is asoc/for-next, After~1 is asoc/for-next + this series except the
last patch, After is asoc/for-next + this series.

Changing a single control on a 5 input mixer while the system is idle:

          Power  Path  Neighbour
Before:   2      25    32
After~1:  2      12    30
After:    2       1     2

Cumulative numbers for switching the audio profile which changes 7 controls
while the system is idle:

          Power  Path  Neighbour
Before:   16     141   188
After~1:  16      80   170
After:    16       7    23

Cumulative numbers for switching the audio profile which changes 7 controls
while playback is active:

          Power  Path  Neighbour
Before:   52     207   297
After~1:  51     123   273
After:    51      29   109

Starting (or stopping) the playback stream:

          Power  Path  Neighbour
Before:   35     80    125
After~1:  34     34    117
After:    34     17     69

- Lars

Lars-Peter Clausen (8):
  ASoC: dapm: Only mark paths dirty when the connection status changed
  ASoC: dapm: Do not add un-muxed paths to MUX control
  ASoC: dapm: Do not pretend to support controls for non mixer/mux
    widgets
  ASoC: dapm: Introduce toplevel widget categories
  ASoC: dapm: Add a flag to mark paths connected to supply widgets
  ASoC: dapm: Mark endpoints instead of IO widgets dirty during
    suspend/resume
  ASoC: dapm: Add a few supply widget sanity checks
  ASoC: dapm: Use more aggressive caching

 include/sound/soc-dapm.h |   8 +-
 sound/soc/soc-core.c     |   8 +-
 sound/soc/soc-dapm.c     | 576 ++++++++++++++++++++++++++++-------------------
 3 files changed, 353 insertions(+), 239 deletions(-)

-- 
1.8.0

From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [RFC PATCH 0/4] Initial prototype of DAPM sample rate
	domains
Date: Thu, 11 Oct 2018 17:28:27 +0100
Message-ID: <20181011162831.26351-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 62E102678FE
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2018 18:28:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Here is a first pass at adding dapm sample rate domain
support. Things are still pretty rough in quite a few places and
I expect some major refactoring before they are ready to merge,
but things are far enough along for people to look at the approach
I am taking to the problem. And should provide enough for discussion
at the mini-conference, although hopefully I will get some more done
next week as well.

The basic high level summary is two new concepts are added to
ASoC, one being a sample rate domain and the other being a domain
group. The domain groups represent widgets that are limited by
hardware restrictions to always run at the same sample rate as each
other. Sample rate domains represent a slot on a device for a sample
rate. Both of these are currently limited to be within the scope of
a single component.  The core will track which groups are connected
together, then as a group is powered up it will be allocated a domain
based on the other groups it is connected to. Domain groups are
implemented as a new type of DAPM widget and the domains themselves
are a new thing which devices add through their component drivers.

As we have previously discussed my intention would be that we also
add bridges between domains although I haven't started work on that
yet. The current code is limited to within a single component and
I think that the bridges will allow better support for propagating
rates between components as well as obviously for SRCs. Currently
the SRCs on wm5110 are just being handled as points where the
domain groups don't connect to another peer.  This allows them to
function but doesn't accurately convey things like the limitations
which input rates support which output rates on the ISRC.

Thanks,
Charles

Charles Keepax (4):
  ASoC: dapm: Add support for hw_free on CODEC to CODEC links
  ASoC: dapm: Add support for a rate domain widget
  ASoC: domain: Add sample rate domain support
  ASoC: arizona: Add rate domain support

 include/sound/soc-dapm.h   |  14 ++
 include/sound/soc-domain.h |  98 +++++++++++
 include/sound/soc.h        |   8 +
 sound/soc/Makefile         |   2 +-
 sound/soc/codecs/arizona.c | 255 ++++++++++++++++++++++------
 sound/soc/codecs/arizona.h |  76 ++++++++-
 sound/soc/codecs/wm5110.c  | 414 ++++++++++++++++++++++++++++++++++-----------
 sound/soc/soc-core.c       |   8 +
 sound/soc/soc-dapm.c       |  57 ++++++-
 sound/soc/soc-domain.c     | 412 ++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 1183 insertions(+), 161 deletions(-)
 create mode 100644 include/sound/soc-domain.h
 create mode 100644 sound/soc/soc-domain.c

-- 
2.11.0

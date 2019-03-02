From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/3] ASoC: core/dapm/topology: minor fixes
Date: Fri,  1 Mar 2019 19:08:50 -0600
Message-ID: <20190302010853.18115-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D60FBF8073C
 for <alsa-devel@alsa-project.org>; Sat,  2 Mar 2019 02:09:04 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

3 small patches that have been used for a while but not
contributed upstream.

The first patch fixes a name mismatch when using the same machine
driver on ApolloLake and GeminiLake Chromebooks.

The second one fixes a minor mistake in the location of a topology
pointer update, and aligns the code on the same pattern.

The last one corrects yet another miss with the introduction of the
new buffer/src/scheduler soc_dapm elements which were always showing
as 'On'

Liam Girdwood (1):
  ASoC: topology: Align tplg pointer increment across all kcontrols

Pierre-Louis Bossart (1):
  ASoC: core: support driver alias names for FE topology overrides

Ranjani Sridharan (1):
  ASoC: dapm: set power_check callback for widgets that shouldnt be
    always on

 sound/soc/soc-core.c     |  7 +++++--
 sound/soc/soc-dapm.c     |  7 +++++++
 sound/soc/soc-topology.c | 17 +++++++++--------
 3 files changed, 21 insertions(+), 10 deletions(-)

-- 
2.17.1

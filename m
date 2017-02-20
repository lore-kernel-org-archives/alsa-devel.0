From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Intel audio fixes on v4.10
Date: Mon, 20 Feb 2017 12:35:34 -0600
Message-ID: <af146891-eb07-76b6-23cc-ed2d08bcac13@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 16FE6266917
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 19:35:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

As usual since my initial 4.4 HDMI branch, I cherry-picked all the 
audio-related contributions and fixes already queued for 4.11 on 
Intel-based platforms and merged them on 4.10. The latest batch contains 
all the HDMI/DP, Baytrail/Cherrytrail ASoC + clock fixes. If you 
maintain a distribution or can't get audio to work please look at this 
branch first: https://github.com/plbossart/sound/tree/topic/v4.10-fixes.
Note that I will no longer maintain the legacy HDMI patches now that we 
have a much better solution queued for upstream and some of the previous 
hot-plug problems on Asus T100 seem to be solved. Known issues such as 
support for max98090 with the DPCM driver, rt5645 headset or dmic 
quality issues, conexant 702x, etc are also not fixed in this branch, 
they are still work-in-progress on my experimental/codecs branch.
If I missed a set of patches please let me know.
Enjoy.
-Pierre

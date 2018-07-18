From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/6] ASoC: rt5651: Various fixes and quirks
Date: Wed, 18 Jul 2018 22:55:36 +0200
Message-ID: <20180718205542.12364-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A9B02677A0
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2018 22:55:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Hi All,

Here is my last (big) round of (Intel) rt5651 support updates, with
these patches combined with the updated, matching UCM profiles from here:
https://github.com/jwrdegoede/alsa-lib/commits/master

All 7 different devices I have work 100% OOTB, without requiring
any manual config or mixer setup. After this there should be no more
big changes.

I will submit the matching alsa-lib UCM profile changes upstream once
this set is in -next (and thus I can be sure the long-names will not
change due to review).

Note that unfortunately my previous round of cleanup patches removed
1 input mapping (of the 3 mappings in total it removed) which is
actually necessary. So this series re-introduces that 1 mapping. I did
not notice this before because UCM input profile switching does not work
reliably for some reason, something which I still need to investigate.
This time I manually veryfied that the correct / expected mixer settings
where used while testing.

Regards,

Hans

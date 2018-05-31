From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/5] conf/ucm: Add bytcr-rt5640 and chtnau8824
	profiles
Date: Thu, 31 May 2018 17:10:21 +0200
Message-ID: <20180531151026.29521-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id D67CF267910
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 17:10:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi All,

Here is v2 of my bytcr-rt5640 UCM profile patches, compared to v1 this
fixes a small typo and adds an extra patch adding a disable sequence
for the SST, based on the disable sequence found in the nau8824 profile
from: https://github.com/plbossart/UCM/tree/master/chtnau8824

Also new in this version of the patch series is a new UCM profile for
the CHT + NAU8824 combo, based on the above profile. This nicely shows
the advantages of the new split UCM profile approach, as this shared
the SST (bytcr) enable / disable sequences with the rt5640 profile.

Regards,

Hans

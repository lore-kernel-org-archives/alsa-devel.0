From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/5] conf/ucm: Add bytcr-rt5640 and
 chtnau8824 profiles
Date: Thu, 31 May 2018 17:56:51 +0200
Message-ID: <67413cdb-7c28-c8c2-7f1b-7dc8029164e3@perex.cz>
References: <20180531151026.29521-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 72FB826792A
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 17:56:56 +0200 (CEST)
In-Reply-To: <20180531151026.29521-1-hdegoede@redhat.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Dne 31.5.2018 v 17:10 Hans de Goede napsal(a):
> Hi All,
> 
> Here is v2 of my bytcr-rt5640 UCM profile patches, compared to v1 this
> fixes a small typo and adds an extra patch adding a disable sequence
> for the SST, based on the disable sequence found in the nau8824 profile
> from: https://github.com/plbossart/UCM/tree/master/chtnau8824
> 
> Also new in this version of the patch series is a new UCM profile for
> the CHT + NAU8824 combo, based on the above profile. This nicely shows
> the advantages of the new split UCM profile approach, as this shared
> the SST (bytcr) enable / disable sequences with the rt5640 profile.

Applied all to the alsa-lib repo. Thanks.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

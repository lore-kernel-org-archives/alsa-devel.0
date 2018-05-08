From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/19] ASoC: rt5640: Add jack-detect and
 button-press support
Date: Tue, 8 May 2018 13:42:00 -0500
Message-ID: <8ae99162-5f77-b5a1-bfe4-802f55a2d5ae@linux.intel.com>
References: <20180508153604.23711-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id DFB632676AA
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 20:42:02 +0200 (CEST)
In-Reply-To: <20180508153604.23711-1-hdegoede@redhat.com>
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
To: Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On 5/8/18 10:35 AM, Hans de Goede wrote:
> Hi All,
> 
> This series has been long in the making, but it is finally ready now.
> This series adds jack-detect support for rt5640 using devices.
> 
> This is modelled after the recent rt5651 codec- and bytcr-rt5651 machine-
> driver jack-detect changes (which were actually based on a WIP version of
> this series).
> 
> As discussed on the list already unfortunately there are no really good
> defaults which work everywhere, so patch 18 adds quirks for 10 devices,
> I've decided to do this in one go rather then split this into 10 patches.

Impressive work, thanks!

patches 8..18
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> Patch 19 makes the bytcr-rt5640 set a longname based on the speaker and
> input-map quirks, so that userspace can pick a correct UCM profile based
> on the longname with working jack-detect based input / output switching.
> I've matching patches adding UCM profiles for this to alsa-lib here:
> https://github.com/jwrdegoede/alsa-lib/commits/master
> I'm waiting with submitting those upstream until patch 19 is accepted
> for merging.

That last patch is a bit controversial. I am not sure this is the right 
direction to add a new profile for every combination of quirks. At the 
very least, we should have a mechanism to include basic parts (and I 
think UCM already has a concept of include). Or better one UCM file that 
combines all possible combinations and disables some parts based on 
quirk information fetched during initialization.

> 
> Regards,
> 
> Hans
> 

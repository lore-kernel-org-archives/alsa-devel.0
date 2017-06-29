From: James Cameron <quozl@laptop.org>
Subject: Re: [PATCH 4/4] ASoC: rt5645: Add jack detection
 workaround for GPD Win
Date: Thu, 29 Jun 2017 16:45:44 +1000
Message-ID: <20170629064544.GG23893@us.netrek.org>
References: <20170628124939.11696-1-tiwai@suse.de>
 <20170628124939.11696-5-tiwai@suse.de>
 <6af6a503-e2bf-c6a2-08c9-bdbd785df829@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swan.laptop.org (swan.media.mit.edu [18.85.44.157])
 by alsa0.perex.cz (Postfix) with ESMTP id E9CCD266C25
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 08:45:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6af6a503-e2bf-c6a2-08c9-bdbd785df829@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 28, 2017 at 04:07:01PM -0500, Pierre-Louis Bossart wrote:
> On 6/28/17 7:49 AM, Takashi Iwai wrote:
> >GPD Win requires jd_mode=3 and the inverted flag for making the jack
> >detection working.  Unfortunately, the BIOS doesn't give a nice way to
> >match with DMI strings, and the only working way so far is to match
> >with the board vendor/name/version/date to some known patterns.
> >
> >Hopefully other vendors won't do such a stupid setup, too...

Takashi, no such luck, see below.

> >
> >Thanks to Hans de Goede for the DMI matching suggestion.
> >
> >Suggested-by: Hans de Goede <hdegoede@redhat.com>
> >Tested-by: Hans de Goede <hdegoede@redhat.com>
> >Signed-off-by: Takashi Iwai <tiwai@suse.de>
> >---
> > sound/soc/codecs/rt5645.c | 29 +++++++++++++++++++++++++++++
> > 1 file changed, 29 insertions(+)
> >
> >diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> >index 162044d82632..308c22f5909a 100644
> >--- a/sound/soc/codecs/rt5645.c
> >+++ b/sound/soc/codecs/rt5645.c
> >@@ -3599,6 +3599,33 @@ static struct dmi_system_id dmi_platform_intel_broadwell[] = {
> > 	{ }
> > };
> >
> >+static struct rt5645_platform_data gpd_win_platform_data = {
> >+	.jd_mode = 3,
> >+	.inv_jd1_1 = true,
> >+};
> >+
> >+static const struct dmi_system_id dmi_platform_gpd_win[] = {
> >+	{
> >+		/*
> >+		 * Match for the GPDwin which unfortunately uses somewhat
> >+		 * generic dmi strings, which is why we test for 4 strings.
> >+		 * Comparing against 23 other byt/cht boards, board_vendor
> >+		 * and board_name are unique to the GPDwin, where as only one
> >+		 * other board has the same board_serial and 3 others have
> >+		 * the same default product_name. Also the GPDwin is the
> >+		 * only device to have both board_ and product_name not set.
> >+		 */
> >+		.ident = "GPD Win",
> >+		.matches = {
> >+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> >+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
> >+			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
> >+			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
> >+		},
> >+	},
> >+	{}
> 
> it feels like it's time to add a quirk parameter for this codec module to
> avoid chasing all possible DMI/BIOS issues?

That would be nice.

Tested against 4.12.0-rc7, this series fixes silent headphones, and
headset microphone.  So guys, if appropriate, and not too late, please
add my

Tested-by: James Cameron <quozl@laptop.org>

Test was with the system previously described here:
https://www.spinics.net/lists/alsa-devel/msg63279.html

The DMI match was hacked as part of the test.

Still silent built-in microphone; PCB traces to codec pins suggest a
DMIC1.  System vendor has not given any data; says because Intel
doesn't support the SOC on Linux, they won't either.  ;-)

> ...

-- 
James Cameron
http://quozl.netrek.org/

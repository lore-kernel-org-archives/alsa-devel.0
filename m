From: David Henningsson <david.henningsson@canonical.com>
Subject: HDA_PINCFG_NO_HP_FIXUP question
Date: Wed, 18 Jul 2012 08:27:02 +0200
Message-ID: <50065736.806@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0467A265258
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2012 08:27:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to fix a bug where the docking station is not working. I 
started by adding pins for them (because that was not present), like this:

	[ALC269_FIXUP_LENOVO_DOCK] = {
		.type = ALC_FIXUP_PINS,
		.v.pins = (const struct alc_pincfg[]) {
			{ 0x19, 0x23a11040 }, /* dock mic */
			{ 0x1b, 0x2121103f }, /* dock headphone */
			{ }
		},
	},

However, this caused the real (non-dock) headphone out to "fixed up" to 
a line out, which is wrong. I'm a little unsure about the best way to 
resolve this, I can think of a few different options:

1) Also override the non-dock headphone out to have sequence number 0xf

2) Set parse_flags to HDA_PINCFG_NO_HP_FIXUP in patch_alc269

3) Try to improve the fix up algorithm to not fix up this particular 
case, but since I don't know when and where this was needed in the first 
place, I'm not sure how to do that without throwing the baby out with 
the bath water...?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

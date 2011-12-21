From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] hda - add ALC889 quick id for Intel Los
 Lunas 2 desktop reference board
Date: Wed, 21 Dec 2011 15:38:31 +0800
Message-ID: <20111221073831.GA15079@localhost>
References: <20111221022020.GA20195@localhost> <s5hy5u6pgl3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 7098A103931
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 08:38:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy5u6pgl3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi,

With the anticipation we'll be adding lots of pincfg numbers in future:

+       [ALC662_FIXUP_ECS] = {
+               .type = ALC_FIXUP_PINS,
+               .v.pins = (const struct alc_pincfg[]) {
+                       { 0x14, 0x99130110 }, /* speaker */
+                       { 0x18, 0x01a19820 }, /* mic */

These numbers are anything but intuitive. Do you mind me
introduce some macros to make them easier to compose and read?

Thanks,
Fengguang

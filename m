From: Jiang zhe <zhe.jiang@intel.com>
Subject: Re: Problem with DELL XPS M1530
Date: Thu, 21 Feb 2008 11:06:15 +0800
Message-ID: <1203563175.27014.19.camel@localhost.localdomain>
References: <47BB02A4.8080907@gmail.com> <s5hfxvouckf.wl%tiwai@suse.de>
	<47BB1F14.4050804@gmail.com>
	<1203500940.3006.4.camel@localhost.localdomain>
	<s5hy79fsxyz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F69A1038CB
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 04:04:59 +0100 (CET)
In-Reply-To: <s5hy79fsxyz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi, Takashi:

Maybe we can try handling the ALC268 laptop HP issue in the
patch_realtek.c.
The patch for the hda_codec.c seems to conflict with the code of
patch_sigmatel.c.

The patch_sigmatel.c depends on  line_out_type == AUTO_PIN_SPEAKER_OUT
and hp_outs > 1 in order to handle the 2 HP jacks issue.

/* If we have no real line-out pin and multiple hp-outs, HPs should
	 * be set up as multi-channel outputs.
	 */
	if (spec->autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT &&
	    spec->autocfg.hp_outs > 1) {
		/* Copy hp_outs to line_outs, backup line_outs in
		 * speaker_outs so that the following routines can handle
		 * HP pins as primary outputs.
		 */
		memcpy(spec->autocfg.speaker_pins, spec->autocfg.line_out_pins,
		       sizeof(spec->autocfg.line_out_pins));
		spec->autocfg.speaker_outs = spec->autocfg.line_outs;
		memcpy(spec->autocfg.line_out_pins, spec->autocfg.hp_pins,
		       sizeof(spec->autocfg.hp_pins));
		spec->autocfg.line_outs = spec->autocfg.hp_outs;
		hp_speaker_swap = 1;
	}
 
Thanks!

> > It's weird that 0xf is in both the line_outs and hp_outs.
> > And the hp_outs=1 when there are two items.
> 
> It's due to a fix for an ALC268 laptop that has also two HPs but one
> is actually a line-out.  Note that hp_outs=1 in the print above.  The
> 0x0f in hp_outs is simply a garbage.  Maybe that patch broke the
> double HPs with STAC9228...
> 
> 
> Takashi

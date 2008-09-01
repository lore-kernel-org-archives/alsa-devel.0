From: Liam Girdwood <lrg@kernel.org>
Subject: Re: CORRECTION (get rid of controls
	with	snd_ctl_remove)
Date: Mon, 01 Sep 2008 12:51:10 +0100
Message-ID: <1220269870.6499.107.camel@odin>
References: <200808291454.42441.harryrat@postnuklear.de>
	<s5hd4jo76k1.wl%tiwai@suse.de>
	<200809011304.45951.harryrat@postnuklear.de>
	<200809011309.22478.harryrat@postnuklear.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id E2F8024370
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 13:51:16 +0200 (CEST)
In-Reply-To: <200809011309.22478.harryrat@postnuklear.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harald Radke <harryrat@postnuklear.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-09-01 at 13:09 +0200, Harald Radke wrote:
> Ok, I just checked my source and  realized I messed things up...
> 
> deactivating AND activating work, the control is not accessible via mixer, 
> however sound paths the control is related to still are functional
> 

That's good to hear that things are working. The sound paths that are
related to disabled controls may still need to be functional depending
on the audio use case.

Liam

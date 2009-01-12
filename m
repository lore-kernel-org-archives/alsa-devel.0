From: Andrea Borgia <andrea@borgia.bo.it>
Subject: Re: [PATCH - SB-0500 1/1] preliminary support for
	Toshiba SB-0500
Date: Mon, 12 Jan 2009 12:36:26 +0100
Message-ID: <496B2B3A.8070404@borgia.bo.it>
References: <s5h3afuivsl.wl%tiwai@suse.de>	<49695750.3020802@borgia.bo.it>	<s5hocye2glr.wl%tiwai@suse.de>	<4969E993.3020303@borgia.bo.it>
	<s5hy6xgdart.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cgmail.quesse.it (cgmail.quesse.it [217.18.208.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F4801037EC
	for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2009 12:36:29 +0100 (CET)
In-Reply-To: <s5hy6xgdart.wl%tiwai@suse.de>
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

Takashi Iwai ha scritto:


> The ".ifnum = QUIRK_NO_INTERFACE " means there is no special quirk for
> this entry, i.e. use the standard method for probing, except for
> setting vendor/product names.

Ah-ha, thanks, that quirk_no_interface bit was just the part I didn't 
understand well. I'll post the patch later.

Thanks,
Andrea.

From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: hda-intel: no soundcard with current linus' git
	tree
Date: Thu, 18 Oct 2007 03:51:50 +0200
Message-ID: <200710180351.50618.maximlevitsky@gmail.com>
References: <471538C2.80806@m3y3r.de> <s5h8x622kui.wl%tiwai@suse.de>
	<471651C4.20907@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B79224521
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Oct 2007 03:52:19 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so362051ugf
	for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2007 18:52:18 -0700 (PDT)
In-Reply-To: <471651C4.20907@m3y3r.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I understand why this happens.

Your sound card has a single "headphone" output, and since it is single, it is called "Master"
the stac you have also has a real master volume control, that controls all the DACs, not just the headphones.

I added support for it, thus two controls collided.

The  following patch will rename the "Master" output to "Headphone"
Note that on the stac 9205/9204, the only one that has no master volume (the volume knob)
but has a "Master Volume" amplifier widget, this will probably rename the "Master Volume" to
Headphones.

This chip is quite different, thus I think this should be handled in its patch function.
I see what I can do later.
Meanwhile the rename from "Master" to Headphones" is the only regression.

Best regards,
	Maxim Levitsky

PS: I reply to this mail with the patch.

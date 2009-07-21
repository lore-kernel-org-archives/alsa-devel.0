From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Tue, 21 Jul 2009 18:09:41 +0100
Message-ID: <ad2655cb0907211009m47d55870pad5bbf75393fdf4a@mail.gmail.com>
References: <4A5DB59B.2010407@freenet.de> <s5hvdltnfrp.wl%tiwai@suse.de>
	<4A659DE2.40400@freenet.de> <s5h3a8q47d0.wl%tiwai@suse.de>
	<4A65F200.8040200@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D54F10384C
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 19:09:42 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e21so876025fga.21
	for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2009 10:09:41 -0700 (PDT)
In-Reply-To: <4A65F200.8040200@freenet.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Frank Roth <frashman@freenet.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/7/21 Frank Roth <frashman@freenet.de>:
> Ok thanks.
>
> So you still didn't have specifications from Creative?
> Because I red some time ago, creative gave the specs to the opensource community?
> How is it possible to write this drivers then? Only reengineering from their opensource drivers?
> Impressive!!
>
> So I understand it right, everything is more or less software based right now?
> We must change this ... (I would help you out, so far I can)
>

That is correct. I have the datasheets from Creative and they are not
complete data sheets. They do not include the DSP workings of the
card. They simply explain how to configure the card to bypass the DSP
unit.
The datasheet does contain some info regarding how one might use
hardware mixing as this uses a separate "mixing unit" within the chip.
I do not think that this "mixing unit" has been implemented in the
open source driver.
The DSP itself is very complex and as a result, reverse engineering it
will be difficult. It would be possible if one had the time but I
don't have the time.
I consider it a similar task to if one was needing to reverse engineer
the x86 chip without having any of the instruction set.

Kind Regards

James

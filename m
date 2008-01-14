From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALC268 test model not working
Date: Tue, 15 Jan 2008 08:38:31 +1030 (CST)
Message-ID: <200801142208.m0EM8VZb007057@turbo.physics.adelaide.edu.au>
References: <s5hr6gkibw3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 8744D24386
	for <Alsa-devel@alsa-project.org>; Mon, 14 Jan 2008 23:08:36 +0100 (CET)
In-Reply-To: <s5hr6gkibw3.wl%tiwai@suse.de> from "Takashi Iwai" at Jan 14,
	2008 05:56:44 PM
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
Cc: Alsa-devel@alsa-project.org, Marco Schuster <marco@harddisk.is-a-geek.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi

[ ALC268 test model ]
> > But it doesn't work correctly, because when running alsamixer, dmesg
> > tells "hda_codec: num_steps = 0 for NID=0x1d", and alsamixer fails with
> > alsamixer: function snd_mixer_load failed: Invalid argument.
> 
> 0x1d is the PCBEEP.  Maybe it's disabled somehow although it's listed
> in the datasheet.  The patch below should fix.

Perhaps it's disabled or not implemented in the chip implementation used in
this particular laptop.  While the "official" ALC268 documents this control
and presumedly implements it, maybe others who use the ALC268 core in their
own chips don't.

If the above messages are non-fatal then it may be slightly premature to
disable the PCBEEP control in the test model mixer.  So long as the lack of
this control in certain hardware doesn't cause loss of functionality on
those systems I would suggest its better if the test model keeps this
control so it is available for those people whose ALC268 does in fact
implement this control.  At the end of the day the test model is just a
diagnostic aid, so if it emits some non-fatal messages on some hardware I
don't really think that's a problem.

Of course if this issue is causing things not to work then we have to
re-evaluate.

Regards
  jonathan

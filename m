From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: DSP2000 Midi In - Not a correct fix??
Date: Tue, 29 Jan 2008 10:29:59 +0000
Message-ID: <200801291029.59425.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AC8F10393D
	for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2008 11:10:41 +0100 (CET)
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
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

I think it is time to post my investigations so far...

re: Hoontech DSP2000 Midi In non-functional

   see :  https://bugtrack.alsa-project.org/alsa-bug/view.php?id=55
             https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1161
             https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1846

I missed a fix patch in March 07 for this as it was put on a later duplicate 
of the bug report I had contributed to.  However I noticed JK closing -> 
resolved these in Jan 08, so tried the patch:

    http://hg.alsa-project.org/alsa-kernel/rev/319688a93b6e

>From my testing, it seems the only part necessary is:-

	-       for (box = 0; box < 4; box++) {
	+       for (box = 0; box < 1; box++) {

as it is successful without the rest.

However I feel this is not really a correct fix, preventing use of multiple 
boxes in code that originally allowed it.  The code is a little strange and 
has taken me a while to approximately grasp.  What seems to be going wrong is 
that when a second box is configured (ie box = 1) the function

	snd_ice1712_stdsp24_box_midi(...)

switches the midi input off box[0].  If box[1] has ICE1712_STDSP24_BOX_MIDI1 
set in it's config, then midi in and out can work on box[1] instead of 
box[0], but otherwise it is just stopped on box[0].  After many hours/days of 
tests I still can't propose a definite way to fix this function to provide 
correct configuration to all 4 allowed boxes, as I really don't understand 
why the code does all the gpio writes that it does.  Unfortunately I do not 
have any circuit information either.  In some way it seems to be latching 
some of the configuration data, but not all.

Clemens, can you remember anything about this change:

	http://hg.alsa-project.org/alsa-kernel/rev/a42043505e46

-was it someone else's patch or did you work on this?

I am hoping that someone can contribute enough of an idea about this to help 
formulate a proper fix.  Unfortunately, as the bugs are closed, I can not 
continue the discussions there.

Alan

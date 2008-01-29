From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: DSP2000 Midi In - Not a correct fix??
Date: Tue, 29 Jan 2008 12:09:19 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801291202130.11819@tm8103.perex-int.cz>
References: <200801291029.59425.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 9866724614
	for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2008 12:09:20 +0100 (CET)
In-Reply-To: <200801291029.59425.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 29 Jan 2008, Alan Horstmann wrote:

> I think it is time to post my investigations so far...
> 
> re: Hoontech DSP2000 Midi In non-functional
> 
>    see :  https://bugtrack.alsa-project.org/alsa-bug/view.php?id=55
>              https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1161
>              https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1846
> 
> I missed a fix patch in March 07 for this as it was put on a later duplicate 
> of the bug report I had contributed to.  However I noticed JK closing -> 
> resolved these in Jan 08, so tried the patch:
> 
>     http://hg.alsa-project.org/alsa-kernel/rev/319688a93b6e
> 
> From my testing, it seems the only part necessary is:-
> 
> 	-       for (box = 0; box < 4; box++) {
> 	+       for (box = 0; box < 1; box++) {
> 
> as it is successful without the rest.
> 
> However I feel this is not really a correct fix, preventing use of multiple 
> boxes in code that originally allowed it.  The code is a little strange and 

Do you have configuration with mutiple boxes? If yes, we can continue to 
work on a proper fix. Othewise, I would just keep a working configuration 
for single box only.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

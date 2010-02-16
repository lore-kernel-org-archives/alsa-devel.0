From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Tue, 16 Feb 2010 09:32:50 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002160924210.28127@eeebox2.perex-int.cz>
References: <20100215192451.GA17938@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 430DD245FF
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 09:32:51 +0100 (CET)
In-Reply-To: <20100215192451.GA17938@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 15 Feb 2010, Lennart Poettering wrote:

> Heya,
>
> a while back I wrote a little tool "dbmeasure" which can be used to
> determine dB attenuation data for alsa mixer controls. I have now
> extended this little dB tools suite to include a tiny tool "dbverify"
> that can be used to verify the correctness of existing dB data exposed
> by the drivers. It should be relatively easy to use that tool,
> suitable even for non-guru folks who want to debug the dB information
> from alsa.
>
> http://git.0pointer.de/?p=dbmeasure.git
> git://git.0pointer.de/dbmeasure.git

Thank you for this code. I'm playing with an idea to start gathering of 
all ALSA tests around and make a GUI for them. But it might make sense to 
use something more portable than C language and use standard ALSA tools 
(amixer, aplay) as backends ;-)

For USB cards, the dB ranges read from hw are not correct. We have to 
overwrite these bad values in the driver. Unfortunately, the USB driver 
doesn't show the USB descriptor -> ALSA control mapping to gather all 
necessary information for the code updates. I'm working on a patch right 
now to obtain this information using procfs.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

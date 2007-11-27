From: Christian Schumann <schumann@physik.uni-kl.de>
Subject: Re: rme hdsp pcmcia (and probably pci) broken
Date: Tue, 27 Nov 2007 08:59:09 +0100
Message-ID: <20071127075909.GA1332@diller-5.physik.uni-kl.de>
References: <1196127903.15009.34.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw1.uni-kl.de (mailgw1.uni-kl.de [131.246.120.220])
	by alsa0.perex.cz (Postfix) with ESMTP id AB2472497D
	for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2007 08:59:15 +0100 (CET)
Received: from cartman.physik.uni-kl.de (cartman.physik.uni-kl.de
	[131.246.236.200])
	by mailgw1.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id
	lAR7x4Yb025833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2007 08:59:05 +0100
Received: from diller-5.physik.uni-kl.de (diller-5.physik.uni-kl.de
	[131.246.236.224])
	by cartman.physik.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id
	lAR7qMM5005168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2007 08:52:23 +0100
Received: from diller-5.physik.uni-kl.de (localhost.localdomain [127.0.0.1])
	by diller-5.physik.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id
	lAR7x96L001471
	for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2007 08:59:09 +0100
Received: (from schumann@localhost)
	by diller-5.physik.uni-kl.de (8.13.8/8.13.8/Submit) id lAR7x9oq001470
	for alsa-devel@alsa-project.org; Tue, 27 Nov 2007 08:59:09 +0100
Content-Disposition: inline
In-Reply-To: <1196127903.15009.34.camel@cmn3.stanford.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 26, 2007 at 05:45:03PM -0800, Fernando Lopez-Lezcano wrote:
> Hi, anyone has a pcmcia rme card running? And working? With a reasonably
> recent alsa? (this probably applies also for the regular pci rme cards,
> I've had reports on the Planet CCRMA list about problems that sound
> similar to this one). 
> 
[...]
> 
> BROKEN means: after starting hdspmixer I get no sound from the analog
> outputs (all previous tries play sound correctly with the default preset
> in hdspmixer). Some channels do appear (using a Digiface II). In the
> "broken" drivers I can get sound with the default preset if I send a
> signal to channels 7 and 12, all other stay muted. 
> 
> Something broke drastically in the driver between 2007.08.30 and
> 2007.10.12.
I can confirm this in the way that I had very similar experiences.
Although I do not clearly remember the kernel version I was trying to
use, it was alsa 1.0.15 with a rme pcmcia digiface I.
No sound was audible, and hdspmixer did not show any signal on the
outputs, although (at least in the same configuration with 1.0.14) it
was sent to the device.

I just wanted to get some work done, so I did not delve into the problem
any deeper. But a fix would certainly be nice.

Regards
Christian

-- 
------------------------------------------------------------------------
Dipl.-Phys. Christian Schumann   |Technische Universitaet Kaiserslautern
Mail: schumann@physik.uni-kl.de  |           Fachbereich Physik
Tel.: 0631/205-4842 (Office)     |     http://www.physik.uni-kl.de 
Tel.: 0631/205-4843 (Lab)        |
Fax.: 0631/205-3902              |    
Post: Erwin-Schroedinger-Strasse, D-67663 Kaiserslautern
-------------------------------------------------------------------------

From: Fons Adriaensen <fons@linuxaudio.org>
Subject: Re: Some questions related to ALSA based duplex
	audio	processing
Date: Sun, 29 Jan 2012 20:31:02 +0000
Message-ID: <20120129203102.GA20883@linuxaudio.org>
References: <4F259BD1.4030001@ind.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lists.linuxaudio.org (bukvic.music.vt.edu [198.82.152.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 4178B24709
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2012 21:31:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F259BD1.4030001@ind.rwth-aachen.de>
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

On Sun, Jan 29, 2012 at 08:19:45PM +0100, public-hk wrote:

> I have just started to develop a duplex audio processing application 
> based on ALSA.
> My development goals are - of course - maximum stability as well as 
> lowest possible delay (latency).

Have a look at the zita-alsa-pcmi library. It probably does all
you need - it takes care of the zillions of calls necessary to
initialise mmap access, and provides/accepts floating point audio
samples regardless of the soundcard's format. No documentation ATM
but the examples should get you going. It's C++, but using on the
class mechanism, no templates, dependency on C++ libriries etc.

<http://kokkinizita.linuxaudio.org/linuxaudio/downloads>
 
-- 
FA

Vor uns liegt ein weites Tal, die Sonne scheint - ein Glitzerstrahl.

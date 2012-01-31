From: Fons Adriaensen <fons@linuxaudio.org>
Subject: Re: Some questions related to ALSA based duplex
	audio	processing
Date: Tue, 31 Jan 2012 12:10:19 +0000
Message-ID: <20120131121018.GA7388@linuxaudio.org>
References: <4F259BD1.4030001@ind.rwth-aachen.de> <4F27C51F.1000202@ladisch.de>
	<4F27D30B.6010607@ind.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lists.linuxaudio.org (bukvic.music.vt.edu [198.82.152.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 26658246B0
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 13:10:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F27D30B.6010607@ind.rwth-aachen.de>
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

On Tue, Jan 31, 2012 at 12:39:55PM +0100, public-hk wrote:

> So, the conclusion is that it is not really defined and I have to deal 
> with synchronization of
> input and output myself, is that the right interpretation?

If the capture and playback devices use the same sample clock
(which will be the case if they refer to the same soundcard),
and they are started together, they will remain in sync and
both sides will be ready at the same time - any difference
will be trivially small compared to the period time.

If they don't use the same sample clock you have a difficult
problem: you need adaptive resampling (which is the subject
of my proposed LAC paper).

So in practice, if you use one and the same soundcard for input
and output there is nothing to be gained from keeping the two
separate, and in most cases the driver will allow then to be
'linked', that is started and stopped with a single call.  

Waiting for ALSA devices using poll() can be complicated.
In the general case there will be more than one filedesc,
the poll events returned don't always correspond to the
logical direction and have to reworked, you need to take
care of error recovery, etc. This is one of the many things
zita-alsa-pcmi will do for you, just call pcm_wait(). When
it returns you can read and write one period (in theory
there could be more than one, but that is quite exceptional
- I've never seen it happen). 


Ciao,

-- 
FA

Vor uns liegt ein weites Tal, die Sonne scheint - ein Glitzerstrahl.

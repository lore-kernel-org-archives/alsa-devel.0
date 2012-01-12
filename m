From: Fons Adriaensen <fons@linuxaudio.org>
Subject: Re: Trying to understand alsa
Date: Thu, 12 Jan 2012 21:50:38 +0000
Message-ID: <20120112215038.GC25761@linuxaudio.org>
References: <1326404651.22083.28.camel@jonspc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lists.linuxaudio.org (bukvic.music.vt.edu [198.82.152.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AACF24359
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 22:50:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326404651.22083.28.camel@jonspc>
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

On Thu, Jan 12, 2012 at 09:44:11PM +0000, Jonathan Andrews wrote:
 
> What I want to do is tell ALSA to hold a buffer of 3 of my packets (3 x
> 1024Bytes, thats 512 x 16 bit samples) while I feed extra packets (1K
> Byte, 512 samples per buffer) in for playback.  The packets are arriving
> at roughly the correct rate, I just need a buffer to  iron out any
> jitter in network transmit, do I have to do this myself ?

Unless data is arriving on average at *exactly* the sample
rate of the ALSA device your buffering will sooner or later
underrun or overrun. ALSA itself can't handle this use case,
it requires adaptive resampling and it's not easy.

Ciao,

-- 
FA

Vor uns liegt ein weites Tal, die Sonne scheint - ein Glitzerstrahl.

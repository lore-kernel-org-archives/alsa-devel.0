From: Jens Taprogge <jens.taprogge@taprogge.org>
Subject: Re: T410s microphone is noisy
Date: Wed, 21 Apr 2010 23:23:56 +0200
Message-ID: <20100421212356.GB26421@ranger.taprogge.wh>
References: <4BCF61AE.8000306@fim.uni-passau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shamrock.taprogge.org (shamrock.taprogge.org [213.146.117.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F4F124636
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 23:24:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BCF61AE.8000306@fim.uni-passau.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobias Grosser <grosser@fim.uni-passau.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Tobias,

On Wed, Apr 21, 2010 at 10:35:58PM +0200, Tobias Grosser wrote:
> I just tested the new v1.0.23 release including the Thinkpad T410s
> support. I works really great, however the microphone input has
> always
> a white background noise.

I am hearing some noise as well.  I will try to look into the issue when
I find the time.

> I tried an external microphone as well as the internal ones. Either the
> mixer is turned high enough that my voice can be heard good. In this
> case there is always some background noise. If I turn the mixer (or
> mic boost) down, the noise vanishes but I cannot hear myself.
> 
> Can you give me a hint how to debug this problem?
> 
> I already put my information here:
> http://www.alsa-project.org/db/?f=6b218b5da3fcc298e6d677a3923ec66d98f996af
> 
> Is this some input (maybe docking station) that is not disabled? Or
> can I change some of the input amplifiers?

I do not have access to datasheets and I am not an ALSA expert either.
So I am not sure what the reason for the noise could be.  Perhaps you
could try adding mixers?  I have read somewhere that the T410s has some
sort of noise cancelation capabilities.  I do not know if they are hard-
or software based.  Perhaps you could play with the GPIOs and see if
that changes anything (e.g. enables noise cancelation).

Best Regards
Jens Taprogge

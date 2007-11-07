From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Audio quality issues with dmix plugin
Date: Wed, 07 Nov 2007 01:29:27 +0100
Message-ID: <473106E7.9050601@keyaccess.nl>
References: <61445c750711060016y1755bd74l87cdc39718b5d226@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C6922436A
	for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2007 01:33:21 +0100 (CET)
In-Reply-To: <61445c750711060016y1755bd74l87cdc39718b5d226@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06-11-07 09:16, Pharaoh . wrote:

> When I play a 44Khz file without using any ALSA plugin like
> 
> #aplay -Dhw:0,0 44k.wav
> 
> the sound quality is awesome but when I play the same file using dmix,
> clicks are introduced.
> 
> #aplay -Dplug:dmix 44k.wav
> 
> changing period size and buffer size doesn't help. I am testing my ALSA
> driver on an OMAP850
> based board.

dmix does 48 kHz by default. Does it sound "awesome" when you play a 48 kHz 
file directly to hw:0,0? If that also clicks, the problem will be your 
driver's handling of the 48 kHz rate -- if not, it'll be the resampling, and 
I'll probably need to bow out...

Rene.

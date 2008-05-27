From: Geoffrey Wossum <geoffrey@pager.net>
Subject: Re: AT32AP7000 (AVR32) + WM8510
Date: Tue, 27 May 2008 17:26:10 -0500
Message-ID: <200805271726.10331.geoffrey@pager.net>
References: <200805221120.08815.geoffrey@pager.net>
	<200805271016.56687.geoffrey@pager.net>
	<20080527184525.GA19124@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.pager.net (mail.pager.net [209.253.16.26])
	by alsa0.perex.cz (Postfix) with ESMTP id F00CA244EC
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 00:25:49 +0200 (CEST)
Received: from [192.168.1.71] (localhost [127.0.0.1])
	by barracuda.pager.net (Spam Firewall) with ESMTP id 3D703BA073
	for <alsa-devel@alsa-project.org>; Tue, 27 May 2008 17:25:41 -0500 (CDT)
Received: from [192.168.1.71] ([192.168.1.1]) by barracuda.pager.net with
	ESMTP id CqgeJnh8hoQ42epH for <alsa-devel@alsa-project.org>;
	Tue, 27 May 2008 17:25:41 -0500 (CDT)
In-Reply-To: <20080527184525.GA19124@sirena.org.uk>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 27 May 2008 01:45:28 pm Mark Brown wrote:
> On Tue, May 27, 2008 at 10:16:56AM -0500, Geoffrey Wossum wrote:
> > FRAME as well as BCLK.  I might give the WM8510 a try as the master
> > again, since I can get the sample rates closer with it.
>
> Let me know how that goes, please.

Works great, now that I know the secret.  Pitch is correct now, and sound 
quality is improved, especially at rates that the AT32AP7000 couldn't 
accurately generate.

> Thanks - as I said previously it's much better if you can include a
> Signed-off-by line in patch submissions in order to allow them to be
> submitted to the mainline kernel, though in the case of fairly obvious
> register access fixes like these it's generally not an obstacle.

I'll try to remember that :)


I'm not doing any input / microphone stuff right now, but the input signal 
path seems incorrect.  I get the following error message everytime I start 
the wm8510 driver:
asoc: no dapm match for Boost Mixer --> Capture Switch --> Capture Boost

Looking at the signal routing in wm8510.c, there seems to also be issues with 
the source and destination of the route being reversed.  

---
Geoffrey

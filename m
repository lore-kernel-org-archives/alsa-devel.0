From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Any standard ALSA application for simultaneous
 capture and playabck ?????
Date: Thu, 24 May 2007 00:25:05 +0100
Message-ID: <4654CD51.1040207@superbug.co.uk>
References: <8d6898730705212330t6d328664sb28478964b0df409@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net
	[194.217.242.90])
	by alsa0.perex.cz (Postfix) with ESMTP id A263424425
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2007 01:25:06 +0200 (CEST)
In-Reply-To: <8d6898730705212330t6d328664sb28478964b0df409@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nobin Mathew wrote:
> Hi,
> 
> Is there any standard ALSA appplication which does simultaneous
> capture and playback??
> 
> What are the complications in implementing simultaneous playback and
> capture in ALSA???
> 
> What are the plugin (.asoundrc) configurations needed for simultaneous
> playback and capture????
> 
> Thanks
> Nobin Mathew

You might want to look at jackd. It down full duplex low latency.
It really depends on your application as to how you program alsa to do
the job. Will your application want one thread for both capture and
playback, or one thread for capture, and one for playback?

James

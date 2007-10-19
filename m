From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: [Jackit-devel] RME HDSP driver enhancements for
	HDSPe cards
Date: Fri, 19 Oct 2007 22:54:00 +0100
Message-ID: <20071019215400.GA2964@localhost>
References: <4715D367.9080206@free.fr> <47186388.7020403@wildgooses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 51B6524431
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Oct 2007 23:48:46 +0200 (CEST)
Received: from localhost (unknown [78.32.150.178])
	by mail3.uklinux.net (Postfix) with ESMTP id BDE8D1F6C97
	for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2007 22:48:45 +0100 (BST)
Received: from anon by localhost with local (Exim 4.63)
	(envelope-from <john@sound-man.co.uk>) id 1Iizn7-0000m6-7Q
	for alsa-devel@alsa-project.org; Fri, 19 Oct 2007 22:54:01 +0100
Content-Disposition: inline
In-Reply-To: <47186388.7020403@wildgooses.com>
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

On Fri, Oct 19, 2007 at 08:58:00AM +0100, Ed W wrote:
> RME are also helpful to the extent that you ask them specific questions 
> and in the name of writing drivers. They should give you hardware 
> details, etc
> 
> 
> As an aside, apart from CPU load I will be suprised if turning floats 
> into 32bit ints makes any difference to the audio, but I agree that it 
> would be a nice feature to have!

IIRC the new RME cards convert 24 bit integers to 32 bit floats in hardware
(and vice versa), thus saving apps like jackd (and the CPU) the trouble.
jackd doesn't support that yet, but AFAIK it shouldn't be too much effort
to change that.

John

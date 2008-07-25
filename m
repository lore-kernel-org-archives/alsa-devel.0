From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsa-lib has anyone ever looked at taking it cross
	platform?
Date: Fri, 25 Jul 2008 10:28:46 +0100
Message-ID: <g6c6ce$ssl$2@ger.gmane.org>
References: <e7d8f83e0807250049h60fabd30x295d739ee6f21e98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DEAC244F9
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jul 2008 11:30:05 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KMJcg-0008Ai-Sf
	for alsa-devel@alsa-project.org; Fri, 25 Jul 2008 09:30:02 +0000
Received: from 78-86-109-144.zone2.bethere.co.uk ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2008 09:30:02 +0000
Received: from gmane by 78-86-109-144.zone2.bethere.co.uk with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2008 09:30:02 +0000
In-Reply-To: <e7d8f83e0807250049h60fabd30x295d739ee6f21e98@mail.gmail.com>
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

Peter Dolding wrote:
> This would kinda make logical sence.
> 
> Alsa-lib plugin system in theory should be able to take any kind sound
> output under it.   Simplify development of all applications on top of
> it.  If alsa was cross platform why would you use something else as a
> middle body wrapper when you port.
> 
> Windows and Mac support could be done as plugins.
> 
> Or is there something that is in the alsa-lib that is a problem?
> 
> Its all about reducing distance between application and hardware and
> reduce amount of coding.

I'd rather see pulseaudio go fully cross platform. It's got some older 
windows ports but if pulse were to get a push in the right direction for 
windows and OSX then this lets alsa get on with the job of interfacing 
with the audio on linux (that's what the L stands for after all), and 
let higher level applications work with a more appropriate system with 
more appropriate interfaces for practical use.

Just a thought...

Col

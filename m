From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: hda-intel (ALC889) - sound loops/repeats
 continuously, and general brokenness
Date: Thu, 21 Oct 2010 17:41:09 +0200
Message-ID: <4CC05F15.4000101@ladisch.de>
References: <4CBF45C0.5060903@juliano.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 4AD0F103A56
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 17:40:02 +0200 (CEST)
In-Reply-To: <4CBF45C0.5060903@juliano.info>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Juliano F. Ravasi" <ml@juliano.info>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Juliano F. Ravasi wrote:
> I'm experiencing a lot of problems reproducing audio with an HD Audio
> "card" integrated on an Intel DX58SO mainboard. It happens only on this
> card, everything is Ok with another (USB) card.
> 
> The most visible problem is that `aplay` plays only a small fragment of
> audio (less than one second), then hangs and the card keeps reproducing
> that fragment continuously in a loop, until killed with Ctrl-C. `aplay
> -N` progresses, but each fragment repeats 3 times.

Please check in /proc/interrupts whether that interrupt actually
works.


Regards,
Clemens

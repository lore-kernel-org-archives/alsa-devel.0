From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: Re: MOTU Midi Express XT driver
Date: Thu, 30 Jun 2011 18:11:17 +0200
Message-ID: <130e1519388.-1095264871527201703.-7941577077482570678@zoho.com>
References: <130e12ff39b.-3928454424886384200.-4172847127217991853@zoho.com>
	<4E0C9EB3.6080802@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FA1A245B0
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jun 2011 18:11:19 +0200 (CEST)
In-Reply-To: <4E0C9EB3.6080802@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

 > Isn't that one of those insane devices that use isochronous transfers? 
There are 4 interfaces, two that look equal (isoc for output, interrupt for input), one with interrupt for in and out and one with isoc for out and in. Seems you can choose... Actually it should reduce latency if you use isoc? Would be my guess.

 > Match on bDeviceSubClass. 
Ok, I found your post from 2005 where you did that for the Fastlane already.

Thanks, Torsten

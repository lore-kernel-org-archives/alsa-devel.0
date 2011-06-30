From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MOTU Midi Express XT driver
Date: Thu, 30 Jun 2011 18:25:29 +0200
Message-ID: <4E0CA379.2030300@ladisch.de>
References: <130e12ff39b.-3928454424886384200.-4172847127217991853@zoho.com>
	<4E0C9EB3.6080802@ladisch.de>
	<130e1519388.-1095264871527201703.-7941577077482570678@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 01BC9103965
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jun 2011 18:25:33 +0200 (CEST)
In-Reply-To: <130e1519388.-1095264871527201703.-7941577077482570678@zoho.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Torsten Schenk <torsten.schenk@zoho.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Torsten Schenk wrote:
> > Isn't that one of those insane devices that use isochronous transfers?
> 
> There are 4 interfaces, ...  Seems you can choose.

IIRC the Windows driver uses only iso transfers; I don't know if the
others are implemented (or used for other things than MIDI).

> Actually it should reduce latency if you use isoc?

Iso packets must be scheduled in advance, so it increases latency.


Regards,
Clemens

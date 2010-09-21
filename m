From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: proposed MPD16 latency workaround
Date: Tue, 21 Sep 2010 13:22:32 +0200
Message-ID: <4C989578.3030009@ladisch.de>
References: <4C9154F4.8040304@foltman.com> <4C91DD19.5000005@ladisch.de>
	<4C921DA5.6080301@foltman.com> <4C970BFD.3080006@ladisch.de>
	<4C988281.4010700@foltman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id A2F0624602
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 13:21:39 +0200 (CEST)
In-Reply-To: <4C988281.4010700@foltman.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Foltman <wdev@foltman.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Krzysztof Foltman wrote:
> Checked it yesterday. The data input works, however, the trying to
> output some sysex data with amidi prints the "bad dma" messages from the
> UHCI driver,

Never heard of that message. 

> Also, either on disconnection or rmmod it OOPSes (can't tell which of
> them, it came up in the dmesg output but I couldn't do proper tests yet).

Might be the same problem with some DMA buffer ...

> That aside, why do you need URB_NO_FSBR flag for the URBs?

It's optional, so it isn't really needed.  I'm using it for control
input transfers because those aren't latency sensitive, and using less
polling might help with the latency problem on the data input endpoint.

> I'll try to write a patch for all JACKs to blacklist the control device,
> that should take care of the JACK incompatibility.

In theory, Jack should never open any MIDI port that isn't actually used.


Regards,
Clemens

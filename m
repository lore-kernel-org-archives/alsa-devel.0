From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: -32 broken pipe
Date: Fri, 15 Oct 2010 09:51:09 +0200
Message-ID: <4CB807ED.8040205@ladisch.de>
References: <AANLkTim_sdgs0VAU1Ncse9h8a+-3rsB9WbXCQBibdG8B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 30F88103BE4
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 09:49:50 +0200 (CEST)
In-Reply-To: <AANLkTim_sdgs0VAU1Ncse9h8a+-3rsB9WbXCQBibdG8B@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cem ERGEN <cemergen@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(please don't create new threads for the same topic)

Cem ERGEN wrote:
> i've 8 hubs and each hubs has got 4 usb soundcards,

With 16-bit samples at 48 kHz, a full-speed bus has just barely enough
bandwidth for one stream with eight channels, or seven on-channel
streams.

Due to bugs in the EHCI driver, using multiple full-speed audio devices
connected to one or more high-speed hubs connected to one controller is
likely to fail.

Try using multiple controllers, and forcing the hubs to work at full
speed by unloading the ehci_hcd module.


Regards,
Clemens

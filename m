From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 0/2] LaCie Firewire Speakers/Griffin FireWave
	support
Date: Mon, 07 Feb 2011 10:13:44 +0100
Message-ID: <4D4FB7C8.7090501@ladisch.de>
References: <4D46933D.5050609@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D7942246C2
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 10:13:44 +0100 (CET)
In-Reply-To: <4D46933D.5050609@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>, Jay Fenlason <fenlason@redhat.com>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This driver version is, I hope, finished enough so that I can commit it
soon.

The FireWave's low-frequency processing makes me believe that this
device is prepared to accept two- and four-channel data, so I've enabled
this in the driver; but I'd still like to actually know if it works.
(If it does, adding support for the AC-3 decoding will be possible too.)

I haven't yet looked into volume controls.

Jay, are you OK with "Tested-by: Jay Fenlason <fenlason@redhat.com>"?

Stefan, if those firewire core bits are worth your notice :) , please
give an Acked-by for them.  


Regards,
Clemens

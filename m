From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Quirks device not showing up
Date: Fri, 08 Jun 2007 08:27:22 +0200
Message-ID: <1181284042.2424.1194097060@webmail.messagingengine.com>
References: <46506D9D.4000701@gmx.net>
	<75b66ecd0705201225w5e6a7e28t7a61f000cd5e2352@mail.gmail.com>
	<s5hk5v2p4az.wl%tiwai@suse.de> <46520655.7000402@gmx.net>
	<4668715B.1020208@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 3C37E24678
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 08:27:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4668715B.1020208@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: LCID Fire <lcid-fire@gmx.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

LCID Fire wrote:
> Well I defined a quirks for my usb device. I mined the probe code with
> output and it creates a new driver instance for my device as well as it
> finds the channels. Nevertheless I don't get my device listed in
> userspace. Is there anything special to be done besides defining a
> quirks?

All quirks have been written as specific workarounds for certain
devices.  It is possible that you device behaves in some different way.

I'd tell you what the actual problem with your quirk is, but my crystal
ball is under repair just now.  Please show your code and the output of
"lsusb -v" for your device.


Regards,
Clemens

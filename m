From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Please help me with USB Audio drivers.
Date: Fri, 07 Dec 2007 17:36:19 +0100
Message-ID: <1197045379.16451.1225375633@webmail.messagingengine.com>
References: <9618a85a0712062107na020ed6r2183d51bbfde9b05@mail.gmail.com>
	<1197029045.1724.1225333105@webmail.messagingengine.com>
	<9618a85a0712070811j60a53923j40978a405606e933@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 2189E1037EF
	for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2007 17:36:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <9618a85a0712070811j60a53923j40978a405606e933@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: kevin liu <lwtbenben@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(please don't top-post)

kevin liu wrote:
> Yeah, I get silence, mplayer not abort.
> Also I can not record anything from the device I am using.

It's possible that the device needs some special configuration to select
what is to be recorded from the audio interface.
Please show the output of "lsusb -v" for this device.


Regards,
Clemens

From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] Remove non-exist device and control
	from	snd-ymfpci
Date: Mon, 19 Sep 2011 11:56:13 +0200
Message-ID: <4E7711BD.9010208@ladisch.de>
References: <CAN8ccibjZSqiMRg6bO+tSsdTZUNJ3Q6FFEF-sYsLf8np9SSY2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id AE3C12499E
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Sep 2011 11:56:17 +0200 (CEST)
In-Reply-To: <CAN8ccibjZSqiMRg6bO+tSsdTZUNJ3Q6FFEF-sYsLf8np9SSY2A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> Is it feasible to remove playback device 2 (rear) and control (e.g. 4
> ch Duplication) by checking sdac bit of ac97 registers to know that it
> does not support 4 channels ?

Yes.

> How about device 1 spdif since this card does not have spdif connector ?

How could this be detected?

> what is the difference of capture device 0 and device 3 ?

The default device can mix lots of sources together; the AC'97 device is
a direct input from the AC'97 codec.


Regards,
Clemens

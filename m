From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Hardware-specific IOCTLs
Date: Tue, 17 Jan 2012 23:02:05 +0100
Message-ID: <4F15EFDD.5010008@ladisch.de>
References: <1326471758.45923.YahooMailNeo@web121806.mail.ne1.yahoo.com>	<4F106A66.4080803@ladisch.de>
	<1326494746.63666.YahooMailNeo@web121805.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 2EE6424357
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 23:02:34 +0100 (CET)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id BB34220B02
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 17:02:31 -0500 (EST)
Received: from [192.168.42.121] (unknown [176.1.96.226])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DD8258E0229
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 17:02:30 -0500 (EST)
In-Reply-To: <1326494746.63666.YahooMailNeo@web121805.mail.ne1.yahoo.com>
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

Ivan Bublikov wrote:
>> Ivan Bublikov wrote:
>>> My difficulty is how to define a code for my IOCTL and avoid
>>> a conflict with the common code in the future.
>>
>> Pick something not yet allocated in Documentation/ioctl/ioctl-number.txt.
>
> Since half of the lines in it are marked "Conflict!" anyway, should
> I only pay attention to not conflict with "sound/*" lines?

There are enough free codes so that you do not need to introduce new
conflicts.

>  And then add a new line for my IOCTLs?

Yes.

> And should I put my IOCTL definitions in hda_hwdep.h or create a new
> file?

If you go through the existing HDA hwdep device, your ioctls probably
should go into the same header.


Regards,
Clemens

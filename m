From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Hardware-specific IOCTLs
Date: Fri, 13 Jan 2012 18:31:18 +0100
Message-ID: <4F106A66.4080803@ladisch.de>
References: <1326471758.45923.YahooMailNeo@web121806.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 1B601244B2
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 18:29:53 +0100 (CET)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E4AE621612
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 12:29:51 -0500 (EST)
In-Reply-To: <1326471758.45923.YahooMailNeo@web121806.mail.ne1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ivan Bublikov <ivanbublikov@yahoo.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ivan Bublikov wrote:
> As an HDA codec vendor, I want to be able to control some functionality
> in my codec, that is not present in codecs from other vendors.  [...]
> I can register an IOCTL handler using snd_ctl_register_ioctl.

This functions is for ioctl calls on the ctl device, which is global
for one sound card and is not appropriate if one wants to address
something like a PCM device or a codec.

For a HDA codec, use a hwdep device.

> My difficulty is how to define a code for my IOCTL and avoid
> a conflict with the common code in the future.

Pick something not yet allocated in Documentation/ioctl/ioctl-number.txt.


Regards,
Clemens

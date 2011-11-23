From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MAYA44 USB audio device no inputs control
Date: Wed, 23 Nov 2011 09:05:21 +0100
Message-ID: <4ECCA941.9020403@ladisch.de>
References: <CAB+hzYRC+_RDBwiakNq7PJ=_7xyrFhTdNuoYAGyyq093s0mp0A@mail.gmail.com>	<4ECBCF52.8020907@gmail.com>	<CAB+hzYS7KEH1P3uWWw63YXFck16CeG8SHtOb7wo82Wu0fL+VDA@mail.gmail.com>
	<CAB+hzYR+5kCh-76U=K+Vvsm+Kj74dfJ=N__JcJsCpg2W9WiWLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id A12BD103A6D
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 09:05:23 +0100 (CET)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 30E1A20CA8
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 03:05:23 -0500 (EST)
In-Reply-To: <CAB+hzYR+5kCh-76U=K+Vvsm+Kj74dfJ=N__JcJsCpg2W9WiWLQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kamil Sobolak <krzakx@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Kamil Sobolak wrote:
> This device has two stereo line ins and we are unable to control them.

> I attached lsusb -v.

According to the descriptors, there should be mixer controls.

Please show the output of "amixer contents" for this device.

Are there any error messages in the system log when the driver is
loaded?


Regards,
Clemens

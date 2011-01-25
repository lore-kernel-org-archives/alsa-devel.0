From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: HDMI with more than 2ch ?
Date: Tue, 25 Jan 2011 02:17:50 +0100
Message-ID: <4D3E24BE.8030607@canonical.com>
References: <1295860599.14528.8.camel@skunk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id A57D8103848
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 02:17:47 +0100 (CET)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.71 #1 (Debian))
	id 1PhXXW-0000xl-9M
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 01:17:46 +0000
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.102]) by hutte.canonical.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71)
	(envelope-from <david.henningsson@canonical.com>) id 1PhXXW-0007G8-3T
	for alsa-devel@alsa-project.org; Tue, 25 Jan 2011 01:17:46 +0000
In-Reply-To: <1295860599.14528.8.camel@skunk>
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

On 2011-01-24 10:16, Xavier Bestel wrote:
> Hi,
>
> I'm using HDMI output on an HD 2600, using KMS from kernel 2.6.37:
> http://www.alsa-project.org/db/?f=b3f67a0890f9878b7b3f345578e24eda0aaa59ac
> The problem is that only 2ch are supported (not 1, not 3 or more). I
> tested with speaker-test, it only works with -c 2.
>
> So how can I access the other PCM channels ? There are 8 of them
> available in the HDMI standard, I thought the card should be able to
> drive all of them.

According to your HDMI codec it only supports stereo output, not 
8-channel PCM. This is a limitation in your hardware, not in the HDMI 
standard.

That is, if you want more channels, you probably want to ac3-encode the 
audio data.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

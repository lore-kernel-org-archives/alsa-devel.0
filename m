From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Lost dB volumes on USB headset between 2.6.38 and
 3.0
Date: Tue, 09 Aug 2011 12:39:57 +0200
Message-ID: <4E410E7D.8050903@ladisch.de>
References: <4E410361.7010808@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 67AB41037FF
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 12:35:57 +0200 (CEST)
In-Reply-To: <4E410361.7010808@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Colin Guthrie <gmane@colin.guthr.ie>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> Hmm, I and Colin Guthrie have found a regression between kernels 2.6.38
> and 3.0.
> 
> When running "amixer -D hw:handset" for this device under 2.6.38, the
> attached file is returned. Under 3.0, the dB information is missing.
> This can't be intentional, can it?

There are patches that might have introduced bugs, but these two patches
do remove dB information intentionally:

ALSA: usb-audio - Don't expose broken dB ranges:
http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=59bb7f0eebe6
ALSA: usb-audio - Add volume range check and warn if it too big:
http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=80acefff3bc7

Are there any messages in the system log when loading the driver?
What are the controls' dB ranges (see "amixer contents")?


Regards,
Clemens

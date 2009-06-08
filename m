From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: EMU 0404USB: Odd sample rate shown during playback.
Date: Mon, 08 Jun 2009 13:39:50 +0200
Message-ID: <4A2CF886.7040407@ladisch.de>
References: <001636c5a907c27277046bd13e2e@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id E503E2449B
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 13:39:44 +0200 (CEST)
In-Reply-To: <001636c5a907c27277046bd13e2e@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: kls.schlz@googlemail.com
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

kls.schlz@googlemail.com wrote:
> On my M-Audio Transit though it remains 44.1 even though it says "async" at  
> 16/44.1 in the stream0 file.

It could have a clock that happens to run at the same speed as your
computer's.  Or it could be that it runs the ADC synchronously to the
computer but says "async" so that it can deliver recorded SPDIF data at
the source's speed.


Best regards,
Clemens

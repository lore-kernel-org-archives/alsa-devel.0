From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ice1712 and the delta 1010
Date: Thu, 26 Aug 2010 15:02:04 +0200
Message-ID: <4C7665CC.5080302@ladisch.de>
References: <20100826065854.519ee1d3@debussy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B36A910382D
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 15:02:02 +0200 (CEST)
In-Reply-To: <20100826065854.519ee1d3@debussy>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Santamauro <david.santamauro@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

David Santamauro wrote:
> Since upgrading my audio PC to 64-bit,

Hardware or software upgrade?

> the delta 1010 analog inputs emit a constant 'hiss' -36 -30dB. Analog
> outputs and digital ins and outs are fine. The delta 1010 from
> a hardware perspective is fine as I tested it on the same pc hardware
> under windows7 64-bit.

In theory, this sounds like a driver bug.

> So far, I have tested it in a 32-bit fedora, 32-bit windows vista and
> 64-bit windows7 all successfully. This problem arises only in 64-bit
> fedora.

Does the 32-bit Linux use the same driver version?
If yes, then it's possible that the 32-bit and 64-bit kernels configure
the PC differently; for example, there might be noise on the power line
due to a different kind of power management.


Regards,
Clemens

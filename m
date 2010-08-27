From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ice1712 and the delta 1010
Date: Fri, 27 Aug 2010 08:28:45 +0200
Message-ID: <4C775B1D.6090603@ladisch.de>
References: <20100826065854.519ee1d3@debussy>	<4C7665CC.5080302@ladisch.de>	<20100826092713.3debd6c1@debussy>	<4C768064.5050207@ladisch.de>
	<20100826122255.33e18696@debussy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 18A6D243FD
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 08:28:44 +0200 (CEST)
In-Reply-To: <20100826122255.33e18696@debussy>
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
> Now that I'm thinking about it, wouldn't any type of interference
> register under windows as well?

If Windows uses a different interrupt frequency that isn't in the
audible range, the power fluctuations wouldn't be noticeable.  Or it
could use some different power management mechanism.

> Have there been any other reports of this nature regarding 32 vs 64-bit
> anomalies?

You are using a different version of the distribution, so it might be
as well any other configuration change.


Regards,
Clemens

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: tabs versus space fill
Date: Fri, 10 Dec 2010 21:54:40 +0000
Message-ID: <20101210215440.GA8896@opensource.wolfsonmicro.com>
References: <1291998221-9642-1-git-send-email-jhnikula@gmail.com>
	<B2150E1E4418E1438554A300EA5040E40D579D15E8@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 68D6E10380C
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 22:54:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <B2150E1E4418E1438554A300EA5040E40D579D15E8@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 10, 2010 at 01:25:10PM -0800, Peter Hsiang wrote:

[Please fix to word wrap within paragraphs, I've reflowed the text below.]

> I noticed that in the latest version of the kernel (next), the
> formatting of the soc sound driver file max98088.c had been changed.
> Someone had changed all the tabs to space-fill.  I thought the kernel
> coding standard encourages the use of tabs.  Is the use of space-fill
> the new formatting preference for the kernel?

No, everything should use raw tabs.

> I did not see this patch change on alsa-devel list.  
> How do I find out where and when this was changed?

There's been no change in the kernel here - looking at the original mail
from you adding the driver that used spaces rather than tabs.  I expect
that this was caused by a configuration issue in your mail system which
caused it to rewrite the content, either the user agent or something on
the server side.

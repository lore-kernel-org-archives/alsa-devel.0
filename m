From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Run-time CODEC reset
Date: Mon, 14 Nov 2011 21:29:47 +0000
Message-ID: <20111114212946.GC6528@opensource.wolfsonmicro.com>
References: <4EBF6081.8030907@codeaurora.org>
	<201111130729.05961.marek.vasut@gmail.com>
	<4EC09E95.8080907@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BBDB8243C3
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 22:29:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EC09E95.8080907@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 13, 2011 at 08:52:37PM -0800, Patrick Lai wrote:
> On 11/12/2011 10:29 PM, Marek Vasut wrote:

> >Then you can ask the developers for help. You can be helped more if you share
> >your problematic code.

> Actually, there is no bug. The use case is more to do with self test
> mode. After running some audio tests to verify different audio paths
> (i.e handset mode), self test application would like to trigger
> codec reset interface to restore CODEC default state. I was told
> that there are already ASOC CODEC drivers offering such interface. I
> want to see how this use case is handled by other CODEC drivers
> especially if command comes during playback/capture.

There's no such interface.  This doesn't sound like something drivers
should support, it just sounds like your test application wants to save
the state before it starts and restore it afterwards, or the user should
use some external utility like alsactl to do so.  Why would an
application care if the codec hardware had been physically reset, that's
the sort of detail that the driver should be hiding?

Patrick, we routinely need to ask you for this sort of background
information in order to understand what it is you're actually trying to
do.  Normally you've already jumped very far into the implementation and
you don't mention the reasoning that you're relying on.

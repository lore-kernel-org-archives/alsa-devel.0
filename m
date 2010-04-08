From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] WM8750: Fix SPITZ machine
Date: Thu, 8 Apr 2010 10:40:40 +0100
Message-ID: <20100408094040.GA6303@rakim.wolfsonmicro.main>
References: <1270440005-25459-1-git-send-email-marek.vasut@gmail.com>
	<1270440818-25790-2-git-send-email-marek.vasut@gmail.com>
	<20100405134106.GC6580@rakim.wolfsonmicro.main>
	<201004072250.22351.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 97C4710382F
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 11:40:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201004072250.22351.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 07, 2010 at 10:50:22PM +0200, Marek Vasut wrote:
> Dne Po 5. dubna 2010 15:41:07 Mark Brown napsal(a):

> > As I've mentioned several times before I urge you to look at how this
> > transition was done for wm8731 for an example of how this sort of change
> > can be done without too much disruption.

> Can you possibly elaborate ? I was unable to find it.

Commit 5998102b9095fdb7c67755812038612afea315c5 upstream:

http://git.kernel.org/?p=linux/kernel/git/broonie/sound-2.6.git;a=commit;h=5998102b9095fdb7c67755812038612afea315c5

Notice how this updates both the machines and the CODEC in the same
patch so things always compile and run.

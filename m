From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Connecting a codec to an i2c codec driver.
Date: Fri, 25 Mar 2011 11:43:28 +0000
Message-ID: <20110325114328.GD31415@opensource.wolfsonmicro.com>
References: <AANLkTinUA1R-oGhQwykLiY0j7-MoB=4oJBMT=PQUTzY4@mail.gmail.com>
	<4D821A18.30407@ladisch.de>
	<AANLkTi=0SKc+2vUH=DV+c1Vm5NwoeAcHMac=tdyi4E8w@mail.gmail.com>
	<4D894196.4040002@gmail.com> <20110323110702.GA27671@sirena.org.uk>
	<AANLkTikr-9k9p8gXsaJ8uCtFKNmbNEwsp3JwMoj-kka7@mail.gmail.com>
	<20110323133013.GB25754@opensource.wolfsonmicro.com>
	<4D8BA1EB.2080407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AB70424521
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2011 12:43:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D8BA1EB.2080407@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 24, 2011 at 12:56:27PM -0700, Steve Calfee wrote:

> Any tips on how to turn on the debug printouts in the alsa and
> device systems? Do I recompile the kernel with new options etc? I
> already lowered the /proc/sys/kernel/printk level to 8.

Add #define DEBUG at the top of the source file to turn dev_dbg() on by
default.

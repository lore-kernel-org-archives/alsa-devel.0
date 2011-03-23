From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Connecting a codec to an i2c codec driver.
Date: Wed, 23 Mar 2011 13:30:13 +0000
Message-ID: <20110323133013.GB25754@opensource.wolfsonmicro.com>
References: <AANLkTinUA1R-oGhQwykLiY0j7-MoB=4oJBMT=PQUTzY4@mail.gmail.com>
	<4D821A18.30407@ladisch.de>
	<AANLkTi=0SKc+2vUH=DV+c1Vm5NwoeAcHMac=tdyi4E8w@mail.gmail.com>
	<4D894196.4040002@gmail.com> <20110323110702.GA27671@sirena.org.uk>
	<AANLkTikr-9k9p8gXsaJ8uCtFKNmbNEwsp3JwMoj-kka7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 73883243AC
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 14:30:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTikr-9k9p8gXsaJ8uCtFKNmbNEwsp3JwMoj-kka7@mail.gmail.com>
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

On Wed, Mar 23, 2011 at 06:22:59AM -0700, Steve Calfee wrote:
> On Wed, Mar 23, 2011 at 4:07 AM, Mark Brown

> > You need to write a machine driver for your board describing how the
> > CODEC is connected to the CPU and other components in your system.

> Great, can you give me a pointer to a sample arm source code
> in the 2.6.38 kernel?

There are *many* example machine drivers under sound/soc.  Look for a
driver for a machine relevant to your CPU (eg, a reference board).

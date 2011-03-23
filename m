From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Connecting a codec to an i2c codec driver.
Date: Wed, 23 Mar 2011 11:07:02 +0000
Message-ID: <20110323110702.GA27671@sirena.org.uk>
References: <AANLkTinUA1R-oGhQwykLiY0j7-MoB=4oJBMT=PQUTzY4@mail.gmail.com>
	<4D821A18.30407@ladisch.de>
	<AANLkTi=0SKc+2vUH=DV+c1Vm5NwoeAcHMac=tdyi4E8w@mail.gmail.com>
	<4D894196.4040002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DFBF2446E
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 12:07:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D894196.4040002@gmail.com>
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

On Tue, Mar 22, 2011 at 05:40:54PM -0700, Steve Calfee wrote:

You should fix your mail client to word wrap within paragraphs.

> I can modprobe the driver (in this case snd_soc_max98088), and no alsa
> "cards" or other linkages are established.

You need to write a machine driver for your board describing how the
CODEC is connected to the CPU and other components in your system.

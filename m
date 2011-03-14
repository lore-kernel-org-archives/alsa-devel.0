From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Device-drivers-devel] [PATCH] Add driver for
 Analog Devices ADAU1701 SigmaDSP
Date: Mon, 14 Mar 2011 11:29:47 +0000
Message-ID: <20110314112946.GA2626@opensource.wolfsonmicro.com>
References: <AANLkTikynw7vCsqqyNZW-LFuGUKKQEtG3s4YCZjpOvko@mail.gmail.com>
	<20110307121502.GG13471@opensource.wolfsonmicro.com>
	<AANLkTinKpvgBokSHpsVf1KVX+m6sD0Xp_dFe8Y+HzY-7@mail.gmail.com>
	<AANLkTik=wEyCEY5xsrdGJw6t_VHH9ByKt4mX348P8uD7@mail.gmail.com>
	<20110309100055.GB6923@opensource.wolfsonmicro.com>
	<DB904C5425BA6F4E8424B3B51A1414D16649F4A546@NWD2CMBX1.ad.analog.com>
	<20110310134605.GC22195@opensource.wolfsonmicro.com>
	<DB904C5425BA6F4E8424B3B51A1414D16649F4A8FB@NWD2CMBX1.ad.analog.com>
	<20110311115344.GA1760@opensource.wolfsonmicro.com>
	<DB904C5425BA6F4E8424B3B51A1414D16649F4AB9D@NWD2CMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A1EB1037F3
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 12:29:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <DB904C5425BA6F4E8424B3B51A1414D16649F4AB9D@NWD2CMBX1.ad.analog.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Cai, Cliff" <Cliff.Cai@analog.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mike Frysinger <vapier.adi@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Cliff Cai <cliffcai.sh@gmail.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 13, 2011 at 10:23:19PM -0400, Cai, Cliff wrote:

> I think I need to have a check of the requirement from customer.
> Anyway,if I modified the driver according to the comments here,
> Would you like to accept it currently or we need to wait until the missing patch
> Has been merged in mainline?

Please repost, there were quite a few issues raised with this revision
even outside the firmware.  For the purpose of getting things into
mainline I'd recommend splitting out the functionaltiy which allows
firmware to be loaded dynamically at runtime as a second patch.

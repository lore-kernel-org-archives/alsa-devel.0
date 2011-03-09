From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Device-drivers-devel] [PATCH] Add driver for
 Analog Devices ADAU1701 SigmaDSP
Date: Wed, 9 Mar 2011 10:00:55 +0000
Message-ID: <20110309100055.GB6923@opensource.wolfsonmicro.com>
References: <1299460302-15392-1-git-send-email-cliff.cai@analog.com>
	<20110307114142.GB13471@opensource.wolfsonmicro.com>
	<AANLkTikynw7vCsqqyNZW-LFuGUKKQEtG3s4YCZjpOvko@mail.gmail.com>
	<20110307121502.GG13471@opensource.wolfsonmicro.com>
	<AANLkTinKpvgBokSHpsVf1KVX+m6sD0Xp_dFe8Y+HzY-7@mail.gmail.com>
	<AANLkTik=wEyCEY5xsrdGJw6t_VHH9ByKt4mX348P8uD7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 19C0024584
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 11:00:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTik=wEyCEY5xsrdGJw6t_VHH9ByKt4mX348P8uD7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cliff Cai <cliffcai.sh@gmail.com>
Cc: cliff.cai@analog.com, Mike Frysinger <vapier.adi@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, akpm@linux-foundation.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 09, 2011 at 03:25:05PM +0800, Cliff Cai wrote:
> On Mon, Mar 7, 2011 at 8:29 PM, Mike Frysinger <vapier.adi@gmail.com> wro=
te:

> > i dont see the issue here. =A0the firmware is *optional* and does not
> > impair basic audio output. =A0further, the firmware is fully
> > written/compiled/maintained by the end customer, just like the
> > application. =A0which means there is no "magic" here -- the end customer
> > is the wizard.

> it's a DSP,so firmware is not optional,actually there is default
> internal program can be used
> if no external firmware is downloaded,of cause, the internal program
> is only used to test analog audio pass-through.

If there is default firmware then even if it's not particularly useful
the kernel should probably not *require* that additional firmware is
provided during driver startup - the system may wish to wait until later
in the boot to provide it, for example because it needs to mount media
to get to the firmware or because it needs to do additional work to
decide what firmware is required for the current system setup.

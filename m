From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: mx6: Audio does not work on linux-next 20140107
Date: Wed, 8 Jan 2014 17:53:03 +0800
Message-ID: <20140108095301.GA12854@MrMyself>
References: <CAOMZO5C=TFczzz8CQj6N=N_Z=p26_73SJvSk5cmp9FPVxF+O=A@mail.gmail.com>
 <52CBEDFA.10603@metafoo.de>
 <CAOMZO5C18WJQKJPuK_Pwq=EW0UhFh=9wxc4M4QEGBscZCHim8g@mail.gmail.com>
 <20140107122813.GA6750@MrMyself>
 <CAOMZO5AC5n-intSnUdnBJyYVO2O2BfPYMj_SwNP6jXD5qxVp9g@mail.gmail.com>
 <CAOMZO5DD-SXe9GKdvTEPccJe5rhR4zVNQF=Of1iUsbqrBtAXPg@mail.gmail.com>
 <20140108050431.GD6750@MrMyself>
 <CAOMZO5C0_aEzSB+fJuyfxCisojUewS9i33kA4-rVB2-NHaFOgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E6F7A26501D
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 11:05:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAOMZO5C0_aEzSB+fJuyfxCisojUewS9i33kA4-rVB2-NHaFOgw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Nicolin Chen <b42378@freescale.com>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 08, 2014 at 08:01:56AM -0200, Fabio Estevam wrote:
> Hi Nicolin,
> 
> On Wed, Jan 8, 2014 at 3:04 AM, Nicolin Chen <Guangyu.Chen@freescale.com> wrote:
> 
> > I think it is impossible to run SDMA without firmware, which stores all
> > the scripts we need, including Audio's one. Although the upstream kernel
> > doesn't have firmware, the reason why you were able to run audio playback
> > is because you have the firmware in your rootfs. So since the driver's
> > upgraded, it's plausible for us to upgrade the firmware as well. But I
> 
> No, this is not correct.
> 

Yea, Shawn just told me there's an inner firmware in the ROM code while
this firmware only supports some basic scripts. And I've already sent
my fixing patches (you're in the to list). Please take a look and test
if you can.

Thank you,
Nicolin Chen

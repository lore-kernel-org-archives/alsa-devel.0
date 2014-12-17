From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: iMX6 ESAI TDM with underrun and overrun support
Date: Wed, 17 Dec 2014 15:36:26 -0800
Message-ID: <20141217233623.GA3152@Asurada>
References: <1758576875.330121.1418829223072.JavaMail.yahoo@jws11142.mail.ir2.yahoo.com>
 <CAOMZO5BOfk1HDmFmS+NQx4FWOf-bS9We46aLF89_iducw-KbxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f180.google.com (mail-yk0-f180.google.com
 [209.85.160.180])
 by alsa0.perex.cz (Postfix) with ESMTP id D4D1126145B
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 00:36:51 +0100 (CET)
Received: by mail-yk0-f180.google.com with SMTP id 9so44147ykp.25
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 15:36:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5BOfk1HDmFmS+NQx4FWOf-bS9We46aLF89_iducw-KbxA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Aurelien Bouin <a_bouin@yahoo.fr>, Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Aurelien,

On Wed, Dec 17, 2014 at 02:04:25PM -0200, Fabio Estevam wrote:
> On Wed, Dec 17, 2014 at 1:13 PM, Aurelien Bouin <a_bouin@yahoo.fr> wrote:
> > Hello,
> > I am currently working on an iMX6 board, I work with the master branch
> > of git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> > I have seen some problems in the freescale ESAI implementation :
> >
> > 1.The registers TCCR and RCCR have TFP and RFP bits in register of a width
> > of 5, not 4 !
> > With a value of 5 we are able to use the full range of slots (32)
> > Patch : http://pastebin.com/Ai1RZ9mE

Only the width of xDC fields is incorrect as Fabio said.

Please send your revised patch to alsa-maillist, CC me and Mark.
(It'd be better to use ./scripts/get_maintainer.pl to get info)

I'll wait for you patch; Otherwise, I can fix it this weekend.

> > 2.The channels number are limited in Playback to 12, but actually we can
> > rise 128, in Capture it is limited to 8 but actually we can rise 128 also
> >
> > Patch : http://pastebin.com/SHk5eHPa

The limitation was applied because of the number of transmitters
and receivers. TDM looks a bit a special case to me. So I
personally encourage you to first apply the change it to your
own code.

The other reason is that actually network mode only supports
slots up to 32. So I don't get why you can make it happen to
128.....

> > I use the iMX6 ESAI bus to send audio datas to other processors ... but
> > actually I don't have any codec behind ...
> > I am wondering if there is any solution with the devicetree to implementing
> > such configuration with "simple-audio-card"
> >
> > Because for the moment I have not find another solution than doing a module
> > : http://pastebin.com/cnGwnEjn
> >
> > I also see that the chip errata of the iMX6 ERR008000 is not handle ...
> > Which make channel swapping on my ESAI bus ...
> > Is there someone that succeed in implementing the underrun overrun catch ?
> the esai driver?

I think you may like to try the newer official BSP release from
Freescale. I remember the fix is included and the fix is hard
to merge into the Linux mainline because it hacks some common
interfaces inside ASoC.

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git

Nicolin Chen

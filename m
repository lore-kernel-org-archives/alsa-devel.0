From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [patch 4/5] orion/kirkwood: Add i2s support
Date: Wed, 26 May 2010 12:55:43 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005261253470.24526@xanadu.home>
References: <20100525122236.841941526@mandriva.com>
	<20100525122341.443140710@mandriva.com>
	<alpine.LFD.2.00.1005252025210.24526@xanadu.home>
	<AANLkTim0m_zJ0J_9FMmXgKfS8ovQZpV-qxtHyOS2D3ZL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_kzEteNOHH60E11KkDgpvhA)"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <AANLkTim0m_zJ0J_9FMmXgKfS8ovQZpV-qxtHyOS2D3ZL@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, Arnaud Patard <apatard@mandriva.com>, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_kzEteNOHH60E11KkDgpvhA)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Wed, 26 May 2010, saeed bishara wrote:

> On Wed, May 26, 2010 at 3:31 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Tue, 25 May 2010, apatard@mandriva.com wrote:
> >
> >> This patch enables support for the i2s controller available on orion/kirkwood platforms
> >>
> >> Signed-off-by: Arnaud Patard <apatard@mandriva.com>
> >
> > The actual Orion processor family has no I2S/audio support.  It would be
> > better if all the audio related stuff was renamed to "kirkwood" and
> > "KIRKWOOD_*" instead.
> This i2s was first included in orion90L (6183).

This has no presence in the mainline source tree, nor any hardware that 
people may care about at this point.  So it is probably best to refer to 
it as being kirkwood related more than orion related.


Nicolas

--Boundary_(ID_kzEteNOHH60E11KkDgpvhA)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--Boundary_(ID_kzEteNOHH60E11KkDgpvhA)--

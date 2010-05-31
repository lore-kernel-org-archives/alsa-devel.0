From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: alsa-driver-1.0.23 fails to build on ppc
Date: Mon, 31 May 2010 14:16:03 +0100
Message-ID: <20100531131602.GB14195@sirena.org.uk>
References: <20100529101637.GA17139@aragorn.home.lxtec.de>
	<20100531131300.GA8279@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 506571038F6
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 15:16:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100531131300.GA8279@aragorn.home.lxtec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>
List-Id: alsa-devel@alsa-project.org

On Mon, May 31, 2010 at 03:13:00PM +0200, Elimar Riesebieter wrote:
> * Elimar Riesebieter [100529 12:16 +0200]
> > Hi,
> > 
> > preparing alsa-driver-1.0.23 for Debian upload I found while building modules all:
> > 
> >   LD [M]  /usr/src/modass/usr_src/modules/alsa-driver/aoa/core/snd-aoa.o
> >   CC [M]  /usr/src/modass/usr_src/modules/alsa-driver/aoa/fabrics/layout.o
> > In file included from /usr/src/modass/usr_src/modules/alsa-driver/aoa/fabrics/layout.c:2:
> > /usr/src/modass/usr_src/modules/alsa-driver/aoa/fabrics/../../alsa-kernel/aoa/fabrics/layout.c: In function 'check_codec':
> > /usr/src/modass/usr_src/modules/alsa-driver/aoa/fabrics/../../alsa-kernel/aoa/fabrics/layout.c:772: error: 'struct device_node' has no member named 'phandle'
> 
> Hmm, on 2.6.32|3 linux_phandle works. On 2.6.34 phandle.
> 
> Any hint?

You probably want to talk to PowerPC and/or OpenFirmware folks about
this rather than ALSA people.

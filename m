From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd soc spi read/write
Date: Fri, 5 Aug 2011 09:30:59 +0100
Message-ID: <20110805083058.GB4977@opensource.wolfsonmicro.com>
References: <CAHG8p1AsKZdVvTj-ydWhDCEKjJcx9Q82srEOVZS45Q5J486YBw@mail.gmail.com>
	<20110804103558.GA25976@opensource.wolfsonmicro.com>
	<CAHG8p1AeeqL+Cj-4V4NwQpD33H4ogV0rfekHjMqfvG7wQ49fCA@mail.gmail.com>
	<20110805054210.GB16956@opensource.wolfsonmicro.com>
	<CAHG8p1AkbrfX3dkLw=MNf24V3peMB33z-vLdVyzRxvGmSNTWSg@mail.gmail.com>
	<20110805063414.GB20809@opensource.wolfsonmicro.com>
	<CAHG8p1BBza_M_Cgrq2O2U+Xc-=rPHeNBKMD_KwfZsLX5Npz9jA@mail.gmail.com>
	<20110805072908.GA28149@opensource.wolfsonmicro.com>
	<CAHG8p1BSW1_enLqJL4fxxHvTd3MdwmS+Av+zy4i23BH+TuhJqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CFA19103986
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Aug 2011 10:30:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAHG8p1BSW1_enLqJL4fxxHvTd3MdwmS+Av+zy4i23BH+TuhJqw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 05, 2011 at 04:00:52PM +0800, Scott Jiang wrote:

> > Why are you replying off-list? =A0You should implement 16x8 SPI reads in
> > the core stuff I'd expect, then disable cache for the CODEC.

> Sorry, I just forgot to CC.
> I wonder if rbtree compress type can support this kind of sparse register?

Yes, rbtree works fine with this.  You'd still take a hit on the size of
your register defaults though.

> And should the patch aginst 3.0 or 3.2?

3.0 can't be patched, though you could try submitting a patch to the
stable guys.  Probably best to start off with 3.1 and see where we go
from there.

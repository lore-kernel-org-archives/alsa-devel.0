From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Unsupported Valley View 'LPE' adapter?
Date: Mon, 2 Dec 2013 12:02:16 +0530
Message-ID: <20131202063216.GJ8834@intel.com>
References: <1385840039.2566.12.camel@adam.happyassassin.net>
 <529A5C6A.70604@ladisch.de>
 <1385865517.2566.36.camel@adam.happyassassin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AA0F02616EF
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 08:29:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1385865517.2566.36.camel@adam.happyassassin.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Williamson <awilliam@redhat.com>, lgirdwood@gmail.com, Jarkko Nikula <jarkko.nikula@linux.jf.intel.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 30, 2013 at 06:38:37PM -0800, Adam Williamson wrote:
> On Sat, 2013-11-30 at 22:45 +0100, Clemens Ladisch wrote:
> > Adam Williamson wrote:
> > > In Windows' Device Manager I see an 'Intel SST Audio Device' with PCI=
 ID
> > > 0x86:0f28. Indeed, the PCI ID database has this listed as "ValleyView
> > > LPE Audio Controller" - http://pci-ids.ucw.cz/read/PC/8086/0f28 . But
> > > hda-intel does not have 0f28 as a supported device.
> > >
> > > So...what is this 0f28?
> > =

> > It is not an HDA controller.  The SST thingy uses I=B2S codecs.
yes it doesnt look like HDA, but the SoC might have one which can be enabled
in BIOS...
> > =

> > > Is support for it going to be added?
> > =

> > There is something in sound/soc/mid-x86/, but that is only for the
> > Medfield platform.  The PCI SST driver that was not merged four years
> > ago used the ID 080a.
> > =

> > Only Intel knows.
I think Liam or Jarkko might have something for you...

--
~Vinod
> =

> Ah! I did see that stuff, but it seemed so old it couldn't be
> relevant...
> =

> > > Is there any info I can provide to help?
> > =

> > "lspci -vv -d 8086:0f28"?
> =

> OK, will get that for you shortly. Thanks for the info.
> -- =

> Adam Williamson
> Fedora QA Community Monkey
> IRC: adamw | Twitter: AdamW_Fedora | XMPP: adamw AT happyassassin . net
> http://www.happyassassin.net
> =


-- =

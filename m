From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [patch 0/5] kirkwood openrd client audio support - v3
Date: Tue, 25 May 2010 21:10:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005251925010.24526@xanadu.home>
References: <20100525122236.841941526@mandriva.com>
	<20100525231831.GA11785@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20100525231831.GA11785@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, saeed@marvell.com, apatard@mandriva.com, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, 26 May 2010, Mark Brown wrote:

> On Tue, May 25, 2010 at 02:22:36PM +0200, apatard@mandriva.com wrote:
> 
> > It's a new try to get merged kirkwood openrd client support.
> 
> > The changes are :
> > - set window configuration according to dma address
> > - namespaced all cs42l51 #define
> > - modified cs42l51_dac_names array according to what proposed Mark Brown
> > - use SOC_DOUBLE_TLV for mic boost
> 
> This looks mostly OK to me - I had a few comments on the CODEC driver
> but they're fairly minor.  It'd be good to get some input from the
> Kirkwood guys, particularly with regard to the merge path here.

I don't mind if you wish to carry it through the ASOC tree.  The bulk of 
it is ASOC related anyway.  However I think that "orion" names should be 
"kirkwood" throughout instead, as pure Orion chips have no audio 
interfaces.


Nicolas

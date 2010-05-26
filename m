From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [patch 4/5] orion/kirkwood: Add i2s support
Date: Wed, 26 May 2010 13:02:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005261257260.24526@xanadu.home>
References: <20100525122236.841941526@mandriva.com>
	<20100525122341.443140710@mandriva.com>
	<alpine.LFD.2.00.1005252025210.24526@xanadu.home>
	<m34ohvgjcx.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <m34ohvgjcx.fsf@anduin.mandriva.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnaud Patard <apatard@mandriva.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, 26 May 2010, Arnaud Patard wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> Hi,
> 
> > On Tue, 25 May 2010, apatard@mandriva.com wrote:
> >
> >> This patch enables support for the i2s controller available on orion/kirkwood platforms
> >> 
> >> Signed-off-by: Arnaud Patard <apatard@mandriva.com>
> >
> > The actual Orion processor family has no I2S/audio support.  It would be 
> > better if all the audio related stuff was renamed to "kirkwood" and 
> > "KIRKWOOD_*" instead.
> 
> I've been told there was some orion with audio. As I've never looked at
> the orion family in details, I assumed this is right and I've changed the
> naming accordingly.

Most Orion flavours don't.  And the one that does is not supported in 
mainline (most probably because hardware is not widely 
available/interesting).

> I can change again but it would be nice to have an
> agreement here. Who's/what's right ? orion can or can not have i2s audio ?

Given that Kirkwood is the first (and perhaps the only one) SOC to make 
use of this in mainline Linux, I think it is less confusing to name it 
"kirkwood".  That won't prevent the Orion90L from using Kirkwood I2S if 
that ever happens.


Nicolas

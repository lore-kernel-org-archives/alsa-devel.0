From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 2/3] PNP cleanups - Unify the pnp macros to
 access	resources in the pnp resource table
Date: Tue, 20 Nov 2007 15:31:26 +0100
Message-ID: <4742EFBE.6030407@keyaccess.nl>
References: <1195552283.23700.166.camel@queen.suse.de>	
	<20071120123102.03bdaa67@the-village.bc.nu>
	<1195568360.23700.202.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id BEE0824A25
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 15:36:25 +0100 (CET)
In-Reply-To: <1195568360.23700.202.camel@queen.suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: trenn@suse.de
Cc: ALSA devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, "yakui.zhao" <yakui.zhao@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, akpm <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: alsa-devel@alsa-project.org

On 20-11-07 15:19, Thomas Renninger wrote:

> At the end is some example code how things could get even more cleaned
> up. It shows how I think pnp layer and one example driver would get
> adjusted. There are not that much drivers making use of
> pnp_resource_change...

The ALSA ISA-PnP drivers do in what I personally consider a bad layering 
violation. Brought up not doing that a while ago on alsa-devel, but no 
discussion ensued. If the PnP maintainer(s) agree with me though, I'd be 
more than happy to rip all of that out of ALSA.

(added alsa-devel)

Rene.

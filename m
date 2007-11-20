From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 0/3] PNP cleanups - Version 2
Date: Tue, 20 Nov 2007 18:51:44 +0100
Message-ID: <1195581105.23700.259.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id A16D024A7A
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 18:51:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: alsa-devel@alsa-project.org, Rene Herman <rene.herman@keyaccess.nl>, "yakui.zhao" <yakui.zhao@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, akpm <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: alsa-devel@alsa-project.org

Changes:
  - Introduce pnp_irq_no instead of pnp_irq_start (same for dma).
  - Let irq and dma resource structs never access .end.
    .end was always only a copy of .start for dma and irq

Some background what I want to do next to allocate resources on the fly:

I want to use pnp_{port,dma,irq,mem} macros mainly in loops to check
whether a resource got allocated:

e.g.:
-       if (idx >= PNP_MAX_DMA) {
+       if (!pnp_dma(dev, idx)) {
or:
-       for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
+       for (idx = 0; pnp_irq(dev, idx); idx++) {

that would look like this in pnp.h:
+#define pnp_port(dev,bar)      ((dev)->res.allocated_ports > (bar) \
+       ? (&(dev)->res.port_resource[(bar)]) : NULL)

I'd like to use krealloc to realloc portions of e.g. 8 port resources on
the fly. As krealloc modifies the addresses of the array, it must be
insured that these are only used at pnp parse time.

This seem to work fine for pnpacpi, were most of the:
echo {get,fill,clean,...} >/sys/devices/pnp0/*/resources
interface does not work for me :)
It should be possible to get this working, if I could get some testing
help with these interfaces, that would be great.
Is any tool making use of this?
The "get" looks evil. It reparses the devices' BIOS information.
This should work as long as not more resources are attached to a device
compared to the initial parse and krealloc must pop in, this should be
the case...
I wonder whether this get and possibly other sysfs interfaces in
drivers/pnp/interface.c can be reverted (it's debug only?). Then the
whole parsing code could theoretically be made __init data. Bjorn?

Also the pnp_resource_change exported symbol could be a problem, if
resources are simply defined by the driver, even there were none
(allocated) found by the pnp{isa,bios,acpi} parser. But this should be
"workaroundable" by doing one malloc/krealloc portion there. It must be
called before insert_resource(..) got called anyway (which passes the
address of a struct resource to be registered as global used IO/System
Memory). Invalidating the passed struct resource pointers afterwards
would be fatal. Just found that problem, I haven't looked at it in
detail.

Any help, comments, etc. are very much appreciated,

    Thomas

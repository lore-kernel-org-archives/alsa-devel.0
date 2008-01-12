From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: PNP_DRIVER_RES_DISABLE breaks swsusp at least with
 snd_cs4236
Date: Sat, 12 Jan 2008 18:00:22 +0100
Message-ID: <4788F226.7040101@keyaccess.nl>
References: <200801092343.48726.linux@rainbow-software.org>	<20080111080141.75aaad5f@poseidon.drzeus.cx>	<47877B83.5040604@keyaccess.nl>	<200801111940.22023.linux@rainbow-software.org>	<4788168F.8070403@keyaccess.nl>	<20080112121256.0f2e96ad@poseidon.drzeus.cx>	<4788C323.6090206@keyaccess.nl>
	<20080112162150.1ec9cad0@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 77D15247AC
	for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2008 18:03:31 +0100 (CET)
In-Reply-To: <20080112162150.1ec9cad0@poseidon.drzeus.cx>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Ondrej Zary <linux@rainbow-software.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: alsa-devel@alsa-project.org

On 12-01-08 16:21, Pierre Ossman wrote:

> Ah, sorry. It was a different thread. Look for a mail with the subject 
> "PNP: do not stop/start devices in suspend/resume path" in the LKML och 
> linux-pm archives.

Right, and I see that the removal of start/stop is already in -mm. That's 
not going to work. Something (such as removing power) disabled Ondrej's 
CS4236 and the pnp_start_dev() is needed to re-enable it upon resume.

>> But we certainly need the pnp_start_dev() in the current flow of
>> things. It not being called is the problem this fixes...
> 
> I think the previous suggestion was that the drivers should call this,
> not the core, so that it behaved more like other parts of the kernel
> (e.g. PCI).

It seems all PnP drivers would need to stick a pnp_start_dev in their resume 
method then which means it really belongs in core. One important point where 
PnP and PCI differ is that PnP allows to change the resources on a protocol 
level and I don't see how it could ever not be necessary to restore the 
state a user may have set if power has been removed. Hibernate is just that, 
isn't it?

Rene.

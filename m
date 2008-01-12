From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: PNP_DRIVER_RES_DISABLE breaks swsusp at least with
 snd_cs4236
Date: Sat, 12 Jan 2008 14:39:47 +0100
Message-ID: <4788C323.6090206@keyaccess.nl>
References: <200801092343.48726.linux@rainbow-software.org>	<20080111080141.75aaad5f@poseidon.drzeus.cx>	<47877B83.5040604@keyaccess.nl>	<200801111940.22023.linux@rainbow-software.org>	<4788168F.8070403@keyaccess.nl>
	<20080112121256.0f2e96ad@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 77B2524792
	for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2008 14:43:02 +0100 (CET)
In-Reply-To: <20080112121256.0f2e96ad@poseidon.drzeus.cx>
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

On 12-01-08 12:12, Pierre Ossman wrote:

> On Sat, 12 Jan 2008 02:23:27 +0100
> Rene Herman <rene.herman@keyaccess.nl> wrote:
> 
>> Pavel, Rafael -- the attached fixes snd-cs4236 not coming back to life for 
>> Ondrej after hibernation due to the PNP_DRIVER_RES_DO_NOT_CHANGE test 
>> triggering in pnp_bus_resume() and keeping the card in a suspended state.
>>
> 
> I'm a bit confused here. Bjorn Helgaas wanted to remove the pnp_start/stop_dev() calls completely, and you want them called all the time. :)

Wanted where? Haven't seen a coment from Bjorn? But -- while removing them 
both looks (as) sensible from a mirror-image viewpoint, this wouldn't fix 
the problem.

As fas as I understand things, "hibernation" is basically "save state, shut 
down machine" where the latter step is going to disable the card inevitably. 
On resume, you're going to need to restore the resources (that were saved in 
pnp_dev->res) that it was using to the card, which is what pnp_start_dev() 
does -- it not being called is the current problem of the card not coming 
back to life.

pnp_stop_dev() could go in this specific situation. Not much point in first 
disabling the thing it seems if a subsequent shutdown is going to take care 
of that anyway. However, suspend/resume isn't just called in the case of 
complete hibernation I guess and I know nothing about it all -- hence my 
request to the hiberhation people for how this is designed to be.

But we certainly need the pnp_start_dev() in the current flow of things. It 
not being called is the problem this fixes...

Rene.

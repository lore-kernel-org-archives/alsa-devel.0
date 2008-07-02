From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ALSA SoC: Add OpenFirmware helper
	for	matching bus and codec drivers
Date: Wed, 02 Jul 2008 16:57:52 +0100
Message-ID: <1215014272.4882.91.camel@localhost.localdomain>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<s5hiqvod37w.wl%tiwai@suse.de>  <20080702154804.GA23011@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 01B082468C
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jul 2008 17:57:53 +0200 (CEST)
In-Reply-To: <20080702154804.GA23011@secretlab.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2008-07-02 at 09:48 -0600, Grant Likely wrote:
> On Wed, Jul 02, 2008 at 11:50:43AM +0200, Takashi Iwai wrote:
> > 
> > This is a helper module and not necessarily manually selectable.
> > Better to make the other driver selecting this.
> 
> Yes, you're right.  I hadn't put too much thought into the Kconfig stuff
> for this patch because, at the moment, I'm viewing this as a temporary
> solution until ASoCv2 is merged.
> 
> Which raises another question: Liam and Mark, what is your opinion on
> merging this driver?  Is it something that you would merge with the v1
> API and then rework it when v2 is merged?  Or would you rather it be
> kept out until v2 is ready?  I haven't even looked at the v2 API yet, so
> I don't know how much rework is involved.
> 

I'm happy with this atm for v1. We can then rework for V2.

Liam

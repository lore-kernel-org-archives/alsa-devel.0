From: Mark Hills <mark@pogo.org.uk>
Subject: Re: usb-audio: Correct way to do a mixer quirk?
Date: Mon, 20 Feb 2012 19:55:13 +0000 (GMT)
Message-ID: <alpine.LNX.2.01.1202201945150.10992@stax.localdomain>
References: <alpine.LNX.2.01.1202192059040.7408@stax.localdomain>
	<4F41FF5F.8040409@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 901AD1039B9
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 20:55:23 +0100 (CET)
In-Reply-To: <4F41FF5F.8040409@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 20 Feb 2012, Clemens Ladisch wrote:

> Mark Hills wrote:
> > The Electrix Ebox-44 is a new USB interface, but the MIXER_UNIT descriptor
> > is broken and refers to a non-existing unit_id.
> >
> > I worked around it with the patch below to remove the additional entry,
> > and the device seems to work as expected.
> >
> > But inserting code here is probably not desirable -- I imagine I need to
> > turn this into a quirk of some sort. Am I correct?
> >
> > And what is the best way to do this?
> >
> > * It doesn't appear I can use quirks-table.h to adjust the content
> >   of a mixer unit (the bNrInPins attribute)
> >
> > * It seems that to use mixer_quirks.c would require a function to
> >   create the whole mixer
> >
> > It's possible I'm incorrect on the above, though. Can anyone advise on how
> > to make this fix in the correct way?
> 
> I'd suggest to change the code to not abort if a unit doesn't exist.

It would seem a little strange to skip over the error for one specific 
condition to accomodate a specific device -- when the rest of the code 
does not generally do this?

I'd be interested in Daniel's take on this too.

If I get time I'll take a closer look at the code and see about making a 
patch.

Thanks

-- 
Mark

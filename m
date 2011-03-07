From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] ASoC: Move symmetric rate check for
 substreams to hw_params
Date: Mon, 7 Mar 2011 15:00:57 +0000
Message-ID: <20110307150057.GL13471@opensource.wolfsonmicro.com>
References: <1299498963-1134-1-git-send-email-vaibhav.bedia@ti.com>
	<20110307120924.GC1829@sirena.org.uk>
	<FCCFB4CDC6E5564B9182F639FC3560870370843B37@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A0DBE243B9
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 16:00:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870370843B37@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Afzal,
	Mohammed" <afzal@ti.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 07, 2011 at 06:21:32PM +0530, Bedia, Vaibhav wrote:
> On Monday, March 07, 2011 5:39 PM, Mark Brown wrote:

> > This means that applications won't be constrained by the
> > current settings so can't automatically choose the required
> > rate.  ALSA is just fundamentally racy here, if you want to
> > reliably open bidirectional streams you need to serialise the
> > startup of the two directions.    

> When a custom application is written then the race condition can be avoided. 

> However right now a simple test like "arecord -f dat | aplay -f dat" fails. One way to make it work
> is to make sure that a call to arecord/aplay (or some dummy app which just sets some valid rate and returns) 
> has been made before both are invoked simultaneously.

For command line testing you can do something like:

  arecord -f dat | (sleep 1; aplay -f dat -) 

to insert a delay if required.  Obviously not all systems will hit the
race.

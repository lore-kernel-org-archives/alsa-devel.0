From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 2/3] ASoC: da7219: Add ACPI parsing support
Date: Fri, 6 May 2016 14:45:00 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D463C303@SW-EX-MBX01.diasemi.com>
References: <cover.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
 <bb23ba754ed1f51c9b20ccd4a2b87520ce7c1893.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
 <20160506123909.GT6292@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.119])
 by alsa0.perex.cz (Postfix) with ESMTP id E8D5D2606F5
 for <alsa-devel@alsa-project.org>; Fri,  6 May 2016 16:45:03 +0200 (CEST)
In-Reply-To: <20160506123909.GT6292@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org

On May 06, 2016, 13:39, Mark Brown wrote:

> > @@ -27,7 +28,6 @@
> >  #include "da7219.h"
> >  #include "da7219-aad.h"
> >
> > -
> >  /*
> >   * Detection control
> >   */
> 
> Random whitespace change.

Fair point. Will sort it.

> 
> >  static struct fwnode_handle *da7219_aad_of_named_fwhandle(struct device
> *dev,
> >  							  const char *name)
> >  {
> > @@ -551,6 +571,9 @@ static struct fwnode_handle
> *da7219_aad_of_named_fwhandle(struct device *dev,
> >  			of_node = to_of_node(child);
> >  			if (of_node_cmp(of_node->name, name) == 0)
> >  				return child;
> > +		} else if (is_acpi_data_node(child)) {
> > +			if (da7219_aad_of_acpi_node_matched(child, name))
> > +				return child;
> >  		}
> >  	}
> >
> 
> This seems messy.  It is a function with a DT specific name that's
> matching ACPI stuff and the fwnode API isn't hiding anything for us
> which suggests this isn't something that's expected to work
> transparently.  At least the naming needs to be corrected, and if this
> *is* supposed to be something we do in ACPI I'd expect the handling to
> be pushed into the fwnode API rather than open coded in a driver - at
> the minute I'm unsure if this is messy because it's a bad idea to do
> this at all or if it's just the naming and so on.

ACPI allows for data only child nodes, like DT, so I do believe this is a valid
case. Also, this kind of functionality is already used in a similar-ish manner in 
the leds-gpio code. I agree that maybe the name should be changed though as it's
misleading. Will also look at the fwnode API and see if it makes sense to move
this there.

> 
> > -	/* Handle any DT/platform data */
> > -	if ((codec->dev->of_node) && (da7219->pdata))
> > +	/* Handle any DT/ACPI/platform data */
> > +	if (((codec->dev->of_node) || is_acpi_node(codec->dev->fwnode)) &&
> > +	    (da7219->pdata))
> >  		da7219->pdata->aad_pdata = da7219_aad_of_to_pdata(codec);
> >
> >  	da7219_aad_handle_pdata(codec);
> 
> Surely we should be able to check if there's firmware data without
> enumerating every possible firmware type?

There doesn't seem to be a unified check for this. Also, Given these are the
only two types the driver expects and supports right now, I don't see a problem
being explicit here in the checking.

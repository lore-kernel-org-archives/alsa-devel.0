From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/3] lx6464es: dump MAC in standard form
Date: Wed, 29 May 2013 14:00:57 +0300
Message-ID: <1369825257.29283.229.camel@smile>
References: <1369821802-2308-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1369821802-2308-2-git-send-email-andriy.shevchenko@linux.intel.com>
 <s5hehcq6qhw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C4B42619F9
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 13:01:01 +0200 (CEST)
In-Reply-To: <s5hehcq6qhw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2013-05-29 at 12:15 +0200, Takashi Iwai wrote: 
> At Wed, 29 May 2013 13:03:21 +0300,
> Andy Shevchenko wrote:
> > 
> > Let's use %pM to print MAC wherever we need it.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  sound/pci/lx6464es/lx6464es.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
> > index 3230e57..33eb301 100644
> > --- a/sound/pci/lx6464es/lx6464es.c
> > +++ b/sound/pci/lx6464es/lx6464es.c
> > @@ -798,9 +798,7 @@ static int lx_init_dsp(struct lx6464es *chip)
> >  
> >  mac_ready:
> >  	snd_printd(LXP "mac address ready read after: %dms\n", i);
> > -	snd_printk(LXP "mac address: %02X.%02X.%02X.%02X.%02X.%02X\n",
> > -		   chip->mac_address[0], chip->mac_address[1], chip->mac_address[2],
> > -		   chip->mac_address[3], chip->mac_address[4], chip->mac_address[5]);
> > +	snd_printk(LXP "mac address: %pM\n", chip->mac_address);
> >  
> >  	err = lx_init_get_version_features(chip);
> >  	if (err)
> > @@ -1113,9 +1111,7 @@ static int snd_lx6464es_probe(struct pci_dev *pci,
> >  	sprintf(card->id, "LX6464ES_%02X%02X%02X",
> >  		chip->mac_address[3], chip->mac_address[4], chip->mac_address[5]);
> >  
> > -	sprintf(card->shortname, "LX6464ES %02X.%02X.%02X.%02X.%02X.%02X",
> > -		chip->mac_address[0], chip->mac_address[1], chip->mac_address[2],
> > -		chip->mac_address[3], chip->mac_address[4], chip->mac_address[5]);
> > +	sprintf(card->shortname, "LX6464ES %pM", chip->mac_address);
> 
> This will change from the upper to the lower case, thus it'll lead to
> an incompatible name string, unfortunately.

Who is the user of this string?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

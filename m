From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ALSA: es1968: precedence bug in
 snd_es1968_tea575x_get_pins()
Date: Wed, 14 Nov 2012 11:27:39 +0300
Message-ID: <20121114082739.GF11566@mwanda>
References: <20121113074454.GB13198@elgon.mountain>
 <1352793790.24230.18.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 509B32615AE
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 09:27:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1352793790.24230.18.camel@joe-AO722>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: alsa-devel@alsa-project.org, Ondrej Zary <linux@rainbow-software.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, Takashi Iwai <tiwai@suse.de>, Rusty Russell <rusty@rustcorp.com.au>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 13, 2012 at 12:03:10AM -0800, Joe Perches wrote:
> On Tue, 2012-11-13 at 10:44 +0300, Dan Carpenter wrote:
> > I don't think this works as intended.  '|' higher precedence than ?: so
> > the bitwize OR "0 | (val & STR_MOST)" is a no-op.
> > 
> > I have re-written it to be more clear.
> []
> > diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
> []
> > @@ -2581,9 +2581,14 @@ static u8 snd_es1968_tea575x_get_pins(struct snd_tea575x *tea)
> >  	struct es1968 *chip = tea->private_data;
> >  	unsigned long io = chip->io_port + GPIO_DATA;
> >  	u16 val = inw(io);
> > -
> > -	return  (val & STR_DATA) ? TEA575X_DATA : 0 |
> > -		(val & STR_MOST) ? TEA575X_MOST : 0;
> > +	u8 ret;
> > +
> > +	ret = 0;
> > +	if (val & STR_DATA)
> > +		ret |= TEA575X_DATA;
> > +	if (val & STR_MOST)
> > +		ret |= TEA575X_MOST;
> > +	return ret;
> 
> Cute.  smatch I presume?  Tools are useful.

Yep.  This is a smatch thing.

> 
> Moving the close parentheses is a pretty common style too
> 
> 	return  (val & STR_DATA ? TEA575X_DATA : 0) |
> 		(val & STR_MOST ? TEA575X_MOST : 0);

That would work as well, of course.  I don't have a strong
preference either way.

regards,
dan carpenter

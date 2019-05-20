From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 07/10] mfd: madera: point to the right pinctrl binding
 file
Date: Mon, 20 May 2019 15:48:40 -0300
Message-ID: <20190520154840.64f91ad2@coco.lan>
References: <cover.1558362030.git.mchehab+samsung@kernel.org>
        <fb47879d405e624374d7d4e099988296ed2af668.1558362030.git.mchehab+samsung@kernel.org>
        <20190520154244.GA99937@ediswmail.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190520154244.GA99937@ediswmail.ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Richard Fitzgerald <rf@opensource.cirrus.com>, Lee Jones <lee.jones@linaro.org>, alsa-devel@alsa-project.org, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

Em Mon, 20 May 2019 16:42:45 +0100
Charles Keepax <ckeepax@opensource.cirrus.com> escreveu:

> On Mon, May 20, 2019 at 11:47:36AM -0300, Mauro Carvalho Chehab wrote:
> > The reference to Documentation/pinctrl.txt doesn't exist, but
> > there is an specific binding for the madera driver.
> > 
> > So, point to it.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  include/linux/mfd/madera/pdata.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
> > index 8dc852402dbb..c7e0658eb74b 100644
> > --- a/include/linux/mfd/madera/pdata.h
> > +++ b/include/linux/mfd/madera/pdata.h
> > @@ -34,7 +34,8 @@ struct madera_codec_pdata;
> >   * @micvdd:	    Substruct of pdata for the MICVDD regulator
> >   * @irq_flags:	    Mode for primary IRQ (defaults to active low)
> >   * @gpio_base:	    Base GPIO number
> > - * @gpio_configs:   Array of GPIO configurations (See Documentation/pinctrl.txt)
> > + * @gpio_configs:   Array of GPIO configurations
> > + *		    (See Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt)  
> 
> I believe this is trying to point at the generic pinctrl docs
> which now live here:
> 
> Documentation/driver-api/pinctl.rst
> 
> There is a patch to do this already:
> https://lkml.org/lkml/2019/1/9/853
> With the latest resend here:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2001752.html

Ah, makes sense to me. 

Please ignore this one.

Thanks,
Mauro

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] opl3sa2: drop snd_card pointer from the
 snd_opl3sa2 structure
Date: Sun, 17 Aug 2008 22:39:10 +0200
Message-ID: <20080817223910.737ac8be.krzysztof.h1@poczta.fm>
References: <20080817200114.691a99d4.krzysztof.h1@poczta.fm>
	<48A86D42.2090901@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id BBE2E243BB
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Aug 2008 22:33:15 +0200 (CEST)
In-Reply-To: <48A86D42.2090901@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 17 Aug 2008 20:26:10 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

> > @@ -298,12 +296,14 @@ static int __devinit snd_opl3sa2_detect(
> >  static irqreturn_t snd_opl3sa2_interrupt(int irq, void *dev_id)
> >  {
> >  	unsigned short status;
> > -	struct snd_opl3sa2 *chip = dev_id;
> > +	struct snd_card *card = dev_id;
> > +	struct snd_opl3sa2 *chip;
> >  	int handled = 0;
> >  
> > -	if (chip == NULL || chip->card == NULL)
> > +	if (card == NULL || card->private_data == NULL)
> 
> micro-comment: card->private_data can't actually be NULL on initialized 
> card (it's card + n) but yes, I guess we're pretending we don't know that...
> 

Right. The next opl3sa2 patch will fix this.

Regards,
Krzysztof

----------------------------------------------------------------------
Farmerzy tez maja Olimpiade!
Sprawdz >> http://link.interia.pl/f1edd

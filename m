From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] Document kfree and vfree NULL usage
Date: Sun, 28 Nov 2004 10:05:55 +0200
Message-ID: <1101629155.9996.9.camel__26025.8404574872$1101656808$gmane$org@localhost>
References: <1101565560.9988.20.camel@localhost>
	 <20041127171357.GA5381@penguin.localdomain>
	 <1101583844.9988.6.camel@localhost>
	 <20041127204317.GA21422@penguin.localdomain>
	 <20041127212345.GA6606@linuxace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.cs.helsinki.fi (courier.cs.helsinki.fi [128.214.9.1])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DCD48253
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2004 09:06:55 +0100 (MET)
In-Reply-To: <20041127212345.GA6606@linuxace.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Phil Oester <kernel@linuxace.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, sebek64@jabber.cz
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 27, 2004 at 09:43:17PM +0100, Marcel Sebek wrote:
> > diff -urpN linux-2.6.10/sound/core/init.c linux-2.6.10-new/sound/core/init.c
> > --- linux-2.6.10/sound/core/init.c	2004-10-23 10:55:09.000000000 +0200
> > +++ linux-2.6.10-new/sound/core/init.c	2004-11-27 21:21:50.000000000 +0100
> > @@ -665,9 +665,8 @@ int snd_card_file_remove(snd_card_t *car
> >  	spin_unlock(&card->files_lock);
> >  	if (card->files == NULL)
> >  		wake_up(&card->shutdown_sleep);
> > -	if (mfile) {
> > -		kfree(mfile);
> > -	} else {
> > +	kfree(mfile);
> > +	if (!mfile) {
> >  		snd_printk(KERN_ERR "ALSA card file remove problem (%p)\n", file);
> >  		return -ENOENT;
> >  	}

On Sat, 2004-11-27 at 13:23 -0800, Phil Oester wrote:
> The above change seems to always trigger the ENOENT return, no?

No it doesn't. kfree() does not set mfile to NULL. However, I think the
above would be more readable if we did the kfree() _after_ the NULL
check. Marcel, what do you think?

		Pekka



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

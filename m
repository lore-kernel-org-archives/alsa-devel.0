From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Platform bus question
Date: Thu, 15 Sep 2005 23:42:56 +0100
Message-ID: <1126824176.3328.8.camel@localhost.localdomain>
References: <1126735889.3428.8.camel@localhost.localdomain>
	 <s5hll1y8y5r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hll1y8y5r.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-09-15 at 11:42 +0200, Takashi Iwai wrote:
> At Wed, 14 Sep 2005 23:11:29 +0100,
> Adrian McMenamin wrote:
> > 
> > I am writing a driver for the sound card on the Sega Dreamcast (you can
> > view it at http://newgolddream.dyndns.info/repos/aica) and I am using
> > this:
> > 
> > 	snd_card_set_dev(dreamcastcard, &platform_bus);	
> > 
> > 	/* Register the card with ALSA subsystem */
> > 	if ((err = snd_card_register(dreamcastcard)) < 0) {
> > 		snd_aicapcm_free();	
> > 		snd_card_free(dreamcastcard);
> > 		return err;
> > 	}
> > 
> > 
> > In the hope that the card will be registered with the generic platform
> > bus.
> > 
> > The code does not generate any errors, but doesn't appear to work
> > either!
> 
> Use a new function snd_card_set_generic_dev() for such a purpose
> if the device isn't assigned to a proper bus.
> 
Meaning the snd_card_set_dev macro + snd_card_register function combo
won't work?



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/2] ALSA: snd_usb_caiaq: give
	better	shortname
Date: Tue, 2 Jun 2009 13:55:59 +0200
Message-ID: <20090602115559.GH26160@buzzloop.caiaq.de>
References: <1243939000-3182-1-git-send-email-daniel@caiaq.de>
	<s5hbpp6ucfk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 45E98103807
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 13:56:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hbpp6ucfk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 02, 2009 at 01:01:35PM +0200, Takashi Iwai wrote:
> > +	/* if the id was not passed as module option, fill it with a shortened
> > +	 * version of the product string which does not contain any
> > +	 * whitespaces */
> > +
> > +	if (*card->id == '\0') {
> 
> Hm, at this place, card->id should be never an empty string so
> this is always true.

Are you sure about that? The same condition is used in
snd_card_register() which is called _after_ the code in question from my
driver.

And the id should not be zero if snd_card_create() was called with an id
argument given. So the condition above should be false if the id was passed
before. Or do I miss anything?

Daniel

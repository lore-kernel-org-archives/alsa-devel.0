From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/5] ALSA: snd_usb_caiaq: give
	better	shortname
Date: Tue, 2 Jun 2009 09:29:49 +0200
Message-ID: <20090602072948.GO26148@buzzloop.caiaq.de>
References: <s5h8wkbc2ro.wl%tiwai@suse.de>
	<1243884987-20256-1-git-send-email-daniel@caiaq.de>
	<1243884987-20256-2-git-send-email-daniel@caiaq.de>
	<alpine.LNX.2.00.0906012306460.4067@eeebox2.perex-int.cz>
	<s5hmy8rms9j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D7FA82445F
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 09:30:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hmy8rms9j.wl%tiwai@suse.de>
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

On Tue, Jun 02, 2009 at 01:46:48AM +0200, Takashi Iwai wrote:
> > > Give the card an 'id' name which will prevent ALSA from calling
> > > choose_default_name(). This implementation only took the last part of a
> > > name containing whitespaces which for example caused 'Audio 4 DJ' to be
> > > shortened to 'DJ', which was not very descriptive.
> > >
> > > The implementation now takes the short name and removes all whitespaces
> > > from it which is much nicer.
> > 
> > Unfortunately, this code does not handle id collisions for multiple cards. 
> 
> Moreover, the id can be passed via a module option.  Thus overriding
> the id itself is no good idea.

So what's your suggestion to fix the behaviour I was describing? Maybe a
combination of Jaroslav's collision detection together with a logic that
does not touch the id in case it was passed as module option?

I'm afraid touching choose_default_name() will cause a lot of breakage
for users as their card IDs will suddenly change and former '-D hw:xxx'
syntax won't work anymore.

Daniel

From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: Hammerfall (hdsp) initialization problem
Date: Sun, 25 Jul 2004 13:16:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1090754189.15178.8.camel@localhost>
References: <1090607568.17750.7.camel@modemcable182.55-70-69.mc.videotron.ca>
	 <20040724100520.26b4ac8f@laptop>
	 <1090734488.3156.2.camel@modemcable182.55-70-69.mc.videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1090734488.3156.2.camel@modemcable182.55-70-69.mc.videotron.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: Tim Blechmann <TimBlechmann@gmx.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> > that's a known problem with the hdsp driver, a lot of continuous memory
> > has to be allocated, which can more likely be done on a freshly booted
> > machine ...
> > the best solution: keep the cardbus interface plugged into the slot all
> > the time ... if you start the computer, the memory will be allocated
> 
> Actually, I suspect there's more than that. I've tried running a program
> that malloc()'s 1 GB of memory (the amount of RAM I have), writes to it
> and then free()'s it, so there's lots of memory available after that.
> Still doesn't work (and obviously there's lots of continuous memory
> available).
> 
> 	Jean-Marc

The problem is that for the preallocation to work, the card has to be
inserted and recognized (the preallocation code scans for the pci vendor
and device ids), so this is a cardbus specific issue. If the card is not
inserted when the preallocation is run, then it will default at probing
time to the standard snd_dma_alloc_pages which is more and more likely
to fail as your uptime rises. The only solution would be to preallocate
the memory anyway, but most user won't need this. Takashi, how about a
kernel/compile time option forcing preallocation for cardbus hdsp owners
?

Thomas




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click

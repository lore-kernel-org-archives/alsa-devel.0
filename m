From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Re: Scatter Gather
Date: Tue, 02 Mar 2004 00:09:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078200582.1446.21.camel@localhost>
References: <Pine.HPX.4.33n.0403010928390.5532-100000@studcom.urz.uni-halle.de>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0403010928390.5532-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, 2004-03-01 at 08:52, Clemens Ladisch wrote:
> Manuel Jander wrote:
> > AFAIK, it seems that when using a scatter gather buffer, not every
> > period is located inside of a page. ...
> > The problem is that a DMA transfer can not go accross 2 different pages.
> > On Aureal hardware, even on contiguous buffers this causes all sort of
> > odd problems. Each DMA chunk must be on the same page.
> > ...
> > That means that i would have to split each period that crosses a page
> > boundary into 2 DMA chunks, with all the complications involved because
> > of irregular sizes, offsets... ARghhh!
> 
> Yes.  Every driver using SG must do this.  Look into bt87x.c or
> via82xx.c for examples.

Well, i guess in that case the period size loses any relevance in terms
of efficiency. Is there any gain if DMA chunks and period sizes are
related in any way ?

> > I could just leave the period size as a power of 2, on that way, a
> > period would never cross any page boundary, but most ALSA programs are
> > too picky to accept that kind of restrictions in most cases.
> 
> Devices like usb and ymfpci have a fixed period size, but their
> drivers emulate arbitrary period sizes.

That means that those hwparam restrictions "should not be used" ?? After
realizing that 99% of ALSA apps don't work when using them, renders them
quiet useless.

By the way, is it really really necesary that "snd_pcm_period_elapsed()"
is called exactly when one period has been playback ? Must that callback
be called for every period ?
After looking at the bt87x driver it seems that it doesn't matter after
all (is that right ?). I was thinking in calling
snd_pcm_period_elapsed() just after each page crossing, instead of
period crossing, for simplicity.

Any comments ?

Best Regards

Manuel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

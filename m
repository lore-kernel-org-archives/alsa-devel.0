From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: snd-usb-usx2y 0.8.7 hwdep pcm oopses!
Date: Wed, 15 Dec 2004 15:32:34 +0100
Message-ID: <200412151532.35006.annabellesgarden@yahoo.de>
References: <64648.195.245.190.93.1103017646.squirrel@195.245.190.93> <46792.195.245.190.94.1103119505.squirrel@195.245.190.94> <s5hy8fzr6q3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8fzr6q3.wl@alsa2.suse.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Mittwoch 15 Dezember 2004 15:12 schrieb Takashi Iwai:
> At Wed, 15 Dec 2004 14:05:05 -0000 (WET),
> Rui Nuno Capela wrote:
> > 
> > Hi Karsten,
> > 
> > >   jackd -d usx2y -d hw:n,2 ... returns a 'resource busy' condition.
> > >
> > > Without the 0.8.7.1 patch, it works BUT iif n < 2; if n >= 2, I get the
> > > 'hwdep' assertion failure on jackd; aplay crashes on either value of n.
> > >
> > > With the patch applied, I always get the "resource busy" error on 'jackd
> > > -d usx2y -d hw:n,2 ...' and on 'aplay -D hw:n,2 ...'.
> > >
> > > So, the sacred question is: How can I make jackd to work with the "rawusb"
> > > interface?
> > >
> > > Just a clueless question: does it need a newer version for the jackd usx2y
> > > backend driver? I'm still using your's original one you've ever posted.
> > > I've been maintaining it as a jack patch and can be found on my personal
> > > home server (http://www.rncbc.org/usx2y/jack-0.99.35-usx2y.patch.gz).
> > >
> > 
> > I found the culprid, almost for sure.
> > 
> > On jack/drivers/usx2y/usx2y_driver.c:2158, you may find there's this
> > hardcoded:
> > 
> >     snd_hwdep_open(&driver->hwdep_handle, "hw:1,1", O_RDWR);
> >                                            ^^^^^^
( me flushing )  erm, really forgot about that one. Cool that you found it!
> > 
> > so I guess this could only work if snd-usb-usx2y is your second soundcard
> > (index=1). Indeed it was on all my successful tests. That explains a lot
> > of trouble.
> > 
> > Simple dummy question: how can I avoid that hardwiring, and fill in the
> > proper soundcard index number n, as in "hw:n,1" ? In other words, how can
> > I retrieve that number, given the alsa device name (e.g. str="hw:2,2")
> > without going dirty as in sscanf(str, "hw:%d", &n); ?
> 
> You can get the card number from ctl or pcm instance.
> Check snd_*_get_card() functions.
> 
We haven't any of those yet, as hwdep device is the first one to be opened.
So we could change jackd's usx2y driver's parameters a little:
 $ jackd -dusx2y -c1
or
 $ jackd -dusx2y --card 1
in the jackd usx2y driver we would sprintf the real alsa devicenames like this:
char hwdep_devicename[8];
char pcm_devicename[8];
int card; //holds card nr parameter

sprintf(hwdep_devicename, "hw:%i,1", card);
sprintf(pcm_devicename, "hw:%i,2", card);

thus we'd hide away the complications from the commandline.

Ok?






-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

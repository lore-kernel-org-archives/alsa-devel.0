From: Thorsten Haas <thorsten.haas@gmx.de>
Subject: Re: Re: USB recording - repetitive peaks
Date: Fri, 5 Jul 2002 08:56:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207050856.26032.thorsten.haas@gmx.de>
References: <3D208C5C.36649172@ladisch.de> <3D247676.8090309@boosthardware.com> <200207042059.10950.thorsten.haas@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200207042059.10950.thorsten.haas@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > I'm not sure about the sound quality it is definitely better. I will see
> > if I can generate a test tone to use instead of actual music.

I checked out cvs this morning and compiled. I grabbed my function generator 
and fed my quattro usb with some signal; 400Hz, 0,7V peak-to-peak.

It's working finely now. (no more peaks)

I did the same thing some days before. ( Whoever is interested in the results 
and the output of the oscilloscope: http://www.thorstenhaas.de/alsa.php)




Am Donnerstag, 4. Juli 2002 20:59 schrieb Thorsten Haas:
> Patrick, I'll checkout cvs tomorrow morning, compile and test around a bit
> with a rc-generator and the oscilloscope. I'll send the results to the
> list.
>
> Am Donnerstag, 4. Juli 2002 18:23 schrieb Patrick Shirkey:
> > Takashi Iwai wrote:
> >  >the hang-up at capture close was at least fixed on cvs.
> >  >it was due to the combination of ASYNC_UNLINK and complete callbacks.
> >  >
> >  >not sure whether the bug with jack is fixed, too, but i think it was
> >  >caused by the same reason.  please update the cvs tree.
> >
> > I can now record successfully using arecord without hanging the system
> > but now I get an instant lock up while starting ardour. :( I have a
> > suspicion that it happens when ardour registers with jackd and asks for
> > the available input devices.  (I'm not sure about the sound quality. I
> > will see if I can generate a test tone to use instead of actual music).
> >
> > The only way to get out of it is reboot using sysreq.
> >
> > I will check some more. Please note this wasn't happening so quickly
> > yesterday.
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Caffeinated soap. No kidding.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf

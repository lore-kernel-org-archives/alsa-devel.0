From: Werner Schweer <ws@seh.de>
Subject: Re: snd-usb-usx2y 0.7.1 against cvs head:               please test it!
Date: Wed, 14 Jul 2004 20:34:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407142034.00652.ws@seh.de>
References: <200407131155.43747.annabellesgarden@yahoo.de> <200407141919.48022.annabellesgarden@yahoo.de> <200407141941.15302.ws@seh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200407141941.15302.ws@seh.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 14 July 2004 19:41, Werner Schweer wrote:
> On Wednesday 14 July 2004 19:19, Karsten Wiese wrote:
> > > testing on 2.6.7-bk20 i get the following message when starting
> > > JACK:
> > >
> > > ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
> > > Broken pipe
> > > could not start playback (Broken pipe)
> > > jackd watchdog: timeout - killing jackd
> > >
> > > the system log says:
> > >
> > > Jul 14 18:40:53 t10 vmunix:
> > > ALSA
> > > /home/ws/projects/alsa/alsa-driver/kbuild/../usb/usx2y/usbusx2yaudio.c:
> > >24 6: -28
> >
> > #define	ENOSPC		28	/* No space left on device */
> >
> > If you didn't try yet,
> > please start Jack with the -S alsa driver option to use 16bit format.
> > Using 24bit on kernels with "uhci debugging" I get lots of dmesg warnings
> > complaining about overusing the usb - bandwidth although everything works
> > fine. Using 16bit the kernel doesn't complain.
> > Maybe usb bandwidth checks are broken?
> >
> > > Jul 14 18:40:53 t10 vmunix:
> > > ALSA
> > > /home/ws/projects/alsa/alsa-driver/kbuild/../usb/usx2y/usbusx2yaudio.c:
> > >34 7: Sequence Error!(ep=10;nuc=1,frame=860)
> > > Jul 14 18:40:53 t10 vmunix:
> > > ALSA
> > > /home/ws/projects/alsa/alsa-driver/kbuild/../usb/usx2y/usbusx2yaudio.c:
> > >34 7: Sequence Error!(ep=8;nuc=1,frame=860)
>
> starting jackd with -S (force 16bit format) works!
>

but only for about 20 minutes, then jackd dies with same error, same
system error message :-(

/werner




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click

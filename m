From: Werner Schweer <ws@seh.de>
Subject: Re: Re: snd-usb-usx2y 0.7.1 against cvs head:               please test it!
Date: Thu, 15 Jul 2004 23:16:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407152316.25478.ws@seh.de>
References: <200407131155.43747.annabellesgarden@yahoo.de> <200407142034.00652.ws@seh.de> <200407151053.59356.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200407151053.59356.annabellesgarden@yahoo.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Karsten Wiese <annabellesgarden@yahoo.de>
List-Id: alsa-devel@alsa-project.org

On Thursday 15 July 2004 10:53, Karsten Wiese wrote:
> Am Mittwoch 14 Juli 2004 20:34 schrieb Werner Schweer:
> > On Wednesday 14 July 2004 19:41, Werner Schweer wrote:
> > > On Wednesday 14 July 2004 19:19, Karsten Wiese wrote:
...
> > > > > /home/ws/projects/alsa/alsa-driver/kbuild/../usb/usx2y/usbusx2yaudi
> > > > >o. c: 34 7: Sequence Error!(ep=8;nuc=1,frame=860)
> > >
> > > starting jackd with -S (force 16bit format) works!
> >
> > but only for about 20 minutes, then jackd dies with same error, same
> > system error message :-(
>
> if your kernel is currently configured with CONFIG_USB_BANDWIDTH=y
> (and you like to spend some more time testing):
> Please recompile the kernel without that option and retry.
> the relevant part of the .config would look like:
>
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=y
> # CONFIG_USB_BANDWIDTH is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> <<<<<<
>
> karsten

without USB_BANDWIDTH enabled all works fine now! I tested JACK with
period size 144 / 2 buffers / 24 samples and it now works very stable.

/werner




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click

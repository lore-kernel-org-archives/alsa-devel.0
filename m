From: Arndt Heuvel <arndt.heuvel@web.de>
Subject: Re: es1869 as sb?
Date: Mon, 29 Apr 2002 22:05:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E172HPN-0003S6-00@smtp.web.de>
References: <200204291404.g3TE4fD08745@dakkon.darykon.cet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200204291404.g3TE4fD08745@dakkon.darykon.cet.com>
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

Am Montag, 29. April 2002 16:04 schrieb Linux Mailing lists account:
> On Friday, Apr 26 Kasper Souren wrote:
> > Hi. I'm trying to get my laptop soundchip, an ES1869 running under ALSA.
> > Under OSS it runs as an sb. With "modprobe sb io=0x220 irq=5 dma=1
> > dma16=5" I get:
> >
> > SB 3.01 detected OK (220)
> > ESS Chip ES1869 detected
> > <ESS ES1869 AudioDrive (rev 11) (3.01)> at 0x220 irq 5 dma 1,5
>
> I also have a laptop that has an ESS ES1879 AudioDrive, and could get ALSA
> to work. I posted a question/request to this list about 6 weeks ago as
> well, but never even got a response back.I gave up and went back to OSS.
>
> I hope you have more luck! Maybe, if you get the ES1869 problem solved,
> it'll fix the ES1879 as well! :-)  I wouldn't think that the ALSA
> developement team would want to keep around a broken driver.
>
> Gerry Simmons
> linux@darykon.cet.com
>

For now, the es18xx is broken. In the source code you can find the following 
commentary:

/* GENERAL NOTES:
 *
 * BUGS:
 * - There are pops (we can't delay in trigger function, cause midlevel
 *   often need to trigger down and then up very quickly).
 *   Any ideas?
 * - Support for 16 bit DMA seems to be broken. I've no hardware to tune it.
 */

/*
 * ES1868  NOTES:
 * - The chip has one half duplex pcm (with very limited full duplex support).
 *
 * - Duplex stereophonic sound is impossible.
 * - Record and playback must share the same frequency rate.
 *
 * - The driver use dma2 for playback and dma1 for capture.
 */

/*
 * ES1869 NOTES:
 *
 * - there are a first full duplex pcm and a second playback only pcm
 *   (incompatible with first pcm capture)
 *
 *
 * - there are a first full duplex pcm and a second playback only pcm
 *   (incompatible with first pcm capture)
 *
 * - there is support for the capture volume and ESS Spatializer 3D effect.
 *
 * - contrarily to some pages in DS_1869.PDF the rates can be set
 *   independently.
 *
 * BUGS:
 *
 * - There is a major trouble I noted:
 *
 *   using both channel for playback stereo 16 bit samples at 44100 Hz
 *   the second pcm (Audio1) DMA slows down irregularly and sound is garbled.
 *
 *   The same happens using Audio1 for captureing.
 *
 *   The Windows driver does not suffer of this (although it use Audio1
 *   only for captureing). I'm unable to discover why.
 *
 */

so oss sb is for now the only driver that work :-(

Arndt H.

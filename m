From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: Tascam US-224 progress report (was: USB224_usbsnoop1.log captured  on WinXP)
Date: Tue, 6 Apr 2004 00:08:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404060008.55634.annabellesgarden@yahoo.de>
References: <200404021434.26528.annabellesgarden@yahoo.de> <32789.192.168.1.5.1080955456.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <32789.192.168.1.5.1080955456.squirrel@www.rncbc.org>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Samstag 03 April 2004 03:24 schrieb Rui Nuno Capela:
> I have news, and they're good this time.
>
> After some juggling and persistance around compiling and patching the
> snd-usb-usx2y module, I've finally got that dreaded INPUT MONITOR LED come
> to light and, as Karsten rightly predicted, playback has shown its ugly
> head on my Tascam US-224. Hip, hip, hurray!
>
> Like a miracle, the MUTE and SELECT LED lights of the mixer strips 1-4 are
> lightning up too. Again, Karsten tips are quite cirurgical :)
>
> However, I don't get the SOLO, REC, NULL, nor all other transport LEDs to
> lit. But that's yet another step, I think the next.
Ok, go for it. Should be fairly easy. Just implement the sink-side of the 
alsa-sequencer interface in us428control ;-)
erm.... no it is not implemented yet.
The Transport Lights could react to MMC Messages.
MUTE, REC, SOLO & SELECT Lights would be controlled by i. e. ardour.
NULL-Mode is a little more complicated: 
In INPUT MONITOR Mode us428control knows all to handle it.
In not INPUT MONITOR Mode us428control has to know from i. e. Ardour the Mixer 
Settings to compare them with the actual state.
>
> We're getting near and I'm quite happier now.
>
> Karsten Wiese wrote:
> > So please try the following patch:
> >
> > --- alsa-driver/usb/usx2y/usbusx2yaudio.c	30 Mar 2004 08:27:16 -0000	1.9
> > +++ alsa-driver/usb/usx2y/usbusx2yaudio.c	2 Apr 2004 11:55:21 -0000
> > @@ -1245,7 +1245,7 @@
> >  	    					     snd_dma_continuous_data(GFP_KERNEL),
> >  						     usX2Y_capt_substream->endpoints * 64*1024,
> >  						     usX2Y_capt_substream->endpoints * 128*1024)) ||
> > -	    (usX2Y(card)->chip.dev->descriptor.idProduct == USB_ID_US428 &&
> > +	    (usX2Y(card)->chip.dev->descriptor.idProduct != USB_ID_US122 &&
> >  	     0 > (err = usX2Y_rate_set(usX2Y_stream, 44100)))) {	// Lets us428
> > recognize output-volume settings, disturbs us122.
> >  		snd_usX2Y_audio_stream_free(usX2Y_stream);
> >  		return err;
> > <<<
> >
> > if the us428 doesn't get the "usX2Y_rate_set(usX2Y_stream, 44100)" at
> > startup, it later behaves ignorant to light & volume setting. like
> > us224 behaves now.
>
> That was it. Although I only got it working after one last
> alsa-driver-1.0.3 rebuild and when set --with-debug=full on ./configure.
> Kind of strange. My literal patch applied to stock alsa-driver-1.0.3 is on
> attachment. It is just the same of Karsten's supplied above, just for
> reference.
Please make shure it also works without debug mode. after make clean.
>
> > If we get the INPUT MONITOR Led enlightened, the Volume settings should
> > also work with respect to direct monitoring at least. US224 Master Fader
> > seams to b where US428's Fader5 is. That needs adjustment in
> > s428control.
> >
> > The data sent to set us224 internal mixers is filtered out with
> > 	grep -n "00: 0[0123456789] .. .. .. ..$" USB224_usbsnoop1.log
> > it gives i. e.:
> > 	11721:    00000000: 00 00 25 00 25
> > 	11732:    00000000: 01 00 25 00 25
> > 	11743:    00000000: 02 00 25 00 25
> > 	11754:    00000000: 03 00 25 00 25
> > 	11831:    00000000: 04 00 42 00 42
> >
> > look at struct usX2Y_volume and its methods. it should fit the us224.
> > But lets get that Leds enlighted first :-)
>
> The master fader works, at least while on playback. I don't seem to get
> fader strips 1-4 to have any audible effect. But now's too early to judge
> my experiments.
Is Direct Monitoring not working? Please try. Has the us224 got SPDIF besides 
the 2 Anolog Ins?
I'm wondering why there are 5 internal mixers being set.
4 should be PCM from usb,
0 shold be Chanell A Monitor and
1 shold be Chanell B Monitor 
What are 2 and 3?

CU


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

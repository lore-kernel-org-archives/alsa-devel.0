From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Digi96 driver question
Date: Tue, 4 May 2004 21:25:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405042125.12590.torger@ludd.luth.se>
References: <200405041048.i44AmVTd002985@dhin.linuxaudiosystems.com> <s5h3c6g2oa2.wl@alsa2.suse.de> <s5hpt9k146j.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpt9k146j.wl@alsa2.suse.de>
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
List-Id: alsa-devel@alsa-project.org

On Tuesday 04 May 2004 19.40, Takashi Iwai wrote:
> At Tue, 04 May 2004 17:41:09 +0200,
>
> I wrote:
> > At Tue, 4 May 2004 14:06:11 +0200,
> >
> > Anders Torger wrote:
> > > On Tuesday 04 May 2004 12.48, you wrote:
> > > > >in says under "known bugs":
> > > > >
> > > > > - 96kHz and 88.2kHz not accessible via PCM interface
> > > > >
> > > > >What does that mean? The card and driver does work in 96 and
> > > > > 88.2 kHz, I know that since I wrote the driver... but if
> > > > > there is some sort of bug, I'd like to know.
> > > >
> > > > anders, i don't know, but it might mean that you can't set the
> > > > SR to these values using the PCM interface. the hammerfalls are
> > > > subject to the same limitation in a slightly different way.
> > > > just a guess.
> > >
> > > You are probably right, I don't really know what the is meant by
> > > the PCM interface though. If I can run the card in 96 kHz with
> > >
> > > aplay -r 96000 ...
> > >
> > > (which is possible) does that not mean that the PCM interface
> > > supports 96 kHz? Or does "PCM interface" refer to some interface
> > > within ALSA I don't know about? I was thinking that "PCM
> > > interface" is the collection of snd_pcm_*() functions, but
> > > perhaps I'm mistaken?
> > >
> > > The digi96 card runs either in ADAT or S/PDIF mode, it cannot do
> > > both at the same time (as the hammerfall can). In ADAT mode,
> > > which in the driver is represented as a separate device, it only
> > > supports 44.1 and 48 kHz. In S/PDIF mode it supports 32 - 96 kHz.
> > > I though perhaps this is what has caused the bug report, but that
> > > is only a limitation in the hardware, not a bug in the driver.
> >
> > maybe it's simply outdated.  i'll remove that one if aplay like
> > above works.
>
> it turned out that the entry "snd-rme9652" matches with snd-rme96.
> so, it was targeted to another driver...

Ok great... then I know.

I think the hardware limitation (that is that you run it either in ADAT 
or S/PDIF mode, not both at the same time) is stated in the info for 
the card when you buy it, so it should not be necessary to have the 
same info in the driver page. As long as the hardware is fully 
supported there should not be necessary for any further notes.

Well, there actually is one limitation -- the driver does not support 
running the card in "multi-stereo device mode", which is a hardware 
hack to make the card simulate multiple stereo sound cards (I think it 
is to support old Microsoft Windows pcm APIs). ALSA makes such things 
redundant though, so I don't think it is a limitation worth mentioning. 
There is simply no reason for using the card that way when there is 
proper multi-channel support in the pcm API.

/Anders


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click

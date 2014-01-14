From: Daniel Mack <daniel@zonque.org>
Subject: Re: [ISSUE] crackles and clicks
Date: Tue, 14 Jan 2014 15:42:24 +0100
Message-ID: <20140114144224.GC23764@tamtam.fritz.box>
References: <CA+T9nP9VBdW6T8o3=5hFJpMXpHGz59VOGva2+8g8xoPw6Xa8+g@mail.gmail.com>
 <s5hy52kt71z.wl%tiwai@suse.de>
 <89F8E4011FD7234ABFE48744E300CBC206BC3EF2@041-DB3MPN1-093.041d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 64AAB2619F0
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 15:42:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <89F8E4011FD7234ABFE48744E300CBC206BC3EF2@041-DB3MPN1-093.041d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: LANGLOIS Olivier PIS -EXT <olivier.pis.langlois@transport.alstom.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 13, 2014 at 04:32:30PM +0000, LANGLOIS Olivier PIS -EXT wrote:
> > At Mon, 13 Jan 2014 09:34:04 +0100,
> > Eric F wrote:
> > >
> > > Hello,
> > >
> > > I tried my DAC (Tenor TE8802 chipset) in USB on Archlinux (LTS 3.10.26).
> > > I can hear regularly crackles ans clicks.
> > >
> > > I've tried all available USB ports, other kernels (3.12.6, 3.12.7),
> > > other distro (ubuntu), without luck...
> > >
> > > The DAC is Teac UD-H01.
> > >
> > > here is lsusb verbose : http://ix.io/9Q4
> > >
> > > Feel free to ask for more precisions, I'll give you all you need.
> >
> > Which program / sound backend did you test?  Do the crackles happen with
> > the plain "aplay -Dplughw foo.wav", too?
> >
> >
> > Takashi
> 
> If this can help in the investigation of your problem, I can experience crackles and clicks during pcm playback on my small hpmini notebook. I have kinda nailed down the source of the crackles and clicks.
> 
> It turns out that when my Wifi card is on but not connected, I have the crackles and clicks. If I connect to a Wifi network or close the Wifi, the crackles and clicks go away. I have not had the time check the Wifi driver code yet but my explanation of the behavior is that in that specific state, some wifi IRQ handler is taking too much time and stop my sound device irqs to be timely serviced.
> 
> My advice, is try to unload as much as possible kernel driver modules that may interfere with your audio playback and see if your crackles and clicks go away. For reference, here is my HW, in case you have the same Wifi Adapter....
> 

I'm not sure whether you're on the right track here.

Which program are you using for this? How are the buffer sizes
configured? Are you seeing XRUNs?

And are you sure the audio distortion doesn't relate to bad USB power?
Please check with a different PC as well, and for tests, put a
powered(!) USB hub inbetween your PC and the DAC.



Daniel

From: Johan Bilien <jobi@via.ecp.fr>
Subject: Re: nforce2 audio problem on 2.6.3
Date: Thu, 19 Feb 2004 21:06:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040219200613.GA6597@via.ecp.fr>
References: <20040219080352.GA7375@via.ecp.fr> <s5hvfm3uyoj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hvfm3uyoj.wl@alsa2.suse.de>
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

On Thu, Feb 19, 2004, Takashi Iwai wrote:
> > Since I moved from linux-2.6.2 to linux-2.6.3-rc2, and then 2.6.3, I am
> > experiencing a strange problem with all the GStreamer applications: as
> > soon as GStreamer tries to play out a sound, the system gets extremely
> > slow, and no sound comes out (although the GStreamer applications do not
> > complain and seem to be playing the sound find). I have only noticed
> > this behaviour with GStreamer, xmms, mpg321, VLC  etc. play sounds out,
> > but the sound suffers small interuptions now and then.
> > 
> > I am using a nforce2 motherboard, and the snd_intel8x0 ALSA driver. I
> > saw the recent thread regarding this driver being broken in the 1.0
> > serie, so I apply the patch given in the thread, but still get my
> > problem.
> 
> it likely has nothing to do with the problem of that thread.
> it seems that some nforce2 boards generate the unknown interrupts.
> i'm not sure whether it's in the ALSA side or in other kernel part.
> please try to copy the old ALSA tree from 2.6.2 to 2.6.3 (linux/sound
> and include/sound) and try the old driver on 2.6.3.

Going back to the old ALSA tree from 2.6.2 'solves' the problem. I am
not experiencing the gstreamer lock, nor the interuptions in other
programs' playout.

Regarding the nforce interupts problem you mention, I only get it when
APIC is turned on, which is not the case here.
                                                                                
Tell me if I can provide more information,
thanks,
--
Johan



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

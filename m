From: Edward Muller <edwardam@interlix.com>
Subject: Re: AW: (Still) Problems with VIA8233
Date: 12 Mar 2003 22:17:40 -0600
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <1047529059.2888.21.camel@localhost.localdomain>
References: <NNEPIBGIJICIEADJOOIACEBOCDAA.phueper@proqrent.de>
	 <1047404456.4763.29.camel@localhost.localdomain>
	 <s5h4r693i0m.wl@alsa2.suse.de>
	 <1047408479.4763.48.camel@localhost.localdomain>
	 <s5hy93k26o7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <s5hy93k26o7.wl@alsa2.suse.de>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Takashi Iwai <tiwai@suse.de>
Cc: Pattrick Hueper - proQrent GmbH <phueper@proqrent.de>, alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-How do I check to see if interrupts are generated during playback?
-What about the hardware configuration do you want to know?
-PnP OS is enabled at the moment, since well linux 2.4 is supposed to be
a pnp os ... no?

Output from /proc/pci

Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio
Controller (rev 80).
IRQ 6.
I/O at 0xe000 [0xe0ff].

My MoBo is an Asus Via KT400

I am using the following kernel args:
root=LABEL=/ hdc=ide-scsi pci=biosirq

I am using the following in my modules.conf:
options snd-via82xx index=0 id="VIA"

What should I check for in /proc/asound/card0/pcm0p/sub0?

I've updated to the current cvs as of this morning.

There is the way things work now. :-) 

xmms w/xmms-alsa: Works fine, no noticeable problems currently, although
I really didn't listen to much music today.

xmms w/oss support: plays a track fine, but when the track ends there is
a problem with the track either sputtering or repeating the last X
seconds (X = 1 or 2 seconds) over and over again for about 30 seconds.

aplay: same repeat problem describer earlier.

realplayer (uses OSS IIRC): Skipping and repeating either during a
track, at the end or in the beginning.

On Wed, 2003-03-12 at 04:58, Takashi Iwai wrote:
> At 11 Mar 2003 12:47:59 -0600,
> Edward Muller wrote:
> > 
> > comments inline...
> > 
> > On Tue, 2003-03-11 at 11:55, Takashi Iwai wrote:
> > > At 11 Mar 2003 11:40:56 -0600,
> > > Edward Muller wrote:
> > > > 
> > > > I am currently running a cvs version of also from a week ago...Sometime
> > > > after rc8 IIRC.
> > > > 
> > > > Here are my problems:
> > > > 
> > > > -OSS emulation is pretty much broken. This is my biggest problem since a
> > > > lot of app (esound, the kde rpms I am using, realplayer, etc) use oss.
> > >  
> > > please elaborate (together with your system details) ?
> > > "doesn't work" is not a magic word to explain everything.
> > 
> > Very true. Currently any apps using an oss device loop continuously over
> > the first X seconds of the music. I really don't know how long X is,
> > probably the first 1 to 3 seconds. I usually end up having to kill the
> > software to get control back.
> 
> hmm, can you check whether interrupts are generated during playback?
> how about the hardware configuration?
> on some mono, PnP OS must be disabled.
> 
> also, let me know the chip and the chip version.
> even VIA8233 and VIA8233A are fairly different.
> 
> 
> > 
> > > 
> > > ALSA native apps are working?  if yes, then it must be a different
> > > reason from Pattrick's problem.
> > 
> > Lemme re-state that. I was under the impression that the only native
> > alsa application I had was XMMS w/xmms-alsa. I forgot about things like
> > aplay and the like. aplay also exhibits the same problems as the oss
> > apps above. But XMMS w/xmms-alsa work for the most part. See my previous
> > comments about skipping/faltering ... And I really need to test w/o
> > preempt.
> 
> i'm wondering why xmms-alsa works at all even though aplay doesn't
> work.
> please check the files under /proc/asound/card0/pcm0p/sub0 in both
> cases.
> 
> anyway, update to version 0.9.1 at first, to keep things in sync.
> 
> 
> ciao,
> 
> Takashi
-- 
Edward Muller

Interlix - President

Web Hosting - PC Service & Support
Custom Programming - Network Service & Support

Phone: 417-862-0573
 Cell: 417-844-2435
  Fax: 417-862-0572

http://www.interlix.com



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en

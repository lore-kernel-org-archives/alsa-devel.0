From: Sam Morris <sam@robots.org.uk>
Subject: Bug#517241: [alsa-devel] Laptop (Samsung Q45) speakers unmute when master channel is	unmuted even with headphones connected
Date: Fri, 19 Jun 2009 15:08:32 +0100
Message-ID: <1245420512.9036.3.camel@durandal>
References: <20090502121442.GA14055@xerces> <s5hd4anddxy.wl%tiwai@suse.de>
	 <1241521119.19946.0.camel@durandal> <s5h63gd2bjn.wl%tiwai@suse.de>
	 <1245408989.9036.2.camel@durandal>  <s5hbpokgzaa.wl%tiwai@suse.de>
Reply-To: Sam Morris <sam@robots.org.uk>, 517241@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.517241.B517241.12454205281252@bugs.debian.org>
In-Reply-To: <s5hbpokgzaa.wl%tiwai@suse.de>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Takashi Iwai <tiwai@suse.de>
Cc: 517241@bugs.debian.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-06-19 at 14:53 +0200, Takashi Iwai wrote:
> At Fri, 19 Jun 2009 11:56:29 +0100,
> Sam Morris wrote:
> > 
> > On Thu, 2009-05-07 at 17:11 +0200, Takashi Iwai wrote:
> > > At Tue, 05 May 2009 11:58:39 +0100,
> > > Sam Morris wrote:
> > > > 
> > > > On Tue, 2009-05-05 at 12:47 +0200, Takashi Iwai wrote:
> > > > > At Sat, 2 May 2009 13:14:42 +0100,
> > > > > Sam Morris wrote:
> > > > > > 
> > > > > > Since Linux 2.6.28 and through to 2.6.30-rc4, the hda-intel driver has had a
> > > > > > bug on my laptop (a Samsung Q45).
> > > > > > 
> > > > > > If I connect my headphones, the laptop's internal speakers are muted--fine. But 
> > > > > > if I then mute and unmute the master mixer channel, the speakers come back to
> > > > > > life, even though the headphones are still connected.
> > > > > 
> > > > > Could you run alsa-info.sh with --no-upload option, and attach the
> > > > > generated file?
> > > > 
> > > > Here you go!
> > > 
> > > Thanks.
> > > 
> > > What if you use model=auto option?
> > 
> > This is fixed in 2.6.30, but only if I use the model=auto option. :)
> 
> What about with the later version, e.g. Linus git tree?
> Or you can use sound git tree
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> 
> I think this was already fixed there.
> 
> 
> Takashi
-- 
Sam Morris <sam@robots.org.uk>

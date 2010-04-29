From: James Andrewartha <trs80@ucc.gu.uwa.edu.au>
Subject: Bug#536896: linux-image-2.6.26-2-amd64: audio popping with gstreamer using apps when using amd64 kernel and i386 userspace
Date: Thu, 29 Apr 2010 19:04:17 +0800 (WST)
Message-ID: <alpine.DEB.1.10.1004291858140.11796@martello.ucc.gu.uwa.edu.au>
References: <20090714135754.4684.74223.reportbug@zarvora>  <20100225183435.GA8488@galadriel.inutil.org>  <alpine.DEB.1.10.1004120102110.24942@martello.ucc.gu.uwa.edu.au>  <1271017516.6179.126.camel@localhost>  <s5h633xb079.wl%tiwai@suse.de>
 <1271103529.6179.325.camel@localhost>
Reply-To: James Andrewartha <trs80@ucc.gu.uwa.edu.au>, 536896@bugs.debian.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.536896.B536896.127253906625850@bugs.debian.org>
In-Reply-To: <1271103529.6179.325.camel@localhost>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: 536896@bugs.debian.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 12 Apr 2010, Ben Hutchings wrote:

> On Mon, 2010-04-12 at 09:26 +0200, Takashi Iwai wrote:
> > At Sun, 11 Apr 2010 21:25:16 +0100,
> > Ben Hutchings wrote:
> > > 
> > > [1  <text/plain; UTF-8 (quoted-printable)>]
> > > [Earlier messages can be found at http://bugs.debian.org/536896 ]
> > > 
> > > On Mon, 2010-04-12 at 01:08 +0800, James Andrewartha wrote:
> [...]
> > > > Author: Takashi Iwai <tiwai@suse.de>  2008-01-09 02:08:14
> > > > Committer: Jaroslav Kysela <perex@perex.cz>  2008-02-01 01:29:47
> > > > Parent: d948035a928400ae127c873fbf771389bee18949 ([ALSA] Remove PCM xfer_align sw params)
> > > > 
> > > >     [ALSA] PCM - clean up snd_pcm_lib_read/write
> > > >     
> > > >     Introduce a common helper function for snd_pcm_lib_read and snd_pcm_lib_write
> > > >     for cleaning up the code.
> > > >     
> > > >     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > >     Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> > > > 
> > > > I don't know anything about this code, but I'm happy to deal with upstream 
> > > > if you'd prefer me to.
> > > 
> > > The above commit is supposed to be cleanup, but it has at least one
> > > semantic change: snd_pcm_mmap_control::avail_min no longer applies to
> > > non-blocking file handles.  I don't know whether this is was an
> > > intentional or unintentional change, but it wasn't commented.  I also
> > > don't know whether this can explain the popping, but I expect that it
> > > has changed the timing of audio I/O.
> > 
> > The above change is essentially a fix of the buggy behavior for
> > non-blocking access.  avail_min is the definition for wake-up
> > behavior, and it doesn't define the blocking behavior.
> > But, it's possible that this changes the timing, indeed.  If so, it
> > implies that the app expects somehow wrongly.
> 
> Thanks for your quick response.  I will reassign this bug to the
> applications that were mentioned.

I've tested totem from squeeze in a chroot and it still occurs, so it 
hasn't been fixed there.

ii  totem                       2.28.5-3                    A simple media player for the GNOME desktop based on GStreamer
ii  gstreamer0.10-alsa          0.10.28-1                   GStreamer plugin for ALSA
ii  gstreamer0.10-plugins-good  0.10.21-1                   GStreamer plugins from the "good" set
ii  libgstreamer-plugins-base0. 0.10.28-1                   GStreamer libraries from the "base" set
ii  libgstreamer0.10-0          0.10.28-1                   Core GStreamer libraries and elements


-- 
# TRS-80              trs80(a)ucc.gu.uwa.edu.au #/ "Otherwise Bub here will do \
# UCC Wheel Member     http://trs80.ucc.asn.au/ #|  what squirrels do best     |
[ "There's nobody getting rich writing          ]|  -- Collect and hide your   |
[  software that I know of" -- Bill Gates, 1980 ]\  nuts." -- Acid Reflux #231 /

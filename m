From: "Daniel J Blueman" <daniel.blueman@gmail.com>
Subject: Re: [HDA Intel/STAC92xx] mic not working
	(retasking?)...
Date: Fri, 6 Jul 2007 00:19:29 +0100
Message-ID: <6278d2220707051619l6ec7a61bj799364584bd77f57@mail.gmail.com>
References: <6278d2220706271328u79afd988r44cc1fbfc41c6014@mail.gmail.com>
	<6278d2220706301407p739ebfb5i52d4a2af3a17ecd8@mail.gmail.com>
	<s5habuec264.wl%tiwai@suse.de>
	<6278d2220707021539g1485af71v3cbb639f0844b271@mail.gmail.com>
	<s5h3b057u8d.wl%tiwai@suse.de>
	<6278d2220707031612i1c129969ga9c0d5d77b7c73db@mail.gmail.com>
	<s5h8x9w8hp5.wl%tiwai@suse.de>
	<6278d2220707041619x3f43510fud3009844874df603@mail.gmail.com>
	<s5htzsj5cse.wl%tiwai@suse.de>
	<6278d2220707050409h12710f2pbd71727e89309b23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by alsa0.perex.cz (Postfix) with ESMTP id A9A2F1038ED
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2007 01:19:30 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so600920ugf
	for <alsa-devel@alsa-project.org>; Thu, 05 Jul 2007 16:19:30 -0700 (PDT)
In-Reply-To: <6278d2220707050409h12710f2pbd71727e89309b23@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/07/07, Daniel J Blueman <daniel.blueman@gmail.com> wrote:
> > > > > > > > > > > With both 2.6.20 and 2.6.22 kernels on Ubuntu 7.04 on my Sony Vaio
> > > > > > > > > > > SZ240, I'm unable to get my mic connector working at any cost.
> > > > > > > > > >
> > > > > > > > > > First, show the contents of /proc/asound/card0/codec#* files...
> > > > > [snip]
> > > > > > > I have discovered the bug preventing me using the external mic socket
> > > > > > > before: in the mixer, the user has to select the [internal] mic input,
> > > > > > > then re-select the line-in (actually external mic) input; reading from
> > > > > > > (eg) /dev/dsp while changing this, the output suddenly is as expected
> > > > > > > when the line-in is re-selected.
> > > > > >
> > > > > > Could you elaborate?  What do yo mean "output" here, and what did you
> > > > > > expect?
> > > > >
> > > > > Looking at what is printed from the command 'cat /dev/dsp', what is
> > > > > shown changes when I de-select 'line-in' and then reselect it. Let me
> > > > > know if you're still unclear.
> > > > >
> > > > > > > Since we've got started, where should I look for the 'before' and
> > > > > > > 'after' state to compare to see into this?
> > > > > >
> > > > > > Yes, comparing the codec dump file would be helpful.
> > > > >
> > > > > Changing from the initial mixer state of 'Line-in' being selected to
> > > > > 'Microphone' does not change anything in the
> > > > > /proc/asound/card0/codec#{0,1} files. After, changing the input back
> > > > > to 'Line-in' does show a change [1] (which we'd expect).
> > > > >
> > > > > My interpretation of this is that (in the initial state) the STAC
> > > > > registers are set to record from the internal mic (which doesn't
> > > > > actually exist; there is a tiny amount of crosstalk) and the mixer
> > > > > settings ALSA reports show the line-in/external mic selected [2].
> > > >
> > > > The problem sounds like a mismatch of initialization verb and the
> > > > internal mixer state.  If it's the case, the patch below should fix,
> > > > then.
> > >
> > > This does indeed squarely address the problem I was having, and is a
> > > good fix here!
> > >
> > > The 'Line in' and 'Mic' inputs are a little confusing still. Do you
> > > think it's worth having 'Line/Mic in' or just 'External'?
> > >
> > > As there is no internal mic on this model the 'Mic' input is the
> > > opposite of what needs selecting. Is there any way we can address this
> > > at the same too? Perhaps 'Int mic' or similar would clarify it.
> >
> > OK, that makes sense.  I'll fix them, too.
> >
> > BTW, does the "Capture Boost" volume by the earlier patch have any
> > influence on the record quality?
>
> I didn't apply that patch, but will get back to you on this tonight.

I added the new 'Capture Boost Volume' control to both structures [1]
and see it in amixer [2], however I'm not able to tweak it in
alsamixer or gnome-volume-control. The external mic input is already
pretty crisp (with a good mic) both without and with these changes,
and at the recording levels I'd expect.

Let me know if you need further information etc.

Thanks again,
  Daniel

--- [1]

static struct snd_kcontrol_new vaio_mixer
static struct snd_kcontrol_new vaio_ar_mixer

--- [2]

$ amixer contents
numid=2,iface=MIXER,name='Master Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=1,iface=MIXER,name='Master Playback Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=127,step=0
  : values=114,114
numid=7,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---RW-,values=2,min=0,max=255,step=0
  : values=238,238
  | dBscale-min=-51.00dB,step=0.20dB,mute=0
numid=5,iface=MIXER,name='Capture Source'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Line'
  ; Item #1 'Mic'
  : values=0
numid=6,iface=MIXER,name='Capture Boost Volume'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=4,iface=MIXER,name='Capture Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=3,iface=MIXER,name='Capture Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=15,step=0
  : values=15,15
  | dBscale-min=0.00dB,step=1.50dB,mute=0
-- 
Daniel J Blueman

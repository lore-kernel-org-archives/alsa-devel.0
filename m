From: Adam Lee <adam8157@gmail.com>
Subject: Bug#663090: [alsa-devel] amixer: convert percentage into db wrongly
Date: Fri, 9 Mar 2012 18:06:17 +0800
Message-ID: <20120309100617.GH2130@adam-station.nay.redhat.com>
References: <20120308123632.GA8920@adam-laptop>
 <20120308163001.GA2991@samweis.home.lxtec.de>
 <s5h399jyrc5.wl%tiwai@suse.de>
 <20120309042247.GE2130@adam-station.nay.redhat.com>
 <s5haa3qnup0.wl%tiwai@suse.de>
 <20120309090717.GG2130@adam-station.nay.redhat.com>
 <s5hty1ym898.wl%tiwai@suse.de>
Reply-To: Adam Lee <adam8157@gmail.com>, 663090@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.663090.B663090.133128764025104@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <s5hty1ym898.wl%tiwai@suse.de>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Takashi Iwai <tiwai@suse.de>
Cc: Elimar Riesebieter <riesebie@lxtec.de>, 663090@bugs.debian.org, alsa-devel@alsa-project.org, Vincent Cheng <Vincentc1208@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 09, 2012 at 10:30:27AM +0100, Takashi Iwai wrote:
> At Fri, 9 Mar 2012 17:07:17 +0800,
> Adam Lee wrote:
> > 
> > On Fri, Mar 09, 2012 at 07:40:27AM +0100, Takashi Iwai wrote:
> > > At Fri, 9 Mar 2012 12:22:47 +0800,
> > > Adam Lee wrote:
> > > > 
> > > > Add Vincent in cc, because conky read amixer's result.
> > > > 
> > > > On Thu, Mar 08, 2012 at 05:45:14PM +0100, Takashi Iwai wrote:
> > > > > > * Adam Lee <adam8157@gmail.com> [2012-03-08 20:36 +0800]:
> > > > > > 
> > > > > > Package: alsa-utils
> > > > > > Version: 1.0.25-1
> > > > > > Severity: important
> > > > > > 
> > > > > > 
> > > > > > db is not linear, but amixer believe it is.
> > > > > > 
> > > > > > "amixer get Master" says "Limits: Playback 0 - 74", then everytime I run
> > > > > > "amixer -q sset Master 10%-", there is 8db dec.
> > > > > > 
> > > > > > For example, at first Master is 100% and 0db, both alsamixer and amixer
> > > > > > think it is, and after I run "amixer -q sset Master 10%-", both
> > > > > > alsamixer and amixer says Master is -8.00db, but alsamixer says it is
> > > > > > 72%, amixer says it is 89%.
> > > > > > 
> > > > > > alsamixer is right, amixer calc and set wrongly.
> > > > > 
> > > > > No, both are correct.  You are dreaming too much on the world unified
> > > > > percentage representation :)
> > > > > 
> > > > > The percentage in amixer has nothing to do with dB level.
> > > > > It's just the percentage of the raw value range of that mixer
> > > > > element.  Thus showing 89% is correct.  It's 10% down from 100%
> > > > > (1% is because of the resolution of the raw values).
> > > > > 
> > > > > Now, alsamixer shows the percentage in a different way.  It's
> > > > > explained well in the source code (alsamixer/volume_mapping.c), but
> > > > > not mentioned in the man page, unfortunately.
> > > > > 
> > > > >  * The mapping is designed so that the position in the interval is proportional
> > > > >  * to the volume as a human ear would perceive it (i.e., the position is the
> > > > >  * cubic root of the linear sample multiplication factor).  For controls with
> > > > >  * a small range (24 dB or less), the mapping is linear in the dB values so
> > > > >  * that each step has the same size visually.  Only for controls without dB
> > > > >  * information, a linear mapping of the hardware volume register values is used
> > > > >  * (this is the same algorithm as used in the old alsamixer).
> > > > > 
> > > > > The percentage representation in alsamixer corresponds to this
> > > > > mapping, thus it's neither dB nor linear percent.
> > > > > 
> > > > 
> > > > Hi, Takashi
> > > > 
> > > > Thank you for replying. But I still insist this is a bug. Three
> > > > questions:
> > > > 
> > > > 1, several months ago, it's OK, both amixer and alsamixer use the human
> > > > mapping(0-10% and 90%-100% are the same change by a human ear), why not
> > > > now?
> > > 
> > > amixer hasn't been changed until yet.  It handles either in raw values
> > > or in dB.  No human-ear mapping at all.  It's never changed since
> > > years, and won't be changed.  If the volume mapping would be
> > > implemented to amixer in future, it must be only optional.
> > > 
> > > Only the recent alsamixer introduced the volume mapping to visualize
> > > the volumes reasonably.
> > > 
> > 
> > OK, thank you. Maybe an optional will make everyone happy.
> > 
> > > > 2, conky(Vincent, I mean ${mixer}), some other software, lot of user's
> > > > scripts use amixer to set or get volume, expecting the human mapping,
> > > > why change the behavior?
> > > 
> > > You must be smoking something bad.  The behavior of amixer hasn't been
> > > changed.
> > > 
> > 
> > I figured out a reason probably, when the limits range is wide, like
> > 0-65536, amixer's mapping and alsamixer's human-ear mapping are close.
> > 
> > If I remember right, my hardware's limits was 0-65536, but it becomes
> > 0-74 after I run "alsactl init", but unfortunately, I don't know how to
> > modify it back.
> > 
> > > > 3, alsamixer and amixer use the same dB value, why there is difference
> > > > in percentage? If alsa-utils developer think the human mapping sucks,
> > > > why you guys still use it in alsamixer? There is no "both correct", the
> > > > difference confuses user...
> > > 
> > > That's true.  alsamixer should have stopped showing the stupid
> > > percentage.
> > > 
> > > The biggest understand is that people (including you) think there is
> > > an absolutely perfect percentage definition for the sound level.  It's
> > > an illusion.
> > > 
> > 
> > I don't expect an absolutely perfect percentage definition. I want a
> > human-ear mapping, which alsamixer does well, 100% is about as ten times
> > loud as 10%.
> 
> How did you measure _quantitatively_ it's exactly ten times louder?
> And you think 50% is ten times loud as 5% volume, 10% is ten times
> loud as 1%?  Things aren't so easy, unfortunately.
> 
> > But amixer doesn't work like that, amixer's 100% is about
> > as *one hundred times* as amixer's 10%.
> 
> Yes, this is what's amixer expected to behave.  It's a value just
> representing the percentage of a "raw value" of the mixer element.
> It never says it's corresponding to any practical volume.  This is the
> misunderstanding first of all.
> 
> For example, I guess in your 64k case, the raw value is even not in dB
> unit but it's a linear volume.  amixer doesn't care.  10% means only
> the 6553 of 65536.  That's all.  So simple.
> (In addition, amixer can handle dB, e.g. amixer set Master +10dB or
>  such.  But it's not suitable for percentage unit because dB level
>  can't be represented in the absolute percent volume -- what is 10% in
>  dB?)
> 
> > Maybe it is beautiful, and alsamixer's human-ear mapping is stupid in
> > the sound science universe. But as a common user, I don't think so. And
> > I don't know how you guys put up with it :(
> 
> No, you misunderstand what I wrote.  alsamixer's mapping is really an
> improvement.  That's why it was implemented recently.  But if it shows
> a different number, user may wonder, just like you did.  If you didn't
> see a number, you didn't notice the difference :)
> 
> But amixer wasn't changed.  amixer is a tool to manipulate raw
> values.  Of course, it'd be also nice to implement the same percentage
> expression, but as already mentioned, it should be activated only via
> an option.  The default behavior of amixer must not be changed for
> compatibility reason.
> 

OK.

Looking forward to the option, if your time and other capacity allow :)

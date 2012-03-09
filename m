From: Adam Lee <adam8157@gmail.com>
Subject: Bug#663090: [alsa-devel] amixer: convert percentage into db wrongly
Date: Fri, 9 Mar 2012 12:22:47 +0800
Message-ID: <20120309042247.GE2130@adam-station.nay.redhat.com>
References: <20120308123632.GA8920@adam-laptop>
 <20120308163001.GA2991@samweis.home.lxtec.de>
 <s5h399jyrc5.wl%tiwai@suse.de>
Reply-To: Adam Lee <adam8157@gmail.com>, 663090@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.663090.B663090.133126700325453@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <s5h399jyrc5.wl%tiwai@suse.de>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Takashi Iwai <tiwai@suse.de>
Cc: Elimar Riesebieter <riesebie@lxtec.de>, 663090@bugs.debian.org, alsa-devel@alsa-project.org, control@bugs.debian.org, Vincent Cheng <Vincentc1208@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add Vincent in cc, because conky read amixer's result.

On Thu, Mar 08, 2012 at 05:45:14PM +0100, Takashi Iwai wrote:
> > * Adam Lee <adam8157@gmail.com> [2012-03-08 20:36 +0800]:
> > 
> > Package: alsa-utils
> > Version: 1.0.25-1
> > Severity: important
> > 
> > 
> > db is not linear, but amixer believe it is.
> > 
> > "amixer get Master" says "Limits: Playback 0 - 74", then everytime I run
> > "amixer -q sset Master 10%-", there is 8db dec.
> > 
> > For example, at first Master is 100% and 0db, both alsamixer and amixer
> > think it is, and after I run "amixer -q sset Master 10%-", both
> > alsamixer and amixer says Master is -8.00db, but alsamixer says it is
> > 72%, amixer says it is 89%.
> > 
> > alsamixer is right, amixer calc and set wrongly.
> 
> No, both are correct.  You are dreaming too much on the world unified
> percentage representation :)
> 
> The percentage in amixer has nothing to do with dB level.
> It's just the percentage of the raw value range of that mixer
> element.  Thus showing 89% is correct.  It's 10% down from 100%
> (1% is because of the resolution of the raw values).
> 
> Now, alsamixer shows the percentage in a different way.  It's
> explained well in the source code (alsamixer/volume_mapping.c), but
> not mentioned in the man page, unfortunately.
> 
>  * The mapping is designed so that the position in the interval is proportional
>  * to the volume as a human ear would perceive it (i.e., the position is the
>  * cubic root of the linear sample multiplication factor).  For controls with
>  * a small range (24 dB or less), the mapping is linear in the dB values so
>  * that each step has the same size visually.  Only for controls without dB
>  * information, a linear mapping of the hardware volume register values is used
>  * (this is the same algorithm as used in the old alsamixer).
> 
> The percentage representation in alsamixer corresponds to this
> mapping, thus it's neither dB nor linear percent.
> 

Hi, Takashi

Thank you for replying. But I still insist this is a bug. Three
questions:

1, several months ago, it's OK, both amixer and alsamixer use the human
mapping(0-10% and 90%-100% are the same change by a human ear), why not
now?

2, conky(Vincent, I mean ${mixer}), some other software, lot of user's
scripts use amixer to set or get volume, expecting the human mapping,
why change the behavior?

3, alsamixer and amixer use the same dB value, why there is difference
in percentage? If alsa-utils developer think the human mapping sucks,
why you guys still use it in alsamixer? There is no "both correct", the
difference confuses user...

IMO: Any, any human says 10% plus, she or he definitely wants the human
mapping. Maybe you developing guys think there is nothing wrong now, but
how about think it from the perspective of user?

Please consider about fixing it, at least discuss it in alsa-utils mail
list, thank you.

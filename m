From: Edward Tandi <ed@efix.biz>
Subject: Re: OSS sound emulation broken between 2.6.0-test2 and test3
Date: Sat, 27 Dec 2003 13:08:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1072530488.2906.1.camel@wires.home.biz>
References: <1080000.1072475704@[10.10.2.4]>
	 <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]>
	 <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]>
	 <1072482611.21020.71.camel@nosferatu.lan>  <2060000.1072483186@[10.10.2.4]>
	 <1072500516.12203.2.camel@duergar>  <8240000.1072511437@[10.10.2.4]>
	 <1072523478.12308.52.camel@nosferatu.lan>
	 <1072525450.3794.8.camel@wires.home.biz>
	 <1072527874.12308.100.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1072527874.12308.100.camel@nosferatu.lan>
To: azarah@nosferatu.za.org
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, perex@suse.cz, alsa-devel@lists.sourceforge.net, Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>, Rob Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>, Stan Bubrouski <stan@ccs.neu.edu>
List-Id: alsa-devel@alsa-project.org

On Sat, 2003-12-27 at 12:24, Martin Schlemmer wrote:
> On Sat, 2003-12-27 at 13:44, Edward Tandi wrote:
> > On Sat, 2003-12-27 at 11:11, Martin Schlemmer wrote:
> > > On Sat, 2003-12-27 at 09:50, Martin J. Bligh wrote:
> > > > Something appears to have broken OSS sound emulation between 
> > > > test2 and test3. Best I can tell (despite the appearance of the BK logs), 
> > > > that included ALSA updates 0.9.5 and 0.9.6. Hopefully someone who
> > > > understands the sound architecture better than I can fix this?
> > > > 
> > > 
> > > I wont say I understand it, but a quick look seems the major change is
> > > the addition of the 'whole-frag' and 'no-silence' opts.  You might try
> > > the following to revert what 'no-silence' change at least does:
> > > 
> > > --
> > >  # echo 'xmms 0 0 no-silence' > /proc/asound/card0/pcm0p/oss
> > >  # echo 'xmms 0 0 whole-frag' > /proc/asound/card0/pcm0p/oss
> > > --
> > 
> > Thanks, that fixes it for me. I too have been seeing terrible problems
> > with XMMS since the early 2.6 pre- kernels.
> > 
> > Because it only happens in XMMS I thought it was one of those
> > application bugs brought out by scheduler changes. I now use Zinf BTW
> > -It's better for large music collections (although not as stable or
> > flash).
> > 
> 
> Can you check which one actually fixes it ?

Yes, its the 'whole-frag' line.

Ed-T.

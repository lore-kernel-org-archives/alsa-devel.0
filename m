From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: ALSA problems with 2.6.18-rc3
Date: Wed, 9 Aug 2006 23:28:47 +0100
Message-ID: <200608092328.47039.s0348365@sms.ed.ac.uk>
References: <44D8F3E5.5020508@ukonline.co.uk>
	<200608092307.27615.s0348365@sms.ed.ac.uk>
	<1155161498.26338.216.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1155161498.26338.216.camel@mindpipe>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Benton <b3nt@ukonline.co.uk>, Gene Heskett <gene.heskett@verizon.net>, alsa-devel <alsa-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 09 August 2006 23:11, Lee Revell wrote:
> On Wed, 2006-08-09 at 23:07 +0100, Alistair John Strachan wrote:
[snip]
> > However, ALSA _has_ defaults for these controls, which I believe are
> > usually "off" or "zero". All I'm suggesting is that these defaults are
> > plainly suboptimal for emu10k1, and probably other cards to which this
> > statement simply does not apply. Shipping defaults is one thing, but
> > shipping useless defaults is quite another. We have policy all over
> > the kernel for providing "sane defaults" e.g. filesystem mount
> > options.
>
> I think muted is a sane default - the only sane default.  Otherwise you
> could damage speakers or hearing.  Also many devices will be noisier if
> unused inputs are enabled.  Is it really that hard for users to unmute
> the mixer or for distros to create their own config?

I think this argument is mostly deflated by the fact that other 
multimedia-centric operating systems do not ship with controls muted. If 
hardware is detected, all sliders are set to 50%. I think this is superior.

As you pointed out, it probably is best left to distros. I just can't help 
thinking that there might be some scope for improving the default state of 
boolean tunables, even if sliders are left at zero.

> Also, analog output on my emu10k1 works perfectly with "External
> Amplifier" disabled.

Interesting, evidence in your favour. It does not work here. It also did not 
work on the AC'97 in my HP NC6000, which also has External something-or-other 
and which also defaulted to "off".

Took some figuring out. :-)

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

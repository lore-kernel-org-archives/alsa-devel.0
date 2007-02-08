From: Jason Baron <jbaron@redhat.com>
Subject: Re: stac92xx_parse_auto_config() can return 0 on error?
Date: Thu, 8 Feb 2007 11:34:23 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702081133190.6346@dhcp83-20.boston.redhat.com>
References: <Pine.LNX.4.64.0702051624060.26250@dhcp83-20.boston.redhat.com>
	<1170714593.28278.151.camel@localhost> <s5h64afy0bb.wl%tiwai@suse.de>
	<s5hd54kpsy5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1430432F
	for <alsa-devel@alsa-project.org>; Thu,  8 Feb 2007 17:37:16 +0100 (MET)
In-Reply-To: <s5hd54kpsy5.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: John Linville <linville@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Thu, 8 Feb 2007, Takashi Iwai wrote:

> At Tue, 06 Feb 2007 12:47:52 +0100,
> I wrote:
> > 
> > At Mon, 05 Feb 2007 14:29:53 -0800,
> > Tobin Davis wrote:
> > > 
> > > On Mon, 2007-02-05 at 16:40 -0500, Jason Baron wrote:
> > > 
> > >     hi,
> > >     
> > >     I just ran into a RHEL4 U5 beta kernel oops in snd_hda_input_mux_info(), 
> > >     because the 'imux' parameter pointer was NULL. I traced this back to 
> > >     stac92xx_parse_auto_config(), which can return 0, if 'line_outs' is not 
> > >     set, without having initialized the 'input_mux'.
> > >     
> > >     The oops does not happen on the upstream kernel on this hardware b/c 
> > >     'line_outs' was set (additional code has been added since RHEL4 to set 
> > >     it). However, it still appears to me, that if 'line_outs' is not set, we 
> > >     should return an error code, and not 0.
> > >     
> > >     thanks,
> > >     
> > >     -Jason
> > > 
> > > Try this patch to see if it works with your alsa version.  It's a simple patch that
> > > adds the error condition, and should be able to be applied to older alsa versions.
> > > 
> > > Summary:  add error for undetected line_outs.
> > > 
> > > This adds an error condition to stac92xx_parse_auto_config if line_outs is less than
> > > zero.
> > > 
> > 
> > line_outs won't be negative, so this situation can't happen.
> > The problem is that stac92xx_parse_auto_config() returns "0" (which
> > means successful) even if line_outs = 0 and thus nothing is
> > configured.  Simply changing it to return -EINVAL would work. 
> > 
> > However, this is no best solution.  In the case of patch_realtek.c or
> > others, the codec probe routine behaves slightly differently. 
> > *_parse_auto_config() may return 0 if no ane configuration is found.
> > Then it falls back to model=basic.  Returning a negative means a fatal
> > error to stop.  Meanwhile, in the case of sigmatel, there is no
> > fallback, so it always stop.
> > 
> > The patch below adds the fallback to model=ref in case that no proper
> > auto-config is available.  Please give it a try.
> 
> Can anyone confirm whether the patch fixes the problem or not?
> I'd like to put this into the upstream ASAP, so that it's surely
> merged in 2.6.21...
> 
> 
> thanks,
> 
> Takashi
> 


The upstream code works fine on the box that had the oops, i think due to
the 'fixup' code at the end of 'snd_hda_parse_pin_def_config()' which we
didn't have in RHEL4. In rhel4 the patch wouldn't compile, due to the
STAC_D945_REF, being not defined. However, i did verify that just 
returning and error code made the oops go away.

-Jason

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

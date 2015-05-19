From: Jonathan McDowell <noodles@earth.li>
Subject: Re: Audio crackles with 4.1-rc1
Date: Tue, 19 May 2015 22:53:10 +0100
Message-ID: <20150519215310.GF28070@earth.li>
References: <s5hpp6ov1wv.wl-tiwai@suse.de>
 <s5ha8xsuxe3.wl-tiwai@suse.de>
 <20150429112859.GY10148@earth.li>
 <s5h4mnzgne6.wl-tiwai@suse.de>
 <20150430150131.GA10148@earth.li>
 <s5hd22l7dgo.wl-tiwai@suse.de>
 <20150502150513.GF10148@earth.li>
 <s5hk2w514aj.wl-tiwai@suse.de>
 <20150519161911.GD28070@earth.li>
 <s5hr3qctryf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hr3qctryf.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 19, 2015 at 07:09:12PM +0200, Takashi Iwai wrote:
> At Tue, 19 May 2015 17:19:11 +0100,
> Jonathan McDowell wrote:
> > 
> > On Tue, May 19, 2015 at 08:15:32AM +0200, Takashi Iwai wrote:
> > > Does the patch below have any improvement?
> > 
> > I still get a clicking on the standby -> active transition with the
> > patch provided on top of 4.1-rc4.
> 
> OK, just to be sure, could you check whether changing msleep(10) to
> msleep(100) makes no difference?  Also put a line like
> 	pr_info("XXX power up %x\n", nid);
> after msleep() call to see which nodes are powered up dynamically.

Increasing the delay, if anything, makes the crackle when powering up
seem a little longer. dmesg log looks like:

[ 4206.075557] XXX power up 2
[ 4206.179671] XXX power up 14
[ 4206.291758] XXX power up 3

J.

-- 
                                            xmpp:noodles@earth.li
"f u cn rd ths, u cn gt a gd jb n cmptr
                                            prgrmmng." -- Simon
Cozens, ox.os.linux

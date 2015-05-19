From: Jonathan McDowell <noodles@earth.li>
Subject: Re: Audio crackles with 4.1-rc1
Date: Tue, 19 May 2015 17:19:11 +0100
Message-ID: <20150519161911.GD28070@earth.li>
References: <s5hvbggv4xa.wl-tiwai@suse.de>
 <20150428123518.GU10148@earth.li>
 <s5hpp6ov1wv.wl-tiwai@suse.de>
 <s5ha8xsuxe3.wl-tiwai@suse.de>
 <20150429112859.GY10148@earth.li>
 <s5h4mnzgne6.wl-tiwai@suse.de>
 <20150430150131.GA10148@earth.li>
 <s5hd22l7dgo.wl-tiwai@suse.de>
 <20150502150513.GF10148@earth.li>
 <s5hk2w514aj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hk2w514aj.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 19, 2015 at 08:15:32AM +0200, Takashi Iwai wrote:
> At Sat, 2 May 2015 16:05:13 +0100,
> Jonathan McDowell wrote:
> > 
> > On Thu, Apr 30, 2015 at 07:06:31PM +0200, Takashi Iwai wrote:
> > > At Thu, 30 Apr 2015 16:01:31 +0100, Jonathan McDowell wrote:
> > > > 
> > > > On Wed, Apr 29, 2015 at 01:54:57PM +0200, Takashi Iwai wrote:
> > > > > 
> > > > > One patch you can try (with or without power_save_node
> > > > > disablement) is below, it squashes the verb sequences at (runtime)
> > > > > PM resume as we did for 4.0.  Let me know if this changes the
> > > > > behavior.
> > > > 
> > > > Patch alone has no effect. Patch with power_save_node disablement
> > > > solves the problem. Didn't try power_save_node disablement without
> > > > the patch.
> > > 
> > > Then please confirm that only power_save_node disablement suffices.
> > > This can be considered as the least change that can be put to 4.1-rc
> > > if no better fix is found.
> > 
> > Setting codec->power_save_node to 0 in patch_alc269 is sufficient; no
> > noticeable cracking occurring.
> 
> Does the patch below have any improvement?

I still get a clicking on the standby -> active transition with the
patch provided on top of 4.1-rc4.

J.

-- 
   101 things you can't have too   |  .''`.  Debian GNU/Linux Developer
  much of : 9 - Processing power.  | : :' :  Happy to accept PGP signed
                                   | `. `'   or encrypted mail - RSA
                                   |   `-    key on the keyservers.

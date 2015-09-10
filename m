From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: Missing return check of of_property_read_*()
Date: Thu, 10 Sep 2015 19:17:55 +0800
Message-ID: <20150910111755.GA15572@wfg-t540p.sh.intel.com>
References: <s5hfv2nd45t.wl-tiwai@suse.de>
 <20150909155737.GB20922@sirena.org.uk>
 <s5hvbbjbmzx.wl-tiwai@suse.de>
 <20150909161919.GC20922@sirena.org.uk>
 <s5hr3m7bls5.wl-tiwai@suse.de>
 <20150910031022.GA28677@wfg-t540p.sh.intel.com>
 <20150910032344.GA29391@wfg-t540p.sh.intel.com>
 <s5h37ymet63.wl-tiwai@suse.de>
 <20150910062432.GA3326@wfg-t540p.sh.intel.com>
 <20150910105450.GF20922@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FC372614D6
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2015 13:17:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150910105450.GF20922@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 10, 2015 at 11:54:50AM +0100, Mark Brown wrote:
> On Thu, Sep 10, 2015 at 02:24:32PM +0800, Fengguang Wu wrote:
> > On Thu, Sep 10, 2015 at 07:32:04AM +0200, Takashi Iwai wrote:
> 
> > > So this made me wonder whether we have a way to take a glance through
> > > gathered compile warnings at once.  Are they archived and reachable?
> 
> > Yes. Here are the active "may be used uninitialized" warnings under sound/:
> 
> > sound/core/pcm_lib.c:244: warning: 'curr_tstamp.tv_nsec' may be used uninitialized in this function
> 
> Is there any way we can view the current status on line?

We don't have interactive web interfaces to query/browse things.
Sorry!

Regards,
Fengguang

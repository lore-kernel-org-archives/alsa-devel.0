From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 2/3] ALSA: hdac_ext: add hdac extended
 controller
Date: Mon, 8 Jun 2015 21:30:00 +0530
Message-ID: <20150608160000.GS28601@localhost>
References: <1433411602-5444-1-git-send-email-vinod.koul@intel.com>
 <1433411602-5444-3-git-send-email-vinod.koul@intel.com>
 <s5heglmk1gv.wl-tiwai@suse.de> <20150608153259.GO28601@localhost>
 <s5hlhfuqk9q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id EFB01260442
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 18:12:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hlhfuqk9q.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 08, 2015 at 05:42:25PM +0200, Takashi Iwai wrote:
> At Mon, 8 Jun 2015 21:02:59 +0530,
> Vinod Koul wrote:
> > 
> > On Mon, Jun 08, 2015 at 11:12:48AM +0200, Takashi Iwai wrote:
> > > > +struct hdac_ext_link {
> > > > +	struct hdac_bus *bus;
> > > > +	int index;
> > > > +	void __iomem *ml_addr; /* link output stream reg pointer */
> > > > +	u32 lcaps;   /* link capablities */
> > > > +	u16 lsdiid;  /* link sdi identifier */
> > > > +	char codec[HDA_MAX_CODECS][32]; /* codecs connectes to the link */
> > > 
> > > Do we need to keep the codec name string?  Isn't it just codec address
> > > we'd like to check the match...?  If so, we may use bitmasks instead,
> > > too.
> > This is not for matching stuff (this is link structure and not codec)
> > So we keep name of codec found on this link. When ASoC BE triggers we use
> > codec name to find the link and use
> 
> But each codec name consists of just a few bits.  Why do you need to
> keep each codec name string?
Yes got your point now, we can indeed generate the codec name and avoid
char array

-- 
~Vinod

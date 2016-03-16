From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [pulseaudio-discuss] ASoC and pulseaudio
Date: Wed, 16 Mar 2016 21:23:42 +0530
Message-ID: <20160316155342.GV13211@localhost>
References: <20160314160654.GA2566@sirena.org.uk>
 <1458021688.8522.16.camel@loki>
 <20160315084544.GF2566@sirena.org.uk>
 <s5hmvq0glxj.wl-tiwai@suse.de> <1458035331.8522.52.camel@loki>
 <s5h8u1kgj3c.wl-tiwai@suse.de> <1458039506.8522.70.camel@loki>
 <20160316145704.GU13211@localhost>
 <20160316150949.GX2566@sirena.org.uk>
 <s5hwpp2bggh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id AA8CD2660CF
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 16:49:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwpp2bggh.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, "han.lu" <han.lu@linux.intel.com>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 16, 2016 at 04:17:02PM +0100, Takashi Iwai wrote:
> On Wed, 16 Mar 2016 16:09:49 +0100,
> Mark Brown wrote:
> > 
> > On Wed, Mar 16, 2016 at 08:27:04PM +0530, Vinod Koul wrote:
> > 
> > > So I don't think FW name would help, if required we should add dev_info
> > > to print the firmware which is getting loaded.
> > 
> > We can't really be relying on userspace trawling through the logs -
> > quite apart from anything else the message might be long gone by the
> > time the relevant program gets started.
> > 
> > Might be an idea to record it in sysfs somewhere?

Sounds good to me

> Yeah, that should be feasible.  Also, there is a "component" field
> assigned to the card.  This is supposed to be referred by user-space
> as additional information.  See snd_component_add().

Will add this to my ever growing list of things to do... :D

-- 
~Vinod

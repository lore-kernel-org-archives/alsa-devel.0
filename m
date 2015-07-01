From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 0/13] topology support for alsa-lib
Date: Wed, 01 Jul 2015 17:13:52 +0100
Message-ID: <1435767232.29665.30.camel@loki>
References: <1435758316.29665.23.camel@loki> <s5hh9pnlw2s.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id CEFFC2606F6
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2015 18:14:04 +0200 (CEST)
In-Reply-To: <s5hh9pnlw2s.wl-tiwai@suse.de>
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-07-01 at 17:46 +0200, Takashi Iwai wrote:
> At Wed, 01 Jul 2015 14:45:16 +0100,
> Liam Girdwood wrote:
> > 
> > This patch series adds the topology text parser support to alsa-lib. The
> > topology parser converts text topology data to the binary ABI format
> > read by the kernel topology core.
> > 
> > Changes since V1 :-
> > 
> >  o Terminate all strncpy() strings with NULL.
> >  o Use snd_pcm_format_value() instead of local lookup.
> >  o Set a maximum size for private data files.
> >  o Set capture/playback stream direction for new PCMs
> >  o Only set TLV access flags for TLV CTLs.
> > 
> > Liam
> 
> You can manage such a cover letter better with --cover-letter option
> of git-format-patch or git-send-email.
> 

I know, I guess I'm set in my ways ;) Will do it next time.

Liam

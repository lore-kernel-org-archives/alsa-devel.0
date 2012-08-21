From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 14:59:47 +0100
Message-ID: <20120821135947.GB21557@sirena.org.uk>
References: <s5hr4r0359e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FFCD265F1D
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 15:59:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hr4r0359e.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 21, 2012 at 12:31:57PM +0200, Takashi Iwai wrote:

> snd_pcm_query_chmaps() returns the list of channel maps.  A channel
> map is represented by an integer array, beginning with the channel map
> type, followed by the number of channels, and the position of each
> channel, e.g.
>   { SND_CHMAP_FIXED, 4, SND_CHMAP_FL, SND_CHMAP_FR, SND_CHMAP_RL, SND_CHMAP_RR }

Currently only named channel maps are supported.  It'd be nice to also
support just plain numbered channels, or at least provide a way to say
to userspace that it needs to do something like chase through a routing
map to figure out where each channel goes (as opposed to assuming that
the driver doesn't know what to report).  

It'd also be nice to be able to express the situation we sometimes get
in embedded devices where we (for example) play to channels 0 and 1 to
get headphones and to 2 and 3 for speaker but that usually falls into
the route tracing case anyway so I'm not sure it's worth worrying about.

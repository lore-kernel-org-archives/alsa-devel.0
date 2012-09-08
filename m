From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: How to define card specific pcm devices?
Date: Sat, 08 Sep 2012 11:04:39 +0300
Message-ID: <1347091479.3351.15.camel@laptop>
References: <1344597903.4283.68.camel@IT-D-4QB9Z4J>
 <1345215040.2530.26.camel@IT-D-4QB9Z4J>
 <CAN8cciYX4krbJvb9PWQFswAKq0AqiC_oh20n+NB2Ak=BF8Zgxw@mail.gmail.com>
 <CAN8cciZH2SL7Dm0ykA+hfRoksngo9Z15pkTLHp+pXDYSKpm90w@mail.gmail.com>
 <1345262953.4864.12.camel@laptop>
 <CAN8cciYojFegq+cQ-=h6Yt4njO4pPyGB_zG2WkMT4A8euDV6Ww@mail.gmail.com>
 <1346823662.3629.17.camel@laptop>
 <CABS+qY3kEPr3aknPvTU+iRyGxSo2G_iDawv+fr7WBJrJQUO+2w@mail.gmail.com>
 <1346951914.4893.6.camel@odin> <1347008614.4213.19.camel@laptop>
 <s5hobliw4ys.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 5E5E826172E
 for <alsa-devel@alsa-project.org>; Sat,  8 Sep 2012 10:04:43 +0200 (CEST)
In-Reply-To: <s5hobliw4ys.wl%tiwai@suse.de>
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
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-09-07 at 11:35 +0200, Takashi Iwai wrote:
> At Fri, 07 Sep 2012 12:03:34 +0300,
> Tanu Kaskinen wrote:
> > A question about the syntax: should the PHASE_INVERSE and DRIVER_SPEC
> > flags be supported also here, or is it enough to have just a simple list
> > of channels?
> > 
> > I think the syntax will have to support the flags, because if
> > DRIVER_SPEC is set, then the channel position is effectively unknown to
> > PulseAudio. The channel map may potentially affect routing decisions,
> > which is the main reason why the channel map information is needed in
> > UCM in addition to the new channel map API. The channel map API can be
> > used only with an already opened pcm handle, which is not very useful
> > when doing routing decisions.
> 
> Well, the kernel side API doesn't require that the PCM to be open.
> It's just a read of TLV from a control element.
> 
> The problem is that the configuration is evaluated only at open in
> alsa-lib PCM abstraction.  That's the only reason chmap query takes
> snd_pcm_t handle.
> 
> In other words, it's pretty easy to provide a query function limited
> only for hw device, such as
> 
> snd_pcm_chmap_query_t **snd_pcm_query_chmaps_from_hw(int card, int device,
> 	int substream);
> 
> Ideally it should be a query from a PCM name string like
> 
> snd_pcm_chmap_query_t **snd_pcm_query_chmaps_from_name(const char *name);
> 
> But it's hard for now without opening a PCM because we need to parse
> down the definition of the given PCM and the underlying plugin
> expansions require the opens of their slave PCMs.

I now realized that even if we had snd_pcm_query_chmaps_from_name(), the
channel map information would still be needed in the UCM configuration.
For example on N900, all audio playback and capture is done through hw:0
with two channels (the pcm can't be opened in mono mode). In different
situations the channel map is different: sometimes only one channel of
the pcm is useful. Getting a list of channel maps from
snd_pcm_query_chmaps_from_hw() doesn't tell PulseAudio which channel map
is the right one, so this information needs to come from the UCM
configuration.

So, I was wrong when I said that the main reason for having the channel
map information in UCM is that the chmap API can only be used when the
pcm is open.

-- 
Tanu

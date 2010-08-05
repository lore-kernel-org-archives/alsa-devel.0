From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: HDMI audio: TV vs. codec supported sample rates
Date: Thu, 5 Aug 2010 13:57:18 +0300
Message-ID: <201008051357.18821.anssi.hannula@iki.fi>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FD6DF319@HQMAIL01.nvidia.com>
	<201008051249.07920.anssi.hannula@iki.fi>
	<s5hpqxxgwvk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from saarni.dnainternet.net (saarni.dnainternet.net [83.102.40.136])
	by alsa0.perex.cz (Postfix) with ESMTP id D6BD2103800
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 12:57:25 +0200 (CEST)
In-Reply-To: <s5hpqxxgwvk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai kirjoitti torstai, 5. elokuuta 2010 13:46:39:
> At Thu, 5 Aug 2010 12:49:07 +0300,
> 
> Anssi Hannula wrote:
> > Anssi Hannula kirjoitti tiistai, 3. elokuuta 2010 20:39:20:
> > > Stephen Warren kirjoitti tiistai, 3. elokuuta 2010 19:20:24:
> > > > I don't see anything in patch_intelhdmi.c that relates to sample rate
> > > > support at all. However, I see that patch_nvhdmi.c contains e.g.:
> > > > 
> > > > static struct hda_pcm_stream nvhdmi_pcm_digital_playback_8ch_89 = {
> > > > 
> > > >         .substreams = 1,
> > > >         .channels_min = 2,
> > > >         .rates = SUPPORTED_RATES,
> > > > 
> > > > Should .rates not be initialized here,
> > > 
> > > When .rates is not initialized, they are automatically read from the
> > > codec, i.e. exactly the values you referenced above from
> > > "/proc/asound/card1/codec#1".
> > > 
> > > The values seem to differ (32000 vs 22050 is reported as supported),
> > > though. If the codec reported values are wrong, the .rates should be
> > > kept. Otherwise the rates set in .rates should be fixed or the
> > > override just removed.
> > 
> > As AFAICS HDMI specification allows 32000Hz but not 22050Hz, I'd say it
> > is likely that the override is wrong and the codec reported rates are
> > right.
> > 
> > (my receiver doesn't support 32000Hz so I can't confirm).
> 
> So, the codec reports correct values based on EDID?

No. The codec reports all the values it supports, regardless if the attached 
HDMI sink supports them or not.

> IIRC, the static values there were needed for old Nvidia codecs that
> don't give the actual values.  Maybe newer chips work correctly.
> If so, rates, maxbps and formats in *_89 (also *_7x, too?) can be
> removed, indeed.
> 
> Can any confirm?

I have an older MCP7A codec as well and can confirm that it reports wrong 
values (only 48000/88200, while I can confirm in reality 192000 works with 
it). Though I guess the nonsensical 22050 should probably be 32000 (but I 
can't test since my receiver doesn't support 32000).

-- 
Anssi Hannula

From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: HDMI audio: TV vs. codec supported sample rates
Date: Thu, 5 Aug 2010 12:49:07 +0300
Message-ID: <201008051249.07920.anssi.hannula@iki.fi>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FD6DF319@HQMAIL01.nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF02FD6DF31B@HQMAIL01.nvidia.com>
	<201008032039.20715.anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from saarni.dnainternet.net (saarni.dnainternet.net [83.102.40.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 03CBD24527
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 11:49:13 +0200 (CEST)
In-Reply-To: <201008032039.20715.anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Anssi Hannula kirjoitti tiistai, 3. elokuuta 2010 20:39:20:
> Stephen Warren kirjoitti tiistai, 3. elokuuta 2010 19:20:24:
> > I don't see anything in patch_intelhdmi.c that relates to sample rate
> > support at all. However, I see that patch_nvhdmi.c contains e.g.:
> > 
> > static struct hda_pcm_stream nvhdmi_pcm_digital_playback_8ch_89 = {
> > 
> >         .substreams = 1,
> >         .channels_min = 2,
> >         .rates = SUPPORTED_RATES,
> > 
> > Should .rates not be initialized here,
> 
> When .rates is not initialized, they are automatically read from the codec,
> i.e. exactly the values you referenced above from
> "/proc/asound/card1/codec#1".
> 
> The values seem to differ (32000 vs 22050 is reported as supported),
> though. If the codec reported values are wrong, the .rates should be kept.
> Otherwise the rates set in .rates should be fixed or the override just
> removed.

As AFAICS HDMI specification allows 32000Hz but not 22050Hz, I'd say it is 
likely that the override is wrong and the codec reported rates are right.

(my receiver doesn't support 32000Hz so I can't confirm).

-- 
Anssi Hannula

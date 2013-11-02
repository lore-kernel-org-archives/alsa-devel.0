From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH] drm/radeon/audio: fix missing multichannel PCM SAD in
	some cases
Date: Sat, 2 Nov 2013 02:01:26 +0100
Message-ID: <CACna6ryJjHJwu7_=rHfff8f8=f3BFEDrDcKgx-kTEofoJDn3Fg@mail.gmail.com>
References: <526EE844.4030608@iki.fi>
	<1383002356-2479-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1383002356-2479-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces@lists.freedesktop.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Alex Deucher <alexander.deucher@amd.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

2013/10/29 Anssi Hannula <anssi.hannula@iki.fi>:
> Fix the code to pick the PCM SAD with the highest number of channels,
> while merging the rate masks of PCM SADs with lower amount of channels
> into the additional stereo rate mask byte.

Don't you think that we should use SUPPORTED_FREQUENCIES_STEREO for
stereo frequencies only?


>                                 if (sad->format == HDMI_AUDIO_CODING_TYPE_PCM)
> +                                       stereo_freqs |= sad->freq;

I mean making that (... && sad->channels == 1)

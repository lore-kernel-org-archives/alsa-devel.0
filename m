From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH] drm/radeon/audio: fix missing multichannel PCM SAD in
	some cases
Date: Sat, 2 Nov 2013 02:03:48 +0100
Message-ID: <CACna6ryPcbUKGX83LfTZ+=SOmROiVU07NgOc8=z4cnTdFx8Q6Q@mail.gmail.com>
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
> +                               if (sad->channels > max_channels) {
> +                                       value = MAX_CHANNELS(sad->channels) |
> +                                               DESCRIPTOR_BYTE_2(sad->byte2) |
> +                                               SUPPORTED_FREQUENCIES(sad->freq);
> +                                       max_channels = sad->channels;
> +                               }

Just for a record. I was wondering if fglrx sets both:
SUPPORTED_FREQUENCIES and SUPPORTED_FREQUENCIES_STEREO for receiver
with LPCM stereo only. It does:
00005f84 07070701 (117901057)
00005f88 00000000 (0)
00005f8c 00000000 (0)
00005f90 00000000 (0)
00005f94 00000000 (0)
00005f98 00000000 (0)
00005f9c 00000000 (0)
00005fa0 00000000 (0)
00005fa4 00000000 (0)
00005fa8 00000000 (0)
00005fac 00000000 (0)
00005fb0 00000000 (0)
00005fb4 00000000 (0)
00005fb8 00000000 (0)

So with the above code we'll be compatible with fglrx about that.
Nice. Just wanted to note that :)

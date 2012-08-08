From: Ian Minett <ian_minett@creativelabs.com>
Subject: Re: [PATCHv2 - CA0132 HDA Codec 1/2] ALSA: Update
 Creative CA0132 codec to add DSP features.
Date: Tue, 7 Aug 2012 17:27:59 -0700
Message-ID: <OFF64E9BBA.26E5B659-ON88257A53.0082F4D3-88257A54.0002903D@cli.creative.com>
References: <s5hipdoggbb.wl%tiwai@suse.de>	<1343239280-3503-1-git-send-email-ian_minett@creativelabs.com>
 <s5hsjcfrlor.wl%tiwai@suse.de>	<OF0CFC3DA9.A9100453-ON88257A48.006BF087-88257A48.006FCB42@cli.creative.com>
 <s5hlii4l96y.wl%tiwai@suse.de>	<OF301523C9.1A0D8E05-ON88257A4B.0074BC06-88257A4B.007D5630@cli.creative.com>
 <s5hsjc8ezc3.wl%tiwai@suse.de>	<OF26B70F85.68DA70BC-ON88257A4D.000B1C43-88257A4D.000E7965@cli.creative.com>
 <s5hvch3b1t9.wl%tiwai@suse.de>	<OF01097BF9.024F0E41-ON88257A50.00122DF1-88257A50.001333B2@cli.creative.com>
 <s5hfw83jesw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-outbound2.cli.creative.com
 (smtp-outbound2.cli.creative.com [124.246.64.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CC83265247
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2012 01:58:30 +0200 (CEST)
In-Reply-To: <s5hfw83jesw.wl%tiwai@suse.de>
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






>Looks good, but I think start and stop can be a single trigger like
>PCM op, something like:
>
>  int (*load_dsp_trigger)(struct hda_bus *bus, bool start);
>
>The second argument could be a generic int like PCM op, but I don't
>think we'd need pause or suspend/resume command for DSP loader :)

Hi Takashi,

The proposed method for handling the DSP load process looks fine to
us, and we can make a start on adding this to the CA0132 driver now.

We can update patch_ca0132.c, but would you be able to assist us with
the modifications to the hda_intel.c side at all? We think it might
result in a smoother process (and involving fewer submissions :) )
given your familiarity with the low-level architecture in that area.

If not, we'd appreciate any info or pointers you can provide on how
and where the necessary modifications need to be made to hda_intel.c.

Thanks again for all your help with this.
Ian

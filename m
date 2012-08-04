From: Ian Minett <ian_minett@creativelabs.com>
Subject: Re: [PATCHv2 - CA0132 HDA Codec 1/2] ALSA: Update
 Creative CA0132 codec to add DSP features.
Date: Fri, 3 Aug 2012 20:29:44 -0700
Message-ID: <OF01097BF9.024F0E41-ON88257A50.00122DF1-88257A50.001333B2@cli.creative.com>
References: <s5hipdoggbb.wl%tiwai@suse.de>
 <1343239280-3503-1-git-send-email-ian_minett@creativelabs.com>
 <s5hsjcfrlor.wl%tiwai@suse.de>
 <OF0CFC3DA9.A9100453-ON88257A48.006BF087-88257A48.006FCB42@cli.creative.com>
 <s5hlii4l96y.wl%tiwai@suse.de>
 <OF301523C9.1A0D8E05-ON88257A4B.0074BC06-88257A4B.007D5630@cli.creative.com>
 <s5hsjc8ezc3.wl%tiwai@suse.de>
 <OF26B70F85.68DA70BC-ON88257A4D.000B1C43-88257A4D.000E7965@cli.creative.com>
 <s5hvch3b1t9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-outbound2.cli.creative.com
 (smtp-outbound2.cli.creative.com [124.246.64.232])
 by alsa0.perex.cz (Postfix) with ESMTP id B538826527D
 for <alsa-devel@alsa-project.org>; Sat,  4 Aug 2012 05:29:51 +0200 (CEST)
In-Reply-To: <s5hvch3b1t9.wl%tiwai@suse.de>
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






>So, the data transfer here is just like the normal PCM streaming?
>For example, if you have an op like
>
>            int (*load_dsp)(struct hda_bus *bus, void *buffer, int size);
>
>and calling this for each segment would work?
>(In addition, we'd need to give some way to determine the stop
> condition in the codec side.)
>

Hi,

Yes - this approach would work. We would also need to set the data
format, and control the stop condition.

For example, by adding the following ops to handle the dsp
download process:

/* format is 16-bit Stream Format Structure as defined in HDA spec.
   pcm_prepare() callback in the codec will be called so that codec driver
   can obtain the stream tag and format to set up the codec.
 */
int (*load_dsp_prepare) \
      (struct hda_bus *bus, unsigned short format, void *buffer, int size);

/* start the transfer. */
int (*load_dsp_start)(struct hda_bus *bus);

/* stop the transfer and flush the FIFO. */
int (*load_dsp_stop)(struct hda_bus *bus);


Thanks,
Ian

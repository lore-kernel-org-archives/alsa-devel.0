From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: core - Add direct mapping
 between DAIs and DAPM
Date: Thu, 16 Feb 2012 13:35:58 +0000
Message-ID: <1329399358.28852.19.camel@odin>
References: <1329321775-21082-1-git-send-email-lrg@ti.com>
	<20120215162412.GG2996@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
	[74.125.149.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 05461103978
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 14:36:03 +0100 (CET)
Received: by wibhq7 with SMTP id hq7so1429732wib.20
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 05:36:00 -0800 (PST)
In-Reply-To: <20120215162412.GG2996@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-15 at 08:24 -0800, Mark Brown wrote:
> On Wed, Feb 15, 2012 at 04:02:54PM +0000, Liam Girdwood wrote:
> > Currently we map DAI streams to DAPM widgets based on a string stream name.
> > This can lead to some limitations when working with lots of DAI links as there
> > is a risk of naming collision with similar stream names.
> 
> > This patch creates a 1:N mapping between a DAI and it's DAPM widgets. It's
> > still string based, but we now directly reference the widget names with
> > the DAI and bind the DAI to the widget ptrs at initialisation. The binding
> > also tales into consideration the parent codec or platform that the DAI and
> > widget belong to so that we can easily support multiple components with
> > the same widget names.
> 
> > This patch still works in conjunction with the stream based events, but it
> > is intended to eventually replace the DAI stream name.
> 
> I was thinking about something close to this myself as part of the
> CODEC<->CODEC automatic DAPM stuff I keep mentioning.  In order to make
> that work what I was going to do was instead of mapping the widgets
> directly onto the DAI was to add a DAPM widget that represented the
> stream and link the DAI to that, probably created automatically from the
> DAI definition.  We'd then have the DAIs sitting in the DAPM graph and
> it gets much simpler to just connect the playback DAI on one device to
> the capture device on another (and vice versa).
> 
> In terms of the API and end result it's pretty similar to what you've
> got here except it'd probably end up with the DAI<->widget links
> specified through the DAPM map.  What do you think?  I'd rather not
> churn the API more often than we have to.

I'm easy enough, but I'm not sure how we could map specific PCM channels
via the DAPM graph. e.g. we could connect the L and R DAC widgets to the
DAI widget but how would we associate the L DAC widget with PCM channel
0 etc. 

I do have a subsequent patch that does this based on the mapping atm :-

@@ -1405,6 +1405,17 @@ static int soc_init_card_dai_widgets(struct snd_soc_card *card)
 				return ret;
 		}
 
+		/* create unique channels masks for each DAI in the sound card */
+		dai->playback_channel_map =
+			((1 << dai->driver->playback.channels_max) - 1)
+			<< card->num_playback_channels;
+		card->num_playback_channels += dai->driver->playback.channels_max;
+
+		dai->capture_channel_map =
+			((1 << dai->driver->capture.channels_max) - 1)
+			<< card->num_capture_channels;
+		card->num_capture_channels += dai->driver->capture.channels_max;
+
 		dai->dapm_bind_complete = 1;
 	}
 

To give us a unique channel ID for each PCM channel propagating through
each widget (since I can map PCM channels atm).

I did connect the DAIs together in the mach driver via DAPM, but I agree
it would be nicer connect the DAI widgets together here rather than
DACs, etc.

The dynamic PCM patch is also blocking on having some sort of DAI ->
widget mapping so we would need something upstream soonish.

I'll take a quick look and see if I can modify this and try and include
a DAI widget too whilst retaining the channel mapping before you have
breakfast.

Liam

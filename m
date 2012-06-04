From: Sebastien LEDUC <sebastien.leduc@stericsson.com>
Subject: Re: Confusing about Playback/Capture, CODEC/CODEC links,
 and snd_soc_dapm_link_dai_widgets()
Date: Mon, 4 Jun 2012 15:02:15 +0200
Message-ID: <A3217089E06965468FCEC60ADC3A8F925C172270E5@EXDCVYMBSTM006.EQ1STM.local>
References: <4FC7F576.30101@wwwdotorg.org>
	<20120531233702.GA30717@opensource.wolfsonmicro.com>
	<1338570117.5179.2.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog114.obsmtp.com (eu1sys200aog114.obsmtp.com
	[207.126.144.137])
	by alsa0.perex.cz (Postfix) with ESMTP id F03242495F
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 15:02:23 +0200 (CEST)
In-Reply-To: <1338570117.5179.2.camel@odin>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

Hi Liam
There seem to be a similar mistake in the implementation of is_connected_output_ep / is_connected_input_ep:

In function is_connected_output_ep:
-----------------------------------------------

 list_for_each_entry(path, &widget->sinks, list_source) {
                ...
                err = dapm_list_add_widget(list, path->sink);
                ...
}

In function is_connected_input_ep:
---------------------------------------------

list_for_each_entry(path, &widget->sources, list_sink) {
...
                err = dapm_list_add_widget(list, path->sink);
}


I would have expected to have for the latter:
err = dapm_list_add_widget(list, path->source);

regards
Sebastien

-----Original Message-----
From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Liam Girdwood
Sent: Friday, June 01, 2012 7:02 PM
To: Mark Brown
Cc: alsa-devel@alsa-project.org; Stephen Warren
Subject: Re: [alsa-devel] Confusing about Playback/Capture, CODEC/CODEC links, and snd_soc_dapm_link_dai_widgets()

On Fri, 2012-06-01 at 00:37 +0100, Mark Brown wrote:
> On Thu, May 31, 2012 at 04:49:26PM -0600, Stephen Warren wrote:

> 
> This is all working just fine in mainline on littlemill.
> 
> > > int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
> > > 	struct snd_soc_dapm_widget_list **list)
> > ...
> > > 	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> > > 		paths = is_connected_output_ep(dai->playback_widget, list);
> > > 	else
> > > 		paths = is_connected_input_ep(dai->playback_widget, list);
> 
> > I would have expected this to use capture_widget on the final line, but
> > I haven't thought about this in detail, just noticed the lack of
> > symmetry by very brief inspection.
> 
> Yes, that looks buggy.  Don't think there's any mainline users so nobody
> would notice.

Gah, it's a bug - I did have it fixed before the upstreaming but this
fix seems to have been lost.

Patch on it's way.

Liam

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

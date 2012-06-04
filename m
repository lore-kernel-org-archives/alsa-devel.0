From: Liam Girdwood <lrg@ti.com>
Subject: Re: Confusing about Playback/Capture, CODEC/CODEC links,
 and snd_soc_dapm_link_dai_widgets()
Date: Mon, 04 Jun 2012 17:57:19 +0100
Message-ID: <1338829039.15595.5.camel@odin>
References: <4FC7F576.30101@wwwdotorg.org>
	<20120531233702.GA30717@opensource.wolfsonmicro.com>
	<1338570117.5179.2.camel@odin>
	<A3217089E06965468FCEC60ADC3A8F925C172270E5@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog108.obsmtp.com (na3sys009aog108.obsmtp.com
	[74.125.149.199])
	by alsa0.perex.cz (Postfix) with ESMTP id E993E2443C
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 18:57:25 +0200 (CEST)
Received: by werh12 with SMTP id h12so2949565wer.38
	for <alsa-devel@alsa-project.org>; Mon, 04 Jun 2012 09:57:22 -0700 (PDT)
In-Reply-To: <A3217089E06965468FCEC60ADC3A8F925C172270E5@EXDCVYMBSTM006.EQ1STM.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sebastien LEDUC <sebastien.leduc@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-06-04 at 15:02 +0200, Sebastien LEDUC wrote:
> Hi Liam
> There seem to be a similar mistake in the implementation of is_connected_output_ep / is_connected_input_ep:
> 
> In function is_connected_output_ep:
> -----------------------------------------------
> 
>  list_for_each_entry(path, &widget->sinks, list_source) {
>                 ...
>                 err = dapm_list_add_widget(list, path->sink);
>                 ...
> }
> 
> In function is_connected_input_ep:
> ---------------------------------------------
> 
> list_for_each_entry(path, &widget->sources, list_sink) {
> ...
>                 err = dapm_list_add_widget(list, path->sink);
> }
> 
> 
> I would have expected to have for the latter:
> err = dapm_list_add_widget(list, path->source);

Your right, this patch also got somehow dropped from squashing prior to
upstream. I'll send the fix shortly.

Thanks

Liam

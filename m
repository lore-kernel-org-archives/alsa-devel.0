From: Liam Girdwood <lrg@ti.com>
Subject: Re: Confusing about Playback/Capture, CODEC/CODEC links,
 and snd_soc_dapm_link_dai_widgets()
Date: Fri, 01 Jun 2012 18:01:57 +0100
Message-ID: <1338570117.5179.2.camel@odin>
References: <4FC7F576.30101@wwwdotorg.org>
	<20120531233702.GA30717@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog137.obsmtp.com (na3sys009aog137.obsmtp.com
	[74.125.149.18])
	by alsa0.perex.cz (Postfix) with ESMTP id 83B86104555
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2012 19:02:04 +0200 (CEST)
Received: by wibhr14 with SMTP id hr14so639081wib.2
	for <alsa-devel@alsa-project.org>; Fri, 01 Jun 2012 10:01:59 -0700 (PDT)
In-Reply-To: <20120531233702.GA30717@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

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

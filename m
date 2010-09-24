From: "Ambrose, Martin" <martin@ti.com>
Subject: Re: [PATCH V1 09/11] ASoC: DaVinci: i2s,
 add davinci_i2s_prepare and shutdown
Date: Fri, 24 Sep 2010 14:43:30 -0500
Message-ID: <A24693684029E5489D1D202277BE89447289CF40@dlee02.ent.ti.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>
	<A24693684029E5489D1D202277BE89447289CD0A@dlee02.ent.ti.com>
	<4C9CF898.7070906@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id D830510381E
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Sep 2010 21:43:33 +0200 (CEST)
In-Reply-To: <4C9CF898.7070906@boundarydevices.com>
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
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 24, 2010 at 14:14:32, Troy Kisky wrote:

> On 9/24/2010 9:48 AM, Ambrose, Martin wrote:
> > On Sat, Jul 04, 2009 at 21:29:59, Troy Kisky wrote:
> > 
> >> If the codec is master then prepare should call
> >> mcbsp_start, not trigger.
> > 
> > For me this change induces audio artifacts when starting or stopping a gstreamer pipeline.
> > Take, e.g., the pipeline
> > 	gst-launch -v filesrc location=file.mp3 ! mad ! alsasink
> > 
> > In the setup, before the file is opened, gstreamer places the pipeline into the PAUSE state.
> > 	... posting state-changed READY to PAUSED
> > 
> > This results in a call to the davinci_i2s_prepare function which, when the codec is master,
> > stops then starts the mcbsp driver. However at this point in the pipeline no valid data has
> > been provided to the DMA layer (davinci-pcm). Consequently there is random noise of somewhat
> > random length played out the DAC at the start of file playback. Moreover when the stream changes
> > from the PAUSE to the PLAYING state another mcbsp_stop/mcbsp_start sequence is performed which
> > seems inefficient. Similar behavior, and noise, occurs when the pipeline is shutdown.
> > 
> > The aplay utility has a simpler startup/shutdown procedure which doesn't produce any noise.
> > 
> > There doesn't seem to be any state context, e.g. pause vs start, provided to the prepare
> > function so I can't see how to handle such cases in the current driver while preserving
> > the use of this patch. If I revert this patch then I don't get any noise but I don't 
> > know what the consequences are. 
> > 
> > Comments/suggestions welcome.
> > 
> 
> I don't see the problem because my codec waits until trigger to activate its interface.

Thanks for the feedback. I'm using the tlv320aic3x codec driver. Which codec are you using?

> So the question is, who should be responsible for the final turn on?
> 
> My thought was that the device (master) which starts the external wires to wiggling should be last.

Fair enough. I suppose that is the reasoning for the addition of the prepare function.
The assumption being that a cpu_dai callback to the prepare function will always proceed
a call to the codec_dai trigger function. In this way the serial port can be configured and enabled.
Then the codec can turn on the bit/frame clocks which will start the flow of data. 
Although it would seem the codec is unmuted a bit prematurely in this scenario since it happens
before the clocks are enabled in the core prepare function -- at least I think this is the case.

However there would still seem to be spurious, or at least superfluous, calls
to mcbsp_stop/start when just requesting the device to enter the pause state.

I guess the call tree is then different in the case where the cpu, or machine, is the 
clock master. This has pros/cons obviously.

> If the codec is master, and starts the clocks before the mcbsp is ready that could also cause a pop
> or noise.

I still a newbie when it comes to the ALSA architecture.
Is the proper signal indicating everything is ready, including valid data, a trigger call with cmd=START?

> It would be nice if such rules could be documented, are they???

Not that I know of. 

Regards,
Martin

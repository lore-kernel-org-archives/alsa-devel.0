From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH V1 09/11] ASoC: DaVinci: i2s,
 add davinci_i2s_prepare and shutdown
Date: Fri, 24 Sep 2010 12:14:32 -0700
Message-ID: <4C9CF898.7070906@boundarydevices.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>
	<A24693684029E5489D1D202277BE89447289CD0A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cpoproxy3-pub.bluehost.com (cpoproxy3-pub.bluehost.com
	[67.222.54.6]) by alsa0.perex.cz (Postfix) with SMTP id BC454245E1
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Sep 2010 21:14:39 +0200 (CEST)
In-Reply-To: <A24693684029E5489D1D202277BE89447289CD0A@dlee02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ambrose, Martin" <martin@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 9/24/2010 9:48 AM, Ambrose, Martin wrote:
> On Sat, Jul 04, 2009 at 21:29:59, Troy Kisky wrote:
> 
>> If the codec is master then prepare should call
>> mcbsp_start, not trigger.
> 
> For me this change induces audio artifacts when starting or stopping a gstreamer pipeline.
> Take, e.g., the pipeline
> 	gst-launch -v filesrc location=file.mp3 ! mad ! alsasink
> 
> In the setup, before the file is opened, gstreamer places the pipeline into the PAUSE state.
> 	... posting state-changed READY to PAUSED
> 
> This results in a call to the davinci_i2s_prepare function which, when the codec is master,
> stops then starts the mcbsp driver. However at this point in the pipeline no valid data has
> been provided to the DMA layer (davinci-pcm). Consequently there is random noise of somewhat
> random length played out the DAC at the start of file playback. Moreover when the stream changes
> from the PAUSE to the PLAYING state another mcbsp_stop/mcbsp_start sequence is performed which
> seems inefficient. Similar behavior, and noise, occurs when the pipeline is shutdown.
> 
> The aplay utility has a simpler startup/shutdown procedure which doesn't produce any noise.
> 
> There doesn't seem to be any state context, e.g. pause vs start, provided to the prepare
> function so I can't see how to handle such cases in the current driver while preserving
> the use of this patch. If I revert this patch then I don't get any noise but I don't 
> know what the consequences are. 
> 
> Comments/suggestions welcome.
> 

I don't see the problem because my codec waits until trigger to activate its interface.

So the question is, who should be responsible for the final turn on?

My thought was that the device (master) which starts the external wires to wiggling should be last.

If the codec is master, and starts the clocks before the mcbsp is ready that could also cause a pop
or noise.


It would be nice if such rules could be documented, are they???

Thanks
Troy

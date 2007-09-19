From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Routing multiple signals to one output with
	ice1712 (Delta 66)
Date: Wed, 19 Sep 2007 10:43:59 +0100
Message-ID: <200709191043.59764.gineera@aspect135.co.uk>
References: <46F0DFEC.802@dreamlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 60F1D245AA
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 11:31:09 +0200 (CEST)
In-Reply-To: <46F0DFEC.802@dreamlab.net>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mathis Hofer <mathis.hofer@dreamlab.net>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 19 September 2007 09:38, Mathis Hofer wrote:
> Hi folks
>
> I want to setup the following audio routing:
> pcm + input1 (mic) + input2 (mic) -> output1
> pcm + input1 (mic) + input2 (mic) -> output2
> ...with pcm being the audio playback and input1&2 being two microphones.
>
> With envy24control it is possible to select one signal for each output,
> but not multiple signals. Is this a restriction of envy24control, the
> alsa driver or is it simply not supported by the hardware?

What you are talking about is really mixing the streams in addition to 
routing.  Envy24control basically gives you all the hardware options of the 
chip.  The ice1712 (=envy24 chip) includes a hardware mixer which can be 
routed to HWOut1 and HWOut2 using envy24control, but not to other outputs.  
This will allow any inputs and any PCM streams to be mixed.  Note that these 
mixer settings can be controlled from an external MIDI control surface also!

I am sure there are also software options.

Alan

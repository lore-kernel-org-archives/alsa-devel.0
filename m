From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Mic/Line-in record is not working with wm9713 AC97
Date: Wed, 14 Oct 2009 11:26:50 +0100
Message-ID: <20091014102649.GB24540@sirena.org.uk>
References: <8aea34270910140309o2a4ad31cpe33904244d3b103d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A70521038FC
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Oct 2009 12:26:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8aea34270910140309o2a4ad31cpe33904244d3b103d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sreekanth W <w.sreekanth@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 14, 2009 at 03:39:23PM +0530, Sreekanth W wrote:

> I am trying to record a wav file using mic/line-in with wm9713 driver.
> The Wav file is created, only header is created but almost there is no
> data. This is seen using CoolEdit/Vim editor.

Could you clarify what you mean when you say "almost there is no data"?

> Mic Bias: Off

> Any idea why record is  not working? Anything wrong with these settings?

>From what you've said it sounds like you're succesfully recording data
but the ADC is not seeing a signal to record so you're getting a small
amount of noise on the output but that's it.  Unless your microphone
bias comes from some other source the fact that the Mic Bias on the
WM9713 is off will be an issue here - you need to set up DAPM routes to
connect that to your microphone widget, see Zylonite for one example.
Otherwise check the gains and mutes on the microphone->ADC path to make
sure that the signal is being amplified sufficiently.

It might be helpful to set up a bypass path from the input stages so
you can hear the output directly while adjusting the controls rather
than doing records.

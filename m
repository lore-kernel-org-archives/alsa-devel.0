From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [topic/asoc][RFC 0/1] ASoC: OMAP: Add support for
 mono link configuration to McBSP DAI
Date: Tue, 25 Nov 2008 09:29:46 +0200
Message-ID: <20081125092946.f7c6fe62.jarkko.nikula@nokia.com>
References: <1227532164-2612-1-git-send-email-jarkko.nikula@nokia.com>
	<20081124132850.GA22394@sirena.org.uk>
	<20081124154533.4a722b03.jarkko.nikula@nokia.com>
	<20081124143304.GG22394@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 692A024416
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 08:30:26 +0100 (CET)
In-Reply-To: <20081124143304.GG22394@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Nov 2008 14:33:04 +0000
"ext Mark Brown" <broonie@sirena.org.uk> wrote:

> On Mon, Nov 24, 2008 at 03:45:33PM +0200, Jarkko Nikula wrote:
> > My problem was this kind of switching correct to do in machine driver?
> 
> > 	cpu_dai->playback.channels_min = 1;
> > 	cpu_dai->playback.channels_max = 1;
> > 	cpu_dai->capture.channels_min = 1;
> > 	cpu_dai->capture.channels_max = 1;
> 
> No, these should be constant.  Any dynamic constraints should be applied
> with the constraints API.
> 
Oh my, now feeling like not done my homework. Thanks Mark and sorry
about the line noise :-)

Will send soon patchset adding snd_pcm_hw_constraint_minmax(...,
SNDRV_PCM_HW_PARAM_CHANNELS to existing OMAP machine drivers + updated
version of this patch.

> So, this is a bit messy at the moment since we don't really have any
> DAPM-style routing on the digital side yet.  What most of these codecs
> should probably be doing is declaring a 2 channel minimuim - normally
> that's what they require as a wire format even if they only actually use
> the data from one of those channels.
> 
I think it's not worth to change existing codecs now. Keeping 1 channel
minimum on codec side allow fascinating hackish DAI configurations like
using only one channel from stereo codec or to operate with some
intelligent CPU DAI able to do mono->stereo and stereo->mono mixing
internally. Yet another line noise from me...


Jarkko

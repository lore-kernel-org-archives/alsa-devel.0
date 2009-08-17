From: Shine Liu <shinel@foxmail.com>
Subject: Re: [PATCH] ASoC: UDA134X Codec: Fix mute/unmute code
 mistake and add ADC/DAC power control support
Date: Mon, 17 Aug 2009 19:22:34 +0800
Message-ID: <1250508154.1932.37.camel@shinel>
References: <1250498216.2764.1.camel@shinel>
	<20090817103248.GA4464@sirena.org.uk>
Reply-To: shinel@foxmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg76.qq.com (smtpbg76.qq.com [119.147.10.235])
	by alsa0.perex.cz (Postfix) with SMTP id 2FA5A10382A
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 13:23:05 +0200 (CEST)
In-Reply-To: <20090817103248.GA4464@sirena.org.uk>
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

On Mon, 2009-08-17 at 11:32 +0100, Mark Brown wrote:
> On Mon, Aug 17, 2009 at 04:36:56PM +0800, Shine Liu wrote:
> > There is a mistake in current uda134x_mute function: mute_reg has been
> > changed in line 162 or line 164, so uda134x_write should write
> > "mute_reg" but not "mute_reg & ~(1<<2)" to 
> > UDA134X_DATA010.
> 
> This is OK but please split it out into a separate patch and resend
> since...
> 
> > Besides, because there is no DAPM configuration for uda134x, when system
> > starts up, snd_soc_int_card calls snd_soc_dapm_new_widgets, and
> > snd_soc_dapm_new_widgets calls dapm_power_widgets. In function
> > dapm_power_widgets, codec->dapm_widgets has no list entry, so sys_power
> > retains it's original value zero. Then
> 
> ...this isn't, partly because I can't really follow what you're trying
> to do here.  It looks awfully like you're trying to implement DAPM
> support - certainly things like adding the switches for DAC and ADC
> power shouldn't be there, they should be automatically managed in the
> drivers.
> 

When I play a wav file using aplay, I found there's no sound. After some
debug work, I noticed that the DAC power control bit keeps zero since
the system started up.

DAC power control bit should be set when the codec is about to excute a
playback task. But current code doesn't set this bit on before playback.
So I do the work in the codec's trigger operation.

So is the wave recording. There's no code to set the ADC power control
bit on when to record.

Yes, it's true that we should not expose the power control to the end
user. So I should the remove the two lines in the last patch.

From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 6/6] ASoC: TWL4030: Add analog loopback
	support
Date: Tue, 27 Jan 2009 11:37:38 +0000
Message-ID: <20090127113737.GA1794@sirena.org.uk>
References: <1233048584-29662-1-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-2-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-3-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-4-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-5-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-6-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-7-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A2B931037EC
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 12:37:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1233048584-29662-7-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 27, 2009 at 11:29:44AM +0200, Peter Ujfalusi wrote:

> It seams that the analog loopback needs the DAC powered on on the channel,
> where the loopback is selected. The switch for the DACs has been moved from

Oh, well...

> After the loopback registers are changed, the event callback will update the
> bypass bitfield, so we will know if any of the bypass paths are
> enabled. If the codec is in STANDBY mode, the decision is made to keep/switch
> the codec off or keep/switch the codec on to allow the bypass.
> Also after the codec switches from ON to STANDBY the same check will be done.

The original implementation was done that way due to the lack of DAPM -
it did *all* power management in the bias configuration.  Now that you
have DAPM support it should be possible for the driver to function more
normally and avoid these checks.  What most drivers do is bring all the
chip wide power up when coming into standby then power on the rest under
DAPM.

Support for turning the codec completely off should really be provided
by the core as an optional thing that can be done when the subsystem has
been idle for a while using the regular bias level stuff like the
existing delay before falling back to standby.  It needs to be optional
since won't be appropriate for all applications since bringing the bias
levels up cleanly may take too long for some systems.

A few more specific issues in the rest of the code below.  I've also got
a patch I'm going to push to Takashi later today which conflicts with
this one, see the for-2.6.30 branch of:

	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

>  static void twl4030_codec_enable(struct snd_soc_codec *codec, int enable)
>  {
> +       struct twl4030_priv *twl4030 =
> +               (struct twl4030_priv *)codec->private_data;

Casts away from void aren't needed, there's quite a few of those here
and in the rest of the patch code.  Please fix these - they're usually a
sign that something is wrong if they're needed.

>         codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
>         if (codec == NULL)
>                 return -ENOMEM;
> 
> +       twl4030 = kzalloc(sizeof(struct twl4030_priv), GFP_KERNEL);
> +       if (twl4030 == NULL) {

Not essential but you could collapse these into a single allocation.

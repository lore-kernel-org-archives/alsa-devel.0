From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: hda/jack - Also add jack kctls for
 Conexant codecs
Date: Thu, 22 Dec 2011 12:21:55 +0000
Message-ID: <20111222122155.GN4546@opensource.wolfsonmicro.com>
References: <1324390985-3496-1-git-send-email-david.henningsson@canonical.com>
	<s5hvcpbgvpm.wl%tiwai@suse.de>
	<20111220235813.GA13529@sirena.org.uk>
	<s5hr4zydm0m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D32B103D57
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 13:21:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hr4zydm0m.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 21, 2011 at 03:42:17PM +0100, Takashi Iwai wrote:

> Well, the kctl-jack part itself can't break anything right now since
> it's used only in HD-audio.  If others will use, this will be a pure
> addition, so it won't break except for possibly different ctl numids.

A pure addition can still cause problems as we roll out the same
interface into other drivers, for example if there's assumptions that
aren't generally true.

> +void snd_kctl_jack_report(struct snd_card *card,
> +			  struct snd_kcontrol *kctl, bool status)
> +{
> +	if (kctl->private_value == status)
> +		return;
> +	kctl->private_value = status;
> +	snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE, &kctl->id);
> +}
> +EXPORT_SYMBOL_GPL(snd_kctl_jack_report);

So, this looks good in so far as it goes but obviously there's no
semantics being defined here for the controls or their names.  That's
more the bit that worries me as we'll get applications starting to use
the new interface and they should have something consistent to work
with.

I'm guessing that as this is just a simple boolean each jack will have a
series of controls like "Headset Jack Headphone" and "Headset Jack
Microphone" or whatever and userspace should match them all together in
the same way that it does for Volume and Switch controls?  That sounds
like it'll work well, we just need to define some strings for standard
jacks and conections.

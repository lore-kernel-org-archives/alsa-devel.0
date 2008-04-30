From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] soc - neo1973_wm8753.c cleanup
	checkpatch issues
Date: Wed, 30 Apr 2008 16:47:27 +0100
Message-ID: <20080430154726.GB28593@sirena.org.uk>
References: <1209565146-32393-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hskx3uzg7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B76232469F
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Apr 2008 17:47:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hskx3uzg7.wl%tiwai@suse.de>
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
Cc: Graeme Gregory <graeme@openmoko.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 30, 2008 at 05:36:40PM +0200, Takashi Iwai wrote:

> Applied all 4 patches now.

Thanks.

> I think we can push checkpatch clean-up patches to 2.6.26 if
> possible.  In addition, neo1973_wm8753.c suspend/resume/shutdown hooks
> look OK for 2.6.26.

Yes, and in fact this is a bug fix - without this code the device burns
an excessive amount of power while suspended.

> I'll keep Daniel's clock-setup change and GPIO support patches as
> post-2.6.26.

I agree.

> The addition of snd_soc_dapm_get_endpoint_status() appears to be a
> post-2.6.26, too, as there is no user yet on 2.6.26.

Yes, there's no user - the GTA02 is the only existing user and it can't
be merged since the underlying machine support is not integrated yet.
On the other hand, since there are no users it's very low risk :)
Either way is fine by me, anyway.

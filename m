From: Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] hda_codec: restore control element values
 during resume
Date: Wed, 02 May 2007 11:57:00 -0400
Message-ID: <4638B4CC.4060606@gentoo.org>
References: <20070429161421.863777B409F@zog.reactivated.net>
	<s5htzuvbkww.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp121.iad.emailsrvr.com (smtp121.iad.emailsrvr.com
	[207.97.245.121])
	by alsa0.perex.cz (Postfix) with ESMTP id B766224443
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2007 17:57:45 +0200 (CEST)
In-Reply-To: <s5htzuvbkww.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> The controls should have been restored by snd_hda_resume_ctls() call
> in stac92xx_resume(), so basically your patch must be suprefluous.
> Could you check whether this gets called?

I did see the snd_hda_resume_ctls() code but noted it was resuming from 
snd_kcontrol_new structures rather than snd_kcontrol instances. I'm 
still not sure what the difference is here, are they supposed to 
'mirror' each other?

Anyway, it turns out that snd_hda_resume_ctls() doesn't get executed.

stac92xx_resume() has this code:

	for (i = 0; i < spec->num_mixers; i++)
		snd_hda_resume_ctls(codec, spec->mixers[i]);

On my system, spec->num_mixers is 0.

Daniel

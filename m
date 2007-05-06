From: Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] hda_codec: restore control element values
 during resume
Date: Sat, 05 May 2007 20:09:22 -0400
Message-ID: <463D1CB2.5090206@gentoo.org>
References: <20070429161421.863777B409F@zog.reactivated.net>	<s5htzuvbkww.wl%tiwai@suse.de>	<4638B4CC.4060606@gentoo.org>
	<s5h647aw5tf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp161.iad.emailsrvr.com (smtp161.iad.emailsrvr.com
	[207.97.245.161])
	by alsa0.perex.cz (Postfix) with ESMTP id EB195243FD
	for <alsa-devel@alsa-project.org>;
	Sun,  6 May 2007 02:10:12 +0200 (CEST)
In-Reply-To: <s5h647aw5tf.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> OK, it's a simple error.  The resume callback should call
> snd_hda_resume_ctls() with spec->mixer argument.  The other codec
> codes store this also onto spec->mixers[] array, so I overlooked.

Thanks, this works splendidly.

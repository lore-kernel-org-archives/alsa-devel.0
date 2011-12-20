From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/5] ALSA: snd-usb: implement new endpoint
 streaming model
Date: Tue, 20 Dec 2011 16:32:05 +0100
Message-ID: <4EF0AA75.10404@ladisch.de>
References: <1324374520-32332-1-git-send-email-zonque@gmail.com>	<1324374520-32332-3-git-send-email-zonque@gmail.com>
	<s5hmxangu0r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 176F5103B5F
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 16:32:29 +0100 (CET)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 87AA221490
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 10:32:27 -0500 (EST)
In-Reply-To: <s5hmxangu0r.wl%tiwai@suse.de>
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
Cc: linuxaudio@showlabor.de, blablack@gmail.com, alsa-devel@alsa-project.org, gdiffey@gmail.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> One point I'm not sure about this implementation is the use of
> tasklet.  The tasklet itself runs again in ep->lock, what's the
> rationale for it?  In other words, can't it be a straight function
> call?

This architecture was copied from ua101.c.  If I remember correctly,
the original reason for the tasklet was to avoid calling
snd_pcm_period_elapsed() from inside the lock.  This would not be
necessary in endpoint.c.


Regards,
Clemens

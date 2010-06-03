From: VDR User <user.vdr@gmail.com>
Subject: Re: [PATCH] alsa-lib: snd_pcm_delay and friends do not
	account for a write being currently in progress
Date: Thu, 3 Jun 2010 10:40:02 -0700
Message-ID: <AANLkTil3VZiQe5wSezaDRXtekheR6d_hs7wKK6Ku7puX@mail.gmail.com>
References: <1275514176.8032.42.camel@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 602CD10382A
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 19:40:05 +0200 (CEST)
Received: by vws8 with SMTP id 8so423133vws.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Jun 2010 10:40:03 -0700 (PDT)
In-Reply-To: <1275514176.8032.42.camel@satellite>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Lindgren <john.lindgren@tds.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 2, 2010 at 2:29 PM, John Lindgren <john.lindgren@tds.net> wrote:
> In a multi-threaded application it is possible for snd_pcm_delay or an
> equivalent function to be called by one thread while another is sitting
> in snd_pcm_writei. =A0In this case, snd_pcm_delay does not take into
> account that there may not be enough space for all the data passed to
> snd_pcm_writei to be written to the ring buffer at once, and will return
> incorrect values.

Hi.  I've been getting "pcm_hw.c: snd_pcm_hw_delay()
SNDRV_PCM_IOCTL_DELAY failed." in my xine log and after some talks
with one of the devs, he suggested that alsa was not getting data fast
enough in some cases (iirc).  Could you please email me a copy of your
patch (so I don't have to hand-patch) to try?  Hopefully it will fix
this damn problem once and for all.

Thanks,
Derek

From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ALSA: pcm_lib: avoid timing jitter in
	snd_pcm_read/write()
Date: Sun, 27 Jun 2010 12:29:46 +0900
Message-ID: <AANLkTil91moJgRh51QFgvSFd47MzQxzxty1H2RzKK5nF@mail.gmail.com>
References: <1277590400.2438.15.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6FB5C246CC
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 05:29:48 +0200 (CEST)
Received: by vws11 with SMTP id 11so2061037vws.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Jun 2010 20:29:46 -0700 (PDT)
In-Reply-To: <1277590400.2438.15.camel@obelisk.thedillows.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Dillow <dave@thedillows.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux@schou.dk
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 27, 2010 at 7:13 AM, David Dillow <dave@thedillows.org> wrote:
> When using poll() to wait for the next period -- or avail_min samples --
> one gets a consistent delay for each system call that is usually just a
> little short of the selected period time. However, When using
> snd_pcm_read/write(), one gets a jittery delay that alternates between
> less than a millisecond and approximately two period times. This is
> caused by snd_pcm_lib_{read,write}1() transferring any available samples
> to the user's buffer and adjusting the application pointer prior to
> sleeping to the end of the current period. When the next period
> interrupt occurs, there is then less than avail_min samples remaining to
> be transferred in the period, so we end up sleeping until a second
> period occurs.
>
> This is solved by using runtime->twake as the number of samples needed
> for a wakeup in addition to selecting the proper wait queue to wake in
> snd_pcm_update_state(). This requires twake to be non-zero when used
> by snd_pcm_lib_{read,write}1() even if avail_min is zero.

http://mailman.alsa-project.org/pipermail/alsa-devel/2010-June/028786.html

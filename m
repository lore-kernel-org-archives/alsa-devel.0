From: Mads Kiilerich <mads@kiilerich.com>
Subject: Re: handling of underrunning snd_pcm_writei
Date: Thu, 12 Nov 2009 13:10:33 +0100
Message-ID: <4AFBFB39.8050500@kiilerich.com>
References: <4AFAEB44.60104@kiilerich.com> <s5hiqdgdxns.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C85C10395F
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 13:10:38 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 3so567098eyh.16
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 04:10:37 -0800 (PST)
In-Reply-To: <s5hiqdgdxns.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 11/12/2009 08:12 AM, Takashi Iwai wrote:
> Yes, snd_pcm_recover() is *recommended*.  You can write the recovery
> routine by yourself.  The function isn't referred here just because
> it's relatively new.  Better to be documented, indeed.

Thanks a lot for you answer, Takashi. That was very helpful.

But when I hack pcm_min.c to log the state at the beginning of the loop 
and then enforces an underrun by pausing the program then it sometimes 
locks up:

$ ./pcm_min
state 2 SND_PCM_STATE_PREPARED
state 2 SND_PCM_STATE_PREPARED
Short write (expected 16384, wrote 7616)
state 3 SND_PCM_STATE_RUNNING
state 3 SND_PCM_STATE_RUNNING
state 3 SND_PCM_STATE_RUNNING
state 3 SND_PCM_STATE_RUNNING
[ctrl-s ... waiting for silence ... ctrl q]
ALSA lib pcm.c:7234:(snd_pcm_recover) underrun occured
state 2 SND_PCM_STATE_PREPARED
state 2 SND_PCM_STATE_PREPARED
state 3 SND_PCM_STATE_RUNNING
[hanging in snd_pcm_writei]

It seems like pcm_min.cs use of snd_pcm_recover isn't enough to recover 
fully? The playback never gets started again, so the async writes in 
PREPARED succeeds, but the first blocking write hangs waiting forever? 
What is missing?

It also surprises me that the last PREPARED write isn't a short write. 
Why is that?

Regards,
Mads

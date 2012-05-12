From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: [PATCH alsa-lib 0/1] bug fix and comment on "switch"
Date: Sun, 13 May 2012 00:06:22 +0800
Message-ID: <1336838783-30686-1-git-send-email-borneo.antonio@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 584A6243AC
	for <alsa-devel@alsa-project.org>;
	Sat, 12 May 2012 18:07:04 +0200 (CEST)
Received: by dajt11 with SMTP id t11so5770012daj.38
	for <alsa-devel@alsa-project.org>; Sat, 12 May 2012 09:07:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

this is a very simple one line patch but the issue was
driving me crazy for few days.

After this finding, I have reviewed all the "switch"
statements in alsa-lib. All well done with proper comment
when a "case" falls through the next "case".

But there is one "switch" that does not follow the usual
scheme.
In file src/pcm/pcm_dsnoop.c
procedure snd_pcm_dsnoop_delay()
following code fragment:

        switch(dsnoop->state) {
        case SNDRV_PCM_STATE_DRAINING:
        case SNDRV_PCM_STATE_RUNNING:
                err = snd_pcm_dsnoop_sync_ptr(pcm);
                if (err < 0)
                        return err;
        case SNDRV_PCM_STATE_PREPARED:
        case SNDRV_PCM_STATE_SUSPENDED:
                *delayp = snd_pcm_mmap_capture_hw_avail(pcm);
                return 0;

If snd_pcm_dsnoop_sync_ptr() returns no error, execution
falls through next "case".
It's missing the usual comment
                /* Fall through */
to highlight such code behavior.
I think the code is correct, but I do not have enough
experience on alsa-lib to be sure. Please confirm.
In such case, I would suggest adding the comment above.

Best Regards,
Antonio Borneo

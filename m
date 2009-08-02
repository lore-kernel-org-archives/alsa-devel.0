From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH] Tell user that stream to be rewound is suspended
Date: Sun, 02 Aug 2009 18:32:57 +0200
Message-ID: <1249230777.4890.6.camel@localhost.localdomain>
References: <1249229684-8292-1-git-send-email-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753155AbZHBQwO@vger.kernel.org>
In-Reply-To: <1249229684-8292-1-git-send-email-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lennart Poettering <mzjro@0pointer.net>, stable@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2009-08-02 at 18:14 +0200, Lubomir Rintel wrote:
> Return STRPIPE instead of EBADF when userspace attempts to rewind
> of forward a stream that was suspended in meanwhile, so that it
> can be recovered by snd_pcm_recover().
> 
> This was causing Pulseaudio to unload the ALSA sink module under a race
> condition when it attempted to rewind the stream right after resume from
> suspend, before writing to the stream which would cause it to revive the
> stream otherwise. Tested to work with Pulseaudio patched to attempt to
> snd_pcm_recover() upon receiving an error from snd_pcm_rewind().

The userspace part is filed here:
http://www.pulseaudio.org/ticket/616

-- 
"Excuse all the blood" -- Dead

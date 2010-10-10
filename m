From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 1/2] OSS: soundcard: locking bug in
	sound_ioctl()
Date: Sun, 10 Oct 2010 20:39:34 +0200
Message-ID: <201010102039.34858.arnd@arndb.de>
References: <20101010173352.GB5851@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by alsa0.perex.cz (Postfix) with ESMTP id C8D1F2459F
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Oct 2010 20:39:52 +0200 (CEST)
In-Reply-To: <20101010173352.GB5851@bicker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sunday 10 October 2010 19:33:52 Dan Carpenter wrote:
> We shouldn't return directly here because we're still holding the
> &soundcard_mutex.
> 
> This bug goes all the way back to the start of git.  It's strange that
> no one has complained about it as a runtime bug.
> 
> CC: stable@kernel.org
> Signed-off-by: Dan Carpenter <error27@gmail.com>

It was only recently converted to a mutex from the BKL, which is much
more friendly to misusage because it is automatically released when
the kernel sleeps or when the program exits.

The behavior was already broken with the BKL but the problem was far
less visible. I fear we might be seeing more of these as fallout from
the BKL removal. Sparse should be able to detect most of these cases
though, so maybe we can look more carefully for them.

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd

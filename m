From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 3/5] ALSA: snd_usb_caiaq: use strncpy
Date: Mon, 1 Jun 2009 11:23:54 +0200
Message-ID: <20090601092354.GN26148@buzzloop.caiaq.de>
References: <1243719865-26760-1-git-send-email-daniel@caiaq.de>
	<1243719865-26760-2-git-send-email-daniel@caiaq.de>
	<1243719865-26760-3-git-send-email-daniel@caiaq.de>
	<s5hws7wfj6y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 64A8624358
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Jun 2009 11:23:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hws7wfj6y.wl%tiwai@suse.de>
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

On Mon, Jun 01, 2009 at 10:32:21AM +0200, Takashi Iwai wrote:
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> 
> You should use strlcpy() instead of strncpy().  The latter doesn't
> terminate the oversized string.

Right. Want me to resend or could you do that on the fly while
commiting?

Daniel

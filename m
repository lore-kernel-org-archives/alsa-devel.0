From: Ismael Luceno <ismael@iodev.co.uk>
Subject: Re: [PATCH] pcm: Fix shm initialization race-condition
Date: Mon, 22 Aug 2016 13:06:08 -0300
Message-ID: <20160822160606.2rbpl6jpegk3pnyi@pirotess.bf.iodev.co.uk>
References: <20160822160433.27598-1-ismael@iodev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iodev.co.uk (iodev.co.uk [82.211.30.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D000266A42
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 18:06:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160822160433.27598-1-ismael@iodev.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 22/Ago/2016 13:04, Ismael Luceno wrote:
> Easily seen when two threads try at the same time, one of them will fail.
> 
> The bug was identified by using apulse with Skype.
> 
> Fixes: dec428c35221 ("pcm: fix 'unable to create IPC shm instance' caused by fork from a thread")
> Fixes: https://github.com/i-rinat/apulse/issues/38
> Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
<...>

Oops, subject should be: [PATCH v2]...

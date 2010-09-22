From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] SOUND-OSS: Remove sh_dac_audio
Date: Wed, 22 Sep 2010 21:47:47 +0900
Message-ID: <20100922124747.GD9546@linux-sh.org>
References: <1285156021-4973-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp
	[124.34.33.190]) by alsa0.perex.cz (Postfix) with ESMTP id 6832F24435
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 14:47:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1285156021-4973-1-git-send-email-jkacur@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Kacur <jkacur@redhat.com>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, Frederic Weisbecker <fweisbec@gmail.com>, lkml <linux-kernel@vger.kernel.org>, ralf@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 22, 2010 at 01:47:01PM +0200, John Kacur wrote:
> Remove the SH DAC oss driver since there is an equivalent alsa driver.
> oss has been deprecated for years. Furthermore this driver has BKL code
> which we are trying to remove. Rather than attempt to fix this, simply
> remove the driver.
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>

Since I thought I had already removed this ages ago but appear to have
been imagining things:

Acked-by: Paul Mundt <lethal@linux-sh.org>

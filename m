From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] SOUND-OSS: Remove sh_dac_audio
Date: Wed, 22 Sep 2010 15:57:37 +0100
Message-ID: <20100922145737.GA12663@linux-mips.org>
References: <1285156021-4973-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [78.24.191.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C7591038F8
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 16:57:40 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
	(ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
	id S1491762Ab0IVO5i (ORCPT <rfc822;alsa-devel@alsa-project.org>);
	Wed, 22 Sep 2010 16:57:38 +0200
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
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, Frederic Weisbecker <fweisbec@gmail.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 22, 2010 at 01:47:01PM +0200, John Kacur wrote:

> Remove the SH DAC oss driver since there is an equivalent alsa driver.
> oss has been deprecated for years. Furthermore this driver has BKL code
> which we are trying to remove. Rather than attempt to fix this, simply
> remove the driver.
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>

No idea why I was cc'ed as I have no interested in the driver but certainly
support the motivation behind the patch:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf

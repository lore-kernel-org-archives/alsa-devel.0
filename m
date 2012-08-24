From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ASoC: samsung dma - prepare dma in
 start/resume trigger path
Date: Fri, 24 Aug 2012 09:15:00 +0200
Message-ID: <503729F4.5090805@ladisch.de>
References: <1345755069-9512-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2183426529D
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2012 09:15:05 +0200 (CEST)
In-Reply-To: <1345755069-9512-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, alim.akhtar@samsung.com, jassi.brar@samsung.com, padma.v@samsung.com, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, olofj@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Dylan Reid wrote:
> On suspend all dma transactions are terminated (by the stop/suspend
> trigger calling ops->stop), they need to be set up again during resume.
> Move the prepare op to the start/resume/unpause trigger path so that dma
> and audio will restart on resume/unpause.

TRIGGER_RESUME must restart the stream at the buffer position at which
it was suspended.  If the driver is not capable of that, it must not
support TRIGGER_SUSPEND/RESUME in the first place (i.e., remove
SNDRV_PCM_INFO_RESUME).


Regards,
Clemens

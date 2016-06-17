From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Intel: Add support for PM ops in
 bxt-da7219_max98357a
Date: Fri, 17 Jun 2016 13:18:10 +0200
Message-ID: <5763DC72.1060200@metafoo.de>
References: <1466138010-27740-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 724F62655DE
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 13:18:11 +0200 (CEST)
In-Reply-To: <1466138010-27740-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 06/17/2016 06:33 AM, Vinod Koul wrote:
> We need card to be early suspended and late resumed, so use
> prepare and complete for card suspend and resume.

Why and why is this something that other cards do not need to do?

From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: rt5640: Use the platform data for
 DMIC settings
Date: Fri, 28 Mar 2014 10:05:49 -0600
Message-ID: <53359DDD.7090900@wwwdotorg.org>
References: <1395974778-4217-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 067A4265506
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 17:05:55 +0100 (CET)
In-Reply-To: <1395974778-4217-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 03/27/2014 08:46 PM, Oder Chiou wrote:
> The patch uses the platform data for DMIC settings.

Shouldn't this also support parsing the same information from device tree?

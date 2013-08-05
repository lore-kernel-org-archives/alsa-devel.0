From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: rt5640: change widget sequence for
	depop
Date: Mon, 05 Aug 2013 11:17:58 -0600
Message-ID: <51FFDE46.6060006@wwwdotorg.org>
References: <1375676343-13891-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id D191C26508F
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 19:18:03 +0200 (CEST)
In-Reply-To: <1375676343-13891-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, lgirdwood@gmail.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 08/04/2013 10:19 PM, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
> 
> Add mute/unmute control in widget event and modify the power on/off sequence to avoid pop noise.

FWIW, this version,
Tested-by: Stephen Warren <swarren@nvidia.com>

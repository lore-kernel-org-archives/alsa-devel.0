From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: dapm: Fix empty list check in
	dapm_new_mux()
Date: Thu, 01 Aug 2013 11:20:34 -0600
Message-ID: <51FA98E2.6050701@wwwdotorg.org>
References: <1375374638-28305-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B225261619
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 19:20:39 +0200 (CEST)
In-Reply-To: <1375374638-28305-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Olof Johansson <olof@lixom.net>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/01/2013 10:30 AM, Lars-Peter Clausen wrote:
> list_first_entry() will always return a valid pointer, even if the list is
> empty. So the check whether path is NULL will always be false. So we end up
> calling dapm_create_or_share_mixmux_kcontrol() with a path struct that points
> right in the middle of the widget struct and by trying to modify the path the
> widgets memory will become corrupted. Fix this by using list_emtpy() to check if
> the widget doesn't have any paths.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> ---
> This is the real fix for the rt5640 crash.

Tested-by: Stephen Warren <swarren@nvidia.com>

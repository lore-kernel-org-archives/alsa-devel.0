From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 05/11] ASoC: samsung: spdif: Handle return
 value of clk_prepare_enable.
Date: Tue, 25 Jul 2017 20:01:19 +0200
Message-ID: <20170725180119.GD8329@kozik-book>
References: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1500977674-27960-6-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f41.google.com (mail-pg0-f41.google.com [74.125.83.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A764266CFE
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 20:01:32 +0200 (CEST)
Received: by mail-pg0-f41.google.com with SMTP id 125so73240735pgi.3
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 11:01:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1500977674-27960-6-git-send-email-arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: alsa-devel@alsa-project.org, sbkim73@samsung.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 25, 2017 at 03:44:32PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  sound/soc/samsung/spdif.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

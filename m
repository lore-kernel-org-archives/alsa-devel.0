From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 04/11] ASoC: samsung: i2s: Handle return
 value of clk_prepare_enable.
Date: Tue, 25 Jul 2017 19:58:35 +0200
Message-ID: <20170725175835.GC8329@kozik-book>
References: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1500977674-27960-5-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f193.google.com (mail-yw0-f193.google.com
 [209.85.161.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F1B2266CFE
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 19:58:42 +0200 (CEST)
Received: by mail-yw0-f193.google.com with SMTP id l82so3775915ywc.2
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 10:58:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1500977674-27960-5-git-send-email-arvind.yadav.cs@gmail.com>
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

On Tue, Jul 25, 2017 at 03:44:31PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  sound/soc/samsung/i2s.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

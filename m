From: Karl Beldan <karl.beldan@gmail.com>
Subject: Re: [PATCH 2/5] ASoC: ssm2602 codec: fix bug - kernel
 will crash when record and play in bf527-ezkit
Date: Fri, 06 Mar 2009 10:50:08 +0100
Message-ID: <49B0F1D0.9070707@gmail.com>
References: <1236326010-683-1-git-send-email-cooloney@kernel.org>
	<1236326010-683-3-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f163.google.com (mail-ew0-f163.google.com
	[209.85.219.163])
	by alsa0.perex.cz (Postfix) with ESMTP id 7345F24134
	for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2009 10:49:37 +0100 (CET)
Received: by ewy7 with SMTP id 7so160618ewy.32
	for <alsa-devel@alsa-project.org>; Fri, 06 Mar 2009 01:49:36 -0800 (PST)
In-Reply-To: <1236326010-683-3-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: Cliff Cai <cliff.cai@analog.com>, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Bryan Wu wrote:
> From: Cliff Cai <cliff.cai@analog.com>
> 
> set constraint only if the value is not 0, change the configuring way for sport
> 
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> ---
>  sound/soc/codecs/ssm2602.c |   29 ++++++++++++++---------------
>  1 files changed, 14 insertions(+), 15 deletions(-)
>
What tree is this against ?

-- 
Karl Beldan

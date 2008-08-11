From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 2/2] wm8750: add missing VREF output
Date: Mon, 11 Aug 2008 13:11:56 +0400
Message-ID: <48A0025C.6000903@gmail.com>
References: <1218444346-19153-1-git-send-email-dbaryshkov@gmail.com>
	<1218444346-19153-2-git-send-email-dbaryshkov@gmail.com>
	<20080811091119.GC9668@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by alsa0.perex.cz (Postfix) with ESMTP id B3744103836
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Aug 2008 11:13:17 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id u40so441152ugc.50
	for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2008 02:13:17 -0700 (PDT)
In-Reply-To: <20080811091119.GC9668@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Aug 11, 2008 at 12:45:46PM +0400, Dmitry Baryshkov wrote:
>> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Not that we normally bother with these but it doesn't do any harm.

It does harm, because it's used in route tables. And as using it as a 
route dest fails, all further routing mapping aren't ever called.

-- 
With best wishes
Dmitry

From: Ed Blake <ed.blake@sondrel.com>
Subject: Re: [PATCH 2/2] ASoC: img-i2s-in: Add runtime PM
Date: Thu, 5 Oct 2017 14:28:19 +0100
Message-ID: <9679df5e-b56a-3792-0570-f0519f6810ce@sondrel.com>
References: <1506938333-550-1-git-send-email-ed.blake@sondrel.com>
 <1506938333-550-3-git-send-email-ed.blake@sondrel.com>
 <20171004103812.vma6qmbfncnskhdw@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0056.outbound.protection.outlook.com [104.47.0.56])
 by alsa0.perex.cz (Postfix) with ESMTP id A372F2674E1
 for <alsa-devel@alsa-project.org>; Thu,  5 Oct 2017 15:28:24 +0200 (CEST)
In-Reply-To: <20171004103812.vma6qmbfncnskhdw@sirena.co.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

n 04/10/17 11:38, Mark Brown wrote:
> On Mon, Oct 02, 2017 at 10:58:53AM +0100, Ed Blake wrote:
>
>> +	pm_runtime_get_sync(i2s->dev);
> There is no error checking here, you shouldn't just ignore the error.
I'll fix this in v2.

Ed.

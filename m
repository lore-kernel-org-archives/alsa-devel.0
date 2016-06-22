From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: ASoC: nau8825: cross talk suppression measurement
	function
Date: Wed, 22 Jun 2016 11:09:34 +0800
Message-ID: <576A016E.5070607@nuvoton.com>
References: <20160615123352.GA7136@mwanda> <57674C20.3080707@nuvoton.com>
 <20160620100012.GK32247@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AB0E42651A8
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2016 05:09:39 +0200 (CEST)
In-Reply-To: <20160620100012.GK32247@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: AC30 YHChuang <YHCHuang@nuvoton.com>, AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 6/20/2016 6:00 PM, Dan Carpenter wrote:
> On Mon, Jun 20, 2016 at 09:51:28AM +0800, John Hsu wrote:
>   
>> Is it better to separate this function to two case, one locked with
>> timeout and the other not? Do you have any suggestion about it?
>> Thank you.
>>     
>
> It should return the error code and the callers should handle it.  We
> always have to know if we have the lock or not.
>
> regards,
> dan carpenter
>
> .
>
>   

I see and we'll modify it. Thanks for your suggestion.

BR.
John

From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: A question about the soc jack status
Date: Wed, 28 Oct 2009 18:04:18 +0900
Message-ID: <4AE80912.1020500@samsung.com>
References: <4AE7EFE1.9000407@samsung.com>
	<ef0d8a250910280032n7f9a12c0x12dd7e9c30ad3e25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout5.samsung.com (mailout5.samsung.com [203.254.224.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F6A6103801
	for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2009 10:04:21 +0100 (CET)
Received: from epmmp1 (mailout5.samsung.com [203.254.224.35])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KS700GN5VV68X@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 28 Oct 2009 18:04:19 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KS70061KVV64B@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 28 Oct 2009 18:04:18 +0900 (KST)
In-reply-to: <ef0d8a250910280032n7f9a12c0x12dd7e9c30ad3e25@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Cc: kyungmin.park@samsung.com, alsa-devel@alsa-project.org, knhoon.baik@samsung.com
List-Id: alsa-devel@alsa-project.org

On 10/28/2009 4:32 PM, Naveen Krishna Ch wrote:
> 2009/10/28 Joonyoung Shim <jy0922.shim@samsung.com>
> 
>> Hi, all.
>>
>> I have a question about soc jack. I know the soc jack reports the jack
>> status when the jack status is change only. For example when the jack
>> is inserted or released, the soc jack reports the jack status to user
>> via input subsystem.
>>
>> But i want to know the jack status always regardless of the event to
>> insert or release a jack. For example we can check the jack status
>> always if the jack status is reported via sysfs file.
>>
> There is a /sys/class/soc/jack/status
> Dont remember the exact path.
> Cat of that file will tell us right
> 

I cannot find "jack" word under /sys directory.
Can you give me the exact path?

>> So, is there how to know the jack status always the currently?
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
> 
> 
> 

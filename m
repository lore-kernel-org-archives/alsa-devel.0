From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [PATCH 1/2] ASOC: SAMSUNG: Add DT support for i2s
Date: Wed, 01 Aug 2012 17:29:37 +0900
Message-ID: <08da01cd6fbf$cd9b5c00$68d21400$@com>
References: <1343218170-30483-1-git-send-email-padma.v@samsung.com>
 <1343218170-30483-2-git-send-email-padma.v@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 337B4264FC1
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 10:29:45 +0200 (CEST)
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M82001XOI9GJ0R0@mailout1.samsung.com> for
 alsa-devel@alsa-project.org; Wed, 01 Aug 2012 17:29:44 +0900 (KST)
Received: from DOSBKIM7302 ([12.23.118.225])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M8200LR6I9KUA80@mmp2.samsung.com> for
 alsa-devel@alsa-project.org; Wed, 01 Aug 2012 17:29:44 +0900 (KST)
In-reply-to: <1343218170-30483-2-git-send-email-padma.v@samsung.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Padmavathi Venna' <padma.v@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org
Cc: kgene.kim@samsung.com, rcsekar@samsung.com, sangsu4u.park@samsung.com, joshi@samsung.com, thutt@chromium.org, ben-linux@fluff.org, olofj@google.com
List-Id: alsa-devel@alsa-project.org

Hi,
On Wednesday, July 25, 2012 9:09 PM, Padmavathi Venna wrote:

> Add support for device based discovery.
> 
Currently, I'm reviewing your patch set.
Your patch can support device tree for Samsung's i2s.
But I wonder that Your patch can support non-dt too,
So, Please test your patch on non-dt environment.
It looks unclear handling of clock source.
After code review, I will give you more detail comments,

Thanks,
Sangbeom.

From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 0/2] amidi: fix handling of ignored messages
Date: Mon, 15 Aug 2016 16:31:22 +0200
Message-ID: <27bb6314-022a-d7ba-40fd-119f5872b28d@ladisch.de>
References: <ac3f1f9a-5201-7a98-e659-fd9bbcf41ab7@ladisch.de>
 <c89ccbd5-6cbe-c18d-1b70-cef9d4c9b2e0@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 41972267AF0
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 16:31:23 +0200 (CEST)
In-Reply-To: <c89ccbd5-6cbe-c18d-1b70-cef9d4c9b2e0@felipetonello.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Felipe Ferreri Tonello wrote:
> On 13/08/16 11:27, Clemens Ladisch wrote:
>> Clemens Ladisch (2):
>>       amidi: ignore not only Active Sensing but also Clock bytes
>>       amidi: fix timeout handling
>>
>>  amidi/amidi.1 |   19 ++++++++---
>>  amidi/amidi.c |   82 +++++++++++++++++++++++++++++++++++++++-----------
>>  2 files changed, 78 insertions(+), 23 deletions(-)
>>
>
> I can't see the patches emails.

http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/111737.html

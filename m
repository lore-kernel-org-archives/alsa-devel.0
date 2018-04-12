From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH 0/5] for-linux/sndif: add explicit back and
 front synchronization
Date: Thu, 12 Apr 2018 19:55:04 +0300
Message-ID: <db3ee9fb-d0ab-5f17-a1ec-7bb8ec5cf75f@epam.com>
References: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
 <d5ede3f5-200e-f1c7-71f4-4ebfb938ca48@gmail.com>
 <43348cf5-d2f8-9d7d-0390-2273eef8f67d@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0049.outbound.protection.outlook.com [104.47.1.49])
 by alsa0.perex.cz (Postfix) with ESMTP id E8AC526737B
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 18:55:19 +0200 (CEST)
In-Reply-To: <43348cf5-d2f8-9d7d-0390-2273eef8f67d@oracle.com>
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
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Oleksandr Andrushchenko <andr2000@gmail.com>, konrad.wilk@oracle.com, tiwai@suse.de
Cc: jgross@suse.com, xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 04/12/2018 07:55 PM, Boris Ostrovsky wrote:
> On 04/12/2018 12:11 PM, Oleksandr Andrushchenko wrote:
>> Hello, Konrad, Takashi!
>>
>> Could you please review the *Linux Kernel* version of the changes?
>> As I said in the cover letter below there is no functional changes
>> comparing to the corresponding Xen version, but spaces to tabs.
>> Still, formally, I have to drop the R-b tags and request for the new
>> review.
> Is there any reason why this all can't be done in a single patch?
Just to preserve the history of the changes?
> This is just syncing up with the canonical definition in Xen.
Do you want me to squash and resend?
> -boris
>
>
Thank you,
Oleksandr

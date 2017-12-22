From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Subject: Re: [Xen-devel] [RFC v1] ALSA: xen-front: Add Xen
 para-virtualized frontend driver
Date: Fri, 22 Dec 2017 18:07:15 +0200
Message-ID: <546442fa-38b7-6577-56f7-273be9799c1b@epam.com>
References: <fff5d166-066c-c21e-94b9-bb50f8c1b2cd@epam.com>
 <172d2f40-937d-5455-1b4e-576ac7b0da45@gmail.com>
 <9031a8b0-88c2-bd86-548c-7dbcf8967856@gmail.com>
 <20171222151221.GC2483@char.us.oracle.com>
 <d3b93842-a970-e2e0-2ecb-6f66c2851f6c@epam.com>
 <20171222155817.GH2483@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20056.outbound.protection.outlook.com [40.107.2.56])
 by alsa0.perex.cz (Postfix) with ESMTP id EF89E2678D0
 for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2017 17:07:22 +0100 (CET)
In-Reply-To: <20171222155817.GH2483@char.us.oracle.com>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: alsa-devel@alsa-project.org, Oleksandr Andrushchenko <andr2000@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, tiwai@suse.com, linux-kernel@vger.kernel.org, xen-devel <xen-devel@lists.xenproject.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org



On 12/22/2017 05:58 PM, Konrad Rzeszutek Wilk wrote:
> On Fri, Dec 22, 2017 at 05:48:45PM +0200, Oleksandr Andrushchenko wrote:
>> On 12/22/2017 05:12 PM, Konrad Rzeszutek Wilk wrote:
>>> On Mon, Dec 11, 2017 at 10:45:27AM +0200, Oleksandr Andrushchenko wrote:
>>>> ping
>>> ..snip..
>>>>>> This is implemented as a change to the sndif protocol [8] and allows
>>>>>> [8] https://github.com/andr2000/linux/commit/095d7feae00bf00c852c67c4f1044de5601678ed
>>> .. I must have missed it being posted.
>>>
>>> But it looks OK to me - could you repost it and please have me on To: list?
>>>
>> Did I get you right that you want me to repost the RFC again?
> Yes pls, but pls skip the RFC part of the patch. Just as v1 please.
Ah, well, I am not quite sure this is the right time to discuss the changes
in terms of patches: I would like to discuss the idea first, e.g.
if the approach itself is acceptable by the ALSA community and if it is,
then I'll push v1, e.g move to patches stage. Hence, here is the RFC...

The driver itself (at the moment) is just a proof-of-concept for the
community to show that the approach we are offering in the RFC actually 
works.

Does the above make sense?

Thank you,
Oleksandr

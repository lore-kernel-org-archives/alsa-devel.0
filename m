From: Patrick Lai <plai@codeaurora.org>
Subject: Re: ucm: hardware resource arbitration
Date: Wed, 12 Sep 2012 15:51:15 -0700
Message-ID: <505111E3.9090506@codeaurora.org>
References: <504EDF0F.70809@codeaurora.org> <1347458022.6888.31.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 by alsa0.perex.cz (Postfix) with ESMTP id EC84C2616F9
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 00:51:18 +0200 (CEST)
In-Reply-To: <1347458022.6888.31.camel@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanuk@iki.fi>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 9/12/2012 6:53 AM, Tanu Kaskinen wrote:
> On Mon, 2012-09-10 at 23:49 -0700, Patrick Lai wrote:
>> Hi,
>>
>> I have two use cases which can acquire same CODEC path but they cannot
>> run concurrently through mixing. When such scenario does arise,
>> arbitration is required based on priority of use cases. On the other
>> hand, same use cases on different platform may use different CODEC
>> paths so arbitration is not required. In order to decide whether
>> arbitration is required, I think the best place to do so is in UCM. I
>> looked at existing UCM APIs but I do not believe existing APIs have
>> concept of arbitration built in. If I am wrong, how can I handle
>> arbitration with existing UCM APIs. If I am correct, is there anyone
>> looking to expand UCM APIs for similar scenario?
>
> In my opinion routing priorities don't belong in the UCM configuration.
> UI designers will want to dictate the routing policy (i.e. what device
> to prefer in which use case).

Thanks for your feedback. Actually, I am not looking at routing policy 
in term of preferred device for a given use case. I agree that
something above alsa/ucm should decide. My problem is two use cases
cannot co-exist on certain platforms but not on the others. Two use 
cases are coming from two SW entities which are not aware of each other 
but they all talk to UCM for hardware configuration. Each SW entity 
decides its own use case and preferred device. Please correct me if I am 
wrong. UCM is designed to abstract hardware configuration detail. So, it 
seems appropriate to me that UCM can  contain information about the use 
cases a given platform can support/not support concurrently. Since 
UCM(assuming it's singleton) is the entity that has visibility to all 
use cases exercised by all SW entities, It makes sense to me to have UCM 
notify clients if its use case is to be preempted. Even if we want to 
create a resource manager on top of UCM for two SW entities to 
communicate, does UCM already have API allowing client to know its use 
case is a go or no go?

Thanks
Patrick

The same hardware may end up being used in
> different products, and the UI designers for those different products
> may not all want the same policy.  Therefore, I don't want UCM
> configurations to include any routing policy. The policy configuration
> belongs to some component that sits above alsa and UCM.
>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

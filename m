From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: ucm: hardware resource arbitration
Date: Wed, 12 Sep 2012 16:53:42 +0300
Message-ID: <1347458022.6888.31.camel@laptop>
References: <504EDF0F.70809@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id CF8FA2616EA
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 15:54:13 +0200 (CEST)
In-Reply-To: <504EDF0F.70809@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-09-10 at 23:49 -0700, Patrick Lai wrote:
> Hi,
> 
> I have two use cases which can acquire same CODEC path but they cannot
> run concurrently through mixing. When such scenario does arise,
> arbitration is required based on priority of use cases. On the other
> hand, same use cases on different platform may use different CODEC
> paths so arbitration is not required. In order to decide whether
> arbitration is required, I think the best place to do so is in UCM. I
> looked at existing UCM APIs but I do not believe existing APIs have
> concept of arbitration built in. If I am wrong, how can I handle
> arbitration with existing UCM APIs. If I am correct, is there anyone
> looking to expand UCM APIs for similar scenario?

In my opinion routing priorities don't belong in the UCM configuration.
UI designers will want to dictate the routing policy (i.e. what device
to prefer in which use case). The same hardware may end up being used in
different products, and the UI designers for those different products
may not all want the same policy. Therefore, I don't want UCM
configurations to include any routing policy. The policy configuration
belongs to some component that sits above alsa and UCM.

-- 
Tanu

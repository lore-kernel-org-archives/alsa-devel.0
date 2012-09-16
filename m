From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: ucm: hardware resource arbitration
Date: Sun, 16 Sep 2012 09:40:56 +0300
Message-ID: <1347777656.3371.25.camel@laptop>
References: <504EDF0F.70809@codeaurora.org>
 <1347458022.6888.31.camel@laptop> <505111E3.9090506@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 77000260311
 for <alsa-devel@alsa-project.org>; Sun, 16 Sep 2012 08:41:00 +0200 (CEST)
In-Reply-To: <505111E3.9090506@codeaurora.org>
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

On Wed, 2012-09-12 at 15:51 -0700, Patrick Lai wrote:
> On 9/12/2012 6:53 AM, Tanu Kaskinen wrote:
> > In my opinion routing priorities don't belong in the UCM configuration.
> > UI designers will want to dictate the routing policy (i.e. what device
> > to prefer in which use case).
> 
> Thanks for your feedback. Actually, I am not looking at routing policy 
> in term of preferred device for a given use case. I agree that
> something above alsa/ucm should decide. My problem is two use cases
> cannot co-exist on certain platforms but not on the others. Two use 
> cases are coming from two SW entities which are not aware of each other 
> but they all talk to UCM for hardware configuration. Each SW entity 
> decides its own use case and preferred device. Please correct me if I am 
> wrong. UCM is designed to abstract hardware configuration detail. So, it 
> seems appropriate to me that UCM can  contain information about the use 
> cases a given platform can support/not support concurrently. Since 
> UCM(assuming it's singleton) is the entity that has visibility to all 
> use cases exercised by all SW entities, It makes sense to me to have UCM 
> notify clients if its use case is to be preempted. Even if we want to 
> create a resource manager on top of UCM for two SW entities to 
> communicate, does UCM already have API allowing client to know its use 
> case is a go or no go?

It sounds like you think UCM is a daemon, to which clients connect.
AFAIK, UCM is only a library. There are no "UCM clients", only
applications that read the UCM configuration files and activate things
by using the library. While it probably wouldn't be impossible to have a
notification mechanism even without a central daemon, I don't think that
such mechanism currently exists, nor do I think that such mechanism is
needed. If a system has multiple audio applications that may run
simultaneously, I think there should be a "resource manager" application
between UCM and the applications.

Regarding the problem of "two use cases [can] co-exist on certain
platforms but not on the others": I think this should be solvable by
using the ConflictingDevice list inside SectionDevice. In your example
you have two applications that can or can not use the hardware at the
same time, depending on the platform. The applications should use the
resource manager, and it's then up to the resource manager to decide
which application can use the hardware. The resource manager needs to
somehow know what device the application needs (maybe this information
comes directly from the application), and based on the ConflictingDevice
information in UCM and some priority configuration it can do the
decision.

-- 
Tanu

From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 01/13] soundwire: Add more documentation
Date: Fri, 30 Mar 2018 12:08:15 +0530
Message-ID: <20180330063815.GO15443@localhost>
References: <1522229918-4748-1-git-send-email-vinod.koul@intel.com>
 <1522229918-4748-2-git-send-email-vinod.koul@intel.com>
 <639b2f0b-eea8-9c68-e9e9-a29238450d5d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3570E2671B9
 for <alsa-devel@alsa-project.org>; Fri, 30 Mar 2018 08:34:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <639b2f0b-eea8-9c68-e9e9-a29238450d5d@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Just a note, it helps to trim the context. Pls do so in replies.

On Thu, Mar 29, 2018 at 08:47:28PM -0500, Pierre-Louis Bossart wrote:
> On 3/28/18 4:38 AM, Vinod Koul wrote:

> >+SoundWire stream states
> >+-----------------------
> >+
> >+Below shows the SoundWire stream states and state transition diagram. ::
> >+
> >+	+---------+     +----------+     +----------+     +----------+
> >+	|  ALLOC  +---->|  CONFIG  +---->| PREPARE  +---->|  ENABLE  |
> >+	|  STATE  |     |  STATE   |     |  STATE   |     |  STATE   |
> >+	+---------+     +----------+     +----------+     +----+-----+
> >+	                                                       ^
> >+	                                                       |
> >+	                                                       |
> >+	                                                       v
> >+	         +----------+           +-----------+     +----+-----+
> >+	         |  RELEASE |<----------+ DEPREPARE |<----+  DISABLE |
> >+	         |   STATE  |           |  STATE    |     |  STATE   |
> >+	         +----------+           +-----------+     +----------+
> >+
> >+NOTE: All stream transitions in MIPI Spec are NOT supported by software.
> 
> specifically that there are not transitions between prepare and deprepare.

Okay we can add that.

> While I am at it, didn't I provide feedback that the documentation and code
> confuse states and transitions between the states?

> Also there is a
> connection between released and allocated, this state machine isn't really
> working or representative of what the code does initially.

When we allocate sdw_stream_runtime, the initial state of the stream
would be garbage/NULL. It is initialized to ALLOC at that time.

        stream = kzalloc(sizeof(*stream), GFP_KERNEL);
        if (!stream)
                return NULL;

        stream->name = stream_name;
        stream->state = SDW_STREAM_ALLOC;

One can argue that we use kzalloc so we are in RELEASE, but I think that is
bike shedding. The lifetime of stream starts with ALLOC and ends at RELEASE
and we freeup the data structure. So I don't think there is a relation
between ALLOC and RELEASE. Any attempt to make such a relation would confuse
folks!

> See my feedback dated February 26 on the previous version.
> 
> "the name of the states are equivalent to an action. It would be more
> consistent to e.g. have an ENABLED state reached after an
> sdw_stream_enable() function.
> 
> same with sdw_stream_prepared leading to the PREPARED state. I think it's
> how most standards or state machine designs are defined (and how English
> grammar works as well)." ALSA also uses OPEN, PREPARED, PAUSED, see asound.h

Hmmm after immersing in bunch of English literature we finally figured
that wrapped logic here that out stream states shall be named as not action.
Well that could have possibly be communicated in plain speak too :D

No worries, will change the state names aptly.

-- 
~Vinod

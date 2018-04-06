From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 01/13] soundwire: Add more documentation
Date: Fri, 6 Apr 2018 08:54:51 +0530
Message-ID: <20180406032449.GD6014@localhost>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
 <1522946904-2089-2-git-send-email-vinod.koul@intel.com>
 <1f54fc62-8da0-ee1e-327c-30230b5f00f6@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A3E0266E30
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 05:20:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1f54fc62-8da0-ee1e-327c-30230b5f00f6@linux.intel.com>
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

On Thu, Apr 05, 2018 at 04:37:14PM -0500, Pierre-Louis Bossart wrote:
> On 4/5/18 11:48 AM, Vinod Koul wrote:

> >+SoundWire stream states
> >+-----------------------
> >+
> >+Below shows the SoundWire stream states and state transition diagram. ::
> >+
> >+	+-----------+     +------------+     +----------+     +----------+
> >+	| ALLOCATED +---->| CONFIGURED +---->| PREPARED +---->| ENABLED  |
> >+	|   STATE   |     |    STATE   |     |  STATE   |     |  STATE   |
> >+	+-----------+     +------------+     +----------+     +----+-----+
> >+	                                                           ^
> >+	                                                           |
> >+	                                                           |
> >+	                                                           v
> >+	         +----------+           +------------+        +----+-----+
> >+	         | RELEASED |<----------+ DEPREPARED |<-------+ DISABLED |
> >+	         |  STATE   |           |   STATE    |        |  STATE   |
> >+	         +----------+           +------------+        +----------+
> >+
> 
> Patch 2 describes the states as below:
> 
> +enum sdw_stream_state {
> +	SDW_STREAM_RELEASED = 0,
> +	SDW_STREAM_ALLOCATED = 1,
> +	SDW_STREAM_CONFIGURED = 2,
> +	SDW_STREAM_PREPARED = 3,
> +	SDW_STREAM_ENABLED = 4,
> +	SDW_STREAM_DISABLED = 5,
> +	SDW_STREAM_DEPREPARED = 6,
> 
> which isn't the same picture as the ascii art above. The RELEASED state is
> the starting point, and there's an arrow missing from RELEASED to ALLOCATED.

The enumerator describes the values given for each state. That has no
relation whatsoever to state transitions allowed. I don't recall why people
made SDW_STREAM_RELEASED as Zero, it could very well have been 7 and nothing
changes in diagram.

Now in the last review I did mention to you that there is NO transition
between RELEASED and ALLOCATED, hence no arrow can be made.

Your point on initial state is not right. I can we go ahead and do a
kmalloc() instead of current kzalloc() for the structure which would make
stream state from garbage/uninitialized to ALLOCATED and eventually finally
into RELEASED and it being freed. See no move between ALLOCATED and
RELEASED!

-- 
~Vinod

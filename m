Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E5162673D4
 for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2018 05:37:32 +0200 (CEST)
Date: Wed, 11 Apr 2018 09:11:57 +0530
From: Vinod Koul <vinod.koul@intel.com>
Message-ID: <20180411034155.GU6014@localhost>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
 <1522946904-2089-3-git-send-email-vinod.koul@intel.com>
 <bd17bb61-11cb-c1d5-d9cc-29cb9b01d928@linux.intel.com>
 <20180406045338.GE6014@localhost>
 <12d67055-d20b-5573-e342-35865b973ec8@linux.intel.com>
 <20180410044306.GP6014@localhost>
 <29ccea0c-e89c-f9c2-7cde-465a60f14acc@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <29ccea0c-e89c-f9c2-7cde-465a60f14acc@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 02/13] soundwire: Add support for
 SoundWire stream management
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-ID: <alsa-devel@alsa-project.org>

On Tue, Apr 10, 2018 at 10:47:24AM -0500, Pierre-Louis Bossart wrote:

> >>>Again we are not writing a spec but code and comments to explain the code.
> >>>The above is not related to "this" series so we should not add it here. When
> >>>we add device-device support, multi-master support these can be added
> >>>
> >>>We are adding blocks in a giant building, but you are only looking at the
> >>>giant picture but not the block in discussion!
> >>
> >>no, you have keep mentions to multi-link that are questionable. Either you
> >>remove them or you state it's reserved for future use.
> >
> >I have clarified on bus_node above, can you check and tell me if there is
> >anything else?
> 
> The code pattern for the bank switch was inspired by multi-link.

As you pointed out, we are fixing that too

> >Okay so we are going to track if master and slaves runtimes are configured
> >by adding a flag in each of them. Once all the components are configured the
> >stream stated will be updated. Does that sound ok?
> 
> How do you detect that all components are configured? We have a distributed
> allocation/configuration with multiple actors, I don't what triggers the
> transition to a new state.
> see more below.
> 
> >
> >>>>+Configuration state of stream. Operations performed before entering in
> >>>>+this state:
> >>>>+
> >>>>+  (1) The resources allocated for stream information in
> >>>>SDW_STREAM_ALLOCATED
> >>>>+      state are updated here. This includes stream parameters, Master(s)
> >>>>+      and Slave(s) runtime information associated with current stream.
> >>>>+
> >>>>+  (2) All the Master(s) and Slave(s) associated with current stream provide
> >>>>+      the port information to Bus which includes port numbers allocated by
> >>>>+      Master(s) and Slave(s) for current stream and their channel mask.
> >>>>
> >>>>so how can Master ports be configured if it is added to a stream *after* the
> >>>>CONFIGURED state?
> >>>
> >>>Yes you have a valid point wrt documentation, will update it.
> >>
> >>It's not just the documentation, I wonder if it actually works. You would
> >>want to make sure all masters and slaves are allocated before configuring
> >>them, otherwise the error handling flow is just awful to deal with. You
> >>could end-up in a situation where all Slaves are configured but the master
> >>allocation fails.
> >
> >Ok
> 
> If the ALLOCATED and CONFIGURED states are clearly separated out, then what
> if the flag you mentioned used for?

As you rightly pointed out that we have distributed allocation/configuration
with multiple actors. So to ensure that all actors are properly configured
before we move stream state to CONFIGURED, we need to check and to do so the
flag will be very useful :-)
-- 
~Vinod
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

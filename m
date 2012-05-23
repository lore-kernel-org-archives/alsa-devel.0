From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ALSA: update sync header when streams
 are linked/unlinked
Date: Wed, 23 May 2012 13:57:34 -0500
Message-ID: <4FBD331E.7010802@linux.intel.com>
References: <1337716442-10411-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	<s5h62bn93sc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id DC7962444C
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2012 20:57:37 +0200 (CEST)
In-Reply-To: <s5h62bn93sc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for reviewing Takashi. Comments below.
>
>> and provide more information such as
>> number of devices and indices of capture/playback devices
>> linked to
> This is a completely different issue, so please don't mix up in a
> single patch.
No problem. I did this on purpose to see the reaction and understand 
what the expectation was...I don't really care about the contents of 
this structure as long as it's consistent.

> ... this isn's safe. There are more than 32 substreams. And there are 
> multiple streams with the same substream index.

The only HW I know of that supports linked streams is HDAudio, and it 
uses a 32-bit mask for SSYNC...
But I guess you're right this doesn't scale.

> Also, the point of the sync id is that it's shared with all linked
> streams.  Your patch breaks it.  It updates only the last added sync
> id.
>
> The fact that the driver currently sets only the card number is
> actually problematic.  It's not unique enough.  This should be fixed.
> But, exposing the substream bitmask doesn't help much because it can't
> be fully implemented in the sync id size.  If you need to know which
> streams are linked, loop over all streams and check the sync id.
If I understand you well, the sync id should be a unique identifier 
shared by all linked streams in the same group. Since devices can be 
linked/unlinked, this id cannot use anything related to device or 
subdevice number. Maybe a pid-like value incremented when a group is 
created would do?
Thanks,
-Pierre

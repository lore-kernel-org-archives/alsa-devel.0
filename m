From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] ALSA: update sync header when streams
 are linked/unlinked
Date: Wed, 23 May 2012 21:32:08 +0200
Message-ID: <4FBD3B38.4050005@ladisch.de>
References: <1337716442-10411-1-git-send-email-pierre-louis.bossart@linux.intel.com>	<s5h62bn93sc.wl%tiwai@suse.de>
	<4FBD331E.7010802@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 471FF24141
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2012 21:32:34 +0200 (CEST)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6746F20DC7
	for <alsa-devel@alsa-project.org>; Wed, 23 May 2012 15:32:33 -0400 (EDT)
Received: from [192.168.42.198] (unknown [46.115.35.238])
	by mail.messagingengine.com (Postfix) with ESMTPA id B11578E0200
	for <alsa-devel@alsa-project.org>; Wed, 23 May 2012 15:32:31 -0400 (EDT)
In-Reply-To: <4FBD331E.7010802@linux.intel.com>
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

Pierre-Louis Bossart wrote:
>> The fact that the driver currently sets only the card number is
>> actually problematic.  It's not unique enough.  This should be fixed.
>> But, exposing the substream bitmask doesn't help much because it can't
>> be fully implemented in the sync id size.  If you need to know which
>> streams are linked, loop over all streams and check the sync id.
>
> If I understand you well, the sync id should be a unique identifier
> shared by all linked streams in the same group.

Just to clarify: does the sync id identify streams that are linked, or
streams that can be started atomically when linked?  Because at the
moment, all drivers implement the latter.  Furthermore, it's possible
to link completely unrelated devices, so not even the card number could
be used for the former.


Regards,
Clemens

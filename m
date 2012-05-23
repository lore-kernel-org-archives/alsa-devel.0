From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ALSA: update sync header when streams
 are linked/unlinked
Date: Wed, 23 May 2012 17:01:54 -0500
Message-ID: <4FBD5E52.9050203@linux.intel.com>
References: <1337716442-10411-1-git-send-email-pierre-louis.bossart@linux.intel.com>	<s5h62bn93sc.wl%tiwai@suse.de>
	<4FBD331E.7010802@linux.intel.com> <4FBD3B38.4050005@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 81AE8243AA
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2012 00:01:58 +0200 (CEST)
In-Reply-To: <4FBD3B38.4050005@ladisch.de>
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

>> If I understand you well, the sync id should be a unique identifier
>> shared by all linked streams in the same group.
> Just to clarify: does the sync id identify streams that are linked, or
> streams that can be started atomically when linked?  Because at the
> moment, all drivers implement the latter.  Furthermore, it's possible
> to link completely unrelated devices, so not even the card number could
> be used for the former.
I may have a very Intel-centric view, but it should be the former, 
identify all streams currently linked. All devices controlled by the 
same HDAudio controller can be linked at any time, providing the list of 
possible streams to link to does help anyone since the information is 
known by default.
However, I've also seen that a lot of non-HDAudio drivers seem to 
provide the ability to link only playback and capture for synchronized 
full-duplex operation. This is a much simpler case than multiple 
playback/capture devices, most serial links (SSI, McBSP, SSP, etc) 
provide such capabilities. Bottom line is that maybe the sync 
information needs to provide both the devices that can be linked and the 
devices currently linked.

Regarding the card #, linking between devices handled by different 
controllers is not supported in hardware, only 32 devices controlled 
with the same SSYNC register can be linked. In addition there are tests 
in the HDAudio code to yank devices with a different card number from 
the group (see azx_pcm_trigger() in hda_intel.c)
-Pierre

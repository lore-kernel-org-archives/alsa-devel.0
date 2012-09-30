From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/2] ALSA: hda: support for wallclock
	timestamps
Date: Sun, 30 Sep 2012 12:12:09 +0200
Message-ID: <50681AF9.8000004@ladisch.de>
References: <1348820142-15822-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1348820142-15822-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <50656F02.5030005@ladisch.de> <5067562D.50704@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 3BE0F2616A4
 for <alsa-devel@alsa-project.org>; Sun, 30 Sep 2012 12:13:18 +0200 (CEST)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id BB2D720645
 for <alsa-devel@alsa-project.org>; Sun, 30 Sep 2012 06:13:17 -0400 (EDT)
Received: from [192.168.42.248] (unknown [176.1.55.215])
 by mail.messagingengine.com (Postfix) with ESMTPA id 11AC94827AB
 for <alsa-devel@alsa-project.org>; Sun, 30 Sep 2012 06:13:16 -0400 (EDT)
In-Reply-To: <5067562D.50704@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
> On 09/28/2012 04:33 AM, Clemens Ladisch wrote:
>> Pierre-Louis Bossart wrote:
>>> @@ -1712,6 +1777,7 @@ static struct snd_pcm_hardware azx_pcm_hw = {
>>>                    /* SNDRV_PCM_INFO_RESUME |*/
>>>                    SNDRV_PCM_INFO_PAUSE |
>>>                    SNDRV_PCM_INFO_SYNC_START |
>>> +                 SNDRV_PCM_INFO_HAS_WALL_CLOCK |
>>
>> ... but not if this device is connected to an S/PDIF input.
>
> Yeah, but I can't figure out what happens here. HDAudio is the clock
> master in all cases

Except for those cases described in section 5.4.3 of the HDA spec.

Finding out whether a device is connected to an S/PDIF input is not easy
and might change dynamically.

It might be easiest to omit HAS_WALL_CLOCK for inputs ...


Regards,
Clemens

From: Rick Mann <rmann@latencyzero.com>
Subject: Re: Unknown PCM cards.pcm.front
Date: Thu, 29 Oct 2015 15:21:24 -0700
Message-ID: <0732364B-9CD1-4CB2-9E5A-DB8AB74EB3D4@latencyzero.com>
References: <14E6E6A6-54AE-4EB5-8106-791B95650733@latencyzero.com>
 <56321547.7080508@ladisch.de>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id A92F72651A5
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 23:21:26 +0100 (CET)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id E94E920661
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 18:21:25 -0400 (EDT)
In-Reply-To: <56321547.7080508@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> On Oct 29, 2015, at 05:47 , Clemens Ladisch <clemens@ladisch.de> wrote:
> 
> Rick Mann wrote:
>> "ALSA lib pcm.c:2217:(snd_pcm_open_noupdate) Unknown PCM cards.pcm.front"
> 
> This means that some code tried to open device named "front", and that there
> is no such definition for your hardware.

Thanks, Clemens,

Here's my code that opens the device:


    int driverID = ::ao_default_driver_id();
    ao_sample_format format = { 0 };
    format.bits = 16;
    format.channels = inNumChannels;
    format.rate = inRate;
    format.byte_format = AO_FMT_LITTLE;
	
    mDevice = ::ao_open_live(driverID, &format, NULL);
    if (mDevice == NULL)
    {
        LogDebug("Error opening output device");
    }

I'm not sure where the change in default device would come from.

-- 
Rick Mann
rmann@latencyzero.com

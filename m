From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH 1/3 v1] ALSA: usb-audio: more tolerant
	packetsize
Date: Thu, 1 Dec 2016 21:53:20 -0800
Message-ID: <58410C50.2090401@mentor.com>
References: <20161130075923.15205-1-jiada_wang@mentor.com>
 <20161130075923.15205-2-jiada_wang@mentor.com>
 <1cb0aa49-62d5-b2ac-a473-bbce3f491d59@ladisch.de>
 <58400B3A.7080806@mentor.com>
 <b869176e-54e4-a47c-98ab-11be08ca0e61@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D59D266539
 for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2016 06:53:30 +0100 (CET)
In-Reply-To: <b869176e-54e4-a47c-98ab-11be08ca0e61@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, Mark_Craske@mentor.com, apape@de.adit-jv.com, tiwai@suse.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello Clemens

On 12/01/2016 04:15 AM, Clemens Ladisch wrote:
> Jiada Wang wrote:
>> On 11/30/2016 11:41 PM, Clemens Ladisch wrote:
>>> Jiada Wang wrote:
>>>> since commit 57e6dae1087bbaa6b33d3dd8a8e90b63888939a3 the expected packetsize is always limited to
>>>> nominal + 25%. It was discovered, that some devices
>>> Which devices?
>> It was a LG nexus
> So it was the Android audio accessory mode.
>
>>>> have a much higher jitter in used packetsizes than 25%
>>> How high?
>> the nominal packet size was somewhere around 176bytes
>> +25% would result in max expected packets to be ~220bytes
>> We observed some packets exceeding this size (256byte)
> 256 bytes per USB frame would correspond to 64 kHz, instead of the
> nominal 44.1 kHz.
>
> The audio accessory sample format is fixed, and that mode is no longer
> developed, so increasing the limit to +50% would be sufficient to work
> around this problem.
>
> I don't know if this is a bug in Google's generic AOA code, or if LG did
> some changes; I have not heard any other report so far ...
>
We also reproduced the same issue with following android devices,
* Samsung S4, Android 4.2.2, model GT-I9505
* Sony Xperia Z, Android 4.2.2, model number CC6603
* LGE Nexus 4, Android 4.2.2
so it most likely not a LG specific issue.

I agree to increase to +50% would be sufficient to avoid this issue.

Thanks,
Jiada


> Regards,
> Clemens

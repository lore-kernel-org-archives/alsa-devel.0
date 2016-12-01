From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH 1/3 v1] ALSA: usb-audio: more tolerant
	packetsize
Date: Thu, 1 Dec 2016 03:36:26 -0800
Message-ID: <58400B3A.7080806@mentor.com>
References: <20161130075923.15205-1-jiada_wang@mentor.com>
 <20161130075923.15205-2-jiada_wang@mentor.com>
 <1cb0aa49-62d5-b2ac-a473-bbce3f491d59@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 45409266619
 for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2016 12:36:28 +0100 (CET)
In-Reply-To: <1cb0aa49-62d5-b2ac-a473-bbce3f491d59@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, linux-kernel@vger.kernel.org, Mark_Craske@mentor.com, apape@de.adit-jv.com
List-Id: alsa-devel@alsa-project.org

Hello Clemens

On 11/30/2016 11:41 PM, Clemens Ladisch wrote:
> Jiada Wang wrote:
>> since commit 57e6dae1087bbaa6b33d3dd8a8e90b63888939a3 the expected packetsize is always limited to
>> nominal + 25%. It was discovered, that some devices
> Which devices?
It was a LG nexus
>
>> have a much higher jitter in used packetsizes than 25%
> How high?  (Please note that the USB specification restricts the jitter
> to at most one frame in consecutive packets.)
the nominal packet size was somewhere around 176bytes
+25% would result in max expected packets to be ~220bytes
We observed some packets exceeding this size (256byte)
which caused the babble and dropping of that packets.

Thanks,
Jiada

>> which would result in BABBLE condition and dropping of packets.
>> A better solution is so assume the jitter to be the nominal packetsize
> This solution is better for this one particular device, but how does it
> affect normal devices, or the Scarlett 2i4 on EHCI affected?
>
>
> Regards,
> Clemens

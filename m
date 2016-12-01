From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 1/3 v1] ALSA: usb-audio: more tolerant
 packetsize
Date: Thu, 1 Dec 2016 13:15:39 +0100
Message-ID: <b869176e-54e4-a47c-98ab-11be08ca0e61@ladisch.de>
References: <20161130075923.15205-1-jiada_wang@mentor.com>
 <20161130075923.15205-2-jiada_wang@mentor.com>
 <1cb0aa49-62d5-b2ac-a473-bbce3f491d59@ladisch.de>
 <58400B3A.7080806@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58400B3A.7080806@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, linux-kernel@vger.kernel.org, Mark_Craske@mentor.com, apape@de.adit-jv.com
List-Id: alsa-devel@alsa-project.org

Jiada Wang wrote:
> On 11/30/2016 11:41 PM, Clemens Ladisch wrote:
>> Jiada Wang wrote:
>>> since commit 57e6dae1087bbaa6b33d3dd8a8e90b63888939a3 the expected packetsize is always limited to
>>> nominal + 25%. It was discovered, that some devices
>>
>> Which devices?
>
> It was a LG nexus

So it was the Android audio accessory mode.

>>> have a much higher jitter in used packetsizes than 25%
>>
>> How high?
>
> the nominal packet size was somewhere around 176bytes
> +25% would result in max expected packets to be ~220bytes
> We observed some packets exceeding this size (256byte)

256 bytes per USB frame would correspond to 64 kHz, instead of the
nominal 44.1 kHz.

The audio accessory sample format is fixed, and that mode is no longer
developed, so increasing the limit to +50% would be sufficient to work
around this problem.

I don't know if this is a bug in Google's generic AOA code, or if LG did
some changes; I have not heard any other report so far ...


Regards,
Clemens

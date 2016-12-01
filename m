From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 1/3 v1] ALSA: usb-audio: more tolerant
 packetsize
Date: Thu, 1 Dec 2016 08:41:17 +0100
Message-ID: <1cb0aa49-62d5-b2ac-a473-bbce3f491d59@ladisch.de>
References: <20161130075923.15205-1-jiada_wang@mentor.com>
 <20161130075923.15205-2-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161130075923.15205-2-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>, apape@de.adit-jv.com
Cc: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mark_Craske@mentor.com
List-Id: alsa-devel@alsa-project.org

Jiada Wang wrote:
> since commit 57e6dae1087bbaa6b33d3dd8a8e90b63888939a3 the expected packetsize is always limited to
> nominal + 25%. It was discovered, that some devices

Which devices?

> have a much higher jitter in used packetsizes than 25%

How high?  (Please note that the USB specification restricts the jitter
to at most one frame in consecutive packets.)

> which would result in BABBLE condition and dropping of packets.
> A better solution is so assume the jitter to be the nominal packetsize

This solution is better for this one particular device, but how does it
affect normal devices, or the Scarlett 2i4 on EHCI affected?


Regards,
Clemens

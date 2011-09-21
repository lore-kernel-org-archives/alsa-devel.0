From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] Remove non-exist device and control from
	snd-ymfpci
Date: Wed, 21 Sep 2011 10:03:59 +0800
Message-ID: <CAN8cciYayPCB9tO35AbCLfDekfUM6ZJpn1WOzXz_Z5d3KWSf-A@mail.gmail.com>
References: <CAN8ccibjZSqiMRg6bO+tSsdTZUNJ3Q6FFEF-sYsLf8np9SSY2A@mail.gmail.com>
	<4E7711BD.9010208@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 09B0B24BDC
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 04:04:01 +0200 (CEST)
Received: by fxe22 with SMTP id 22so1211263fxe.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2011 19:03:59 -0700 (PDT)
In-Reply-To: <4E7711BD.9010208@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/19 Clemens Ladisch <clemens@ladisch.de>:
> Raymond Yau wrote:
>
>> How about device 1 spdif since this card does not have spdif connector ?
>
> How could this be detected?
>
>> what is the difference of capture device 0 and device 3 ?
>
> The default device can mix lots of sources together; the AC'97 device is
> a direct input from the AC'97 codec.
>

ymf724f does not support I2S Zoom Video Input and my ymf724f sound
card does no have digital input

so the function of capture device 0 and device 1 of my ymf724f are the same

and it seem that they can used for recording concurrently and the
vumeter of two instances of arecord  change at the same time


arecord -vv -D hw:0,0 -f cd /dev/null


arecord -vv -D hw:0,3 -f cd /dev/null



Does this mean that it allow two duplex application at the same time
if it can be combined to 2 subdevices

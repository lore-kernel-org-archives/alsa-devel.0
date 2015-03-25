From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: RawMIDI behaviour with MidiFace 4x4
Date: Wed, 25 Mar 2015 22:45:40 +0100
Message-ID: <55132C84.5030506@ladisch.de>
References: <6A72E9C91650BD49A6D9B305755BC04C42D801FA@mbs1.ad.jyu.fi>,
 <54FD5D4C.3040204@ladisch.de>
 <6A72E9C91650BD49A6D9B305755BC04C42D8067A@mbs1.ad.jyu.fi>,
 <54FE14F4.9070704@ladisch.de>
 <6A72E9C91650BD49A6D9B305755BC04C42D80787@mbs1.ad.jyu.fi>,
 <54FEA526.10708@ladisch.de>
 <6A72E9C91650BD49A6D9B305755BC04C42D8CE0F@mbs1.ad.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D4917261ACE
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 22:46:33 +0100 (CET)
In-Reply-To: <6A72E9C91650BD49A6D9B305755BC04C42D8CE0F@mbs1.ad.jyu.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Kalvas, Taneli" <taneli.v.m.kalvas@jyu.fi>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Kalvas, Taneli wrote:
> What is the policy with external contributions for the snd-usb-audio/midi?

See Documentation/SubmittingPatches.

> From my first session with the usb documents ("USB MIDI Devices 1.0")
> and the kernel code I could not find the flow-control for the midi
> interface buffer in either one.

The flow control is implicit in the USB bulk transfer protocol, i.e.,
the device must accept a packet only when it can handle it.  The host
controller hardware automatically retries sending until this succeeds.


Regards,
Clemens

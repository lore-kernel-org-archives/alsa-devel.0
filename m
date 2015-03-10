From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: RawMIDI behaviour with MidiFace 4x4
Date: Tue, 10 Mar 2015 09:02:46 +0100
Message-ID: <54FEA526.10708@ladisch.de>
References: <6A72E9C91650BD49A6D9B305755BC04C42D801FA@mbs1.ad.jyu.fi>,
 <54FD5D4C.3040204@ladisch.de>
 <6A72E9C91650BD49A6D9B305755BC04C42D8067A@mbs1.ad.jyu.fi>,
 <54FE14F4.9070704@ladisch.de>
 <6A72E9C91650BD49A6D9B305755BC04C42D80787@mbs1.ad.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 7FE17261546
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 09:02:48 +0100 (CET)
In-Reply-To: <6A72E9C91650BD49A6D9B305755BC04C42D80787@mbs1.ad.jyu.fi>
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
> This is a common problem with many devices across several brands of
> devices and influences not only Linux but also other systems (see for
> example a list by wabbiguy at http://forum.highlyliquid.com/archive/index.php/t-500.html).

These devices use different firmwares and drivers, and as far as I know,
work flawlessly in Linux.  This appears to be a problem with the Windows
MIDI framework.  (Apparently, it behaves like the ALSA sequencer, i.e.,
drops data when its internal buffer overflows; there is no blocking API
like snd_rawmidi_*.)

> What do you think about a possibility for a customized driver for this
> class of hardware (I mean usb compliant midi interfaces with broken
> output ring buffer)?

Such a customization would be possible.  But it's unlikely that I will
find time in the near future.


Regards,
Clemens

From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC PATCH 01/11] ALSA: implement
	MEDIA_IOC_DEVICE_INFO
Date: Fri, 07 Sep 2012 09:14:30 +0200
Message-ID: <50499ED6.9070805@ladisch.de>
References: <503BF48E.1090100@ladisch.de> <503BF4CD.6000207@ladisch.de>
 <20120907021309.GD6827@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6D04E260745
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 09:14:35 +0200 (CEST)
In-Reply-To: <20120907021309.GD6827@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Tue, Aug 28, 2012 at 12:29:33AM +0200, Clemens Ladisch wrote:
>> +config SND_MEDIA
>> +	bool "Media Controller API (EXPERIMENTAL)"
>> +	depends on EXPERIMENTAL
>> +	help
>> +	  Say Y here to enable the media controller API, which allows to
>> +	  retrieve the internal topology of sound devices.
>
> I think there's a general consensus these days that EXPERIMENTAL is
> pretty meaningless so we probably shouldn't bother with it.

Well, I couldn't claim this to be any less experimental than the
implementation in drivers/media/.  :)

> The text is also a bit confusing, it enables use of the media
> controller API for ALSA devices really.

It's in the ALSA menu.  I could put "ALSA" in the title if it helps.

> I have to say I'm also a bit surprised that there's no core framework
> for media controller and we're open coding ioctl() implementations here,

drivers/media/media-*.c exists, but I did not use that implementation
because someone expressed concern about it being too heavyweight ...

> I'd have thought there would at least be a way of enumerating all media
> controller devices in the system...

It appears userspace is supposed to check all /dev/media* devices.
(Using /dev/snd/controlC* is just a makeshift arrangement; I'll have to
reuse some part of the media device registration framework, or tell udev
to create symlinks.)


Regards,
Clemens

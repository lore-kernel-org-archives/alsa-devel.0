From: Daniel Mack <zonque@gmail.com>
Subject: Re: USB audio devices on Audio 4DJ and similar
Date: Sun, 08 Apr 2012 16:12:13 +0200
Message-ID: <4F819CBD.2010809@gmail.com>
References: <201204062209.21564.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 360B824767
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Apr 2012 16:12:23 +0200 (CEST)
Received: by bkwj10 with SMTP id j10so2821925bkw.38
	for <alsa-devel@alsa-project.org>; Sun, 08 Apr 2012 07:12:21 -0700 (PDT)
In-Reply-To: <201204062209.21564.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Alan,

On 06.04.2012 23:09, Alan Horstmann wrote:
> At present I am involved with resolving some issues that have arisen from 
> people using the Audio 4DJ interface with Portaudio, and I hoped it would be 
> OK to check a few Alsa details with you?  Unfortunately I have limited 
> experience of USB audio.

What are those issues? Can you elaborate?

> Apparently the 4 audio inputs/outputs appear as 2 stereo sub-devices on the 
> first device, rather than a single 4-channel device - is this correct?

Yes.

> Assuming that is correct, does that arise as a result of the intrinsic nature 
> of the interface, or is it by developer choice in the driver (for example so 
> that it can be opened as 2 stereo streams)?   Is there (or could there be) a 
> way to change this, eg by module option or udev rule?  I notice in the source
>     #define CHANNELS_PER_STREAM  2

The device itself implements 4 audio channels which are synced to each
other. In other words: the hardware is not able to only enable one of
them and leave the other ones paused or set sample rates individually.

When I implemented the driver, it seem most logical to follow the way
the device denotes it channels though. The documentation and silk screen
presents them as pairs of stereo, and so the driver does the same thing.

> Is there a way at present that the device can be accessed as a single 
> 4-channel stream other than by creating a custom ~asoundrc with a pcm 
> definition using 'multi' to join the 2 stereo streams?

No, you would need to join them in software. But as all inputs and
outputs share a single clock domain, there won't be any drift between
them that need special attention.

> I don't see any USB audio units having files in /usr/share/alsa/cards; is it 
> not relevant, not normally necessary or something no-one has got round to 
> writing?

For this particular device, there wasn't any need yet.


Daniel

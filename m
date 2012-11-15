From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: USB hardware that supports implicit feedback?
Date: Thu, 15 Nov 2012 22:02:45 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211152158440.2632@xoschi>
References: <p06240805cccafc72f23b@[192.168.1.36]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 483BF26507B
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 22:02:54 +0100 (CET)
Received: by mail-wg0-f51.google.com with SMTP id ed3so836170wgb.20
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 13:02:54 -0800 (PST)
In-Reply-To: <p06240805cccafc72f23b@[192.168.1.36]>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Griscom <griscom@suitable.com>
Cc: Alsa Developer <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi Daniel,

On Thu, 15 Nov 2012, Daniel Griscom wrote:
> I'm having trouble getting implicit feedback working with my custom
> capture/playback USB audio class device, even with the latest kernel. I
> presume it's a problem with my device's configuration, but can't figure out
> exactly what the problem is (after a whole lotta investigation).

What exactly doesn't work?
The "lsusb -v" output from your device might help here.

> Is there any commercial USB hardware out there that supports implicit
> feedback? I assume the ALSA developers are testing against something, but I
> can't find anything appropriate.

I'm not an ALSA dev, but I recently posted a series of patches for the 
M-Audio Fast Track C400, which uses the implicit feedback code that was 
already in the tree for other devices.
Take a look at sound/usb/pcm.c, there are quite a few hints to how this 
is discovered currently.

Cheers,
Eldad

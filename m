From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usbaudio: Support for USB audio v2.0 devices
Date: Mon, 22 Feb 2010 18:40:39 +0100
Message-ID: <4B82C197.1050004@ladisch.de>
References: <1266856137-26252-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 33639103846
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 18:40:44 +0100 (CET)
In-Reply-To: <1266856137-26252-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: =?UTF-8?B?5bKp5LqVIOmahg==?= <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> I've been working on support for USB devices compliant to audio class
> v2.0 and would like to share what I got.

Great!

Just out of curiousity: what device are you testing this with?

> My first step was to clean up most of the existing descriptor parsers
> by moving away from anonymous byte array access to real structs so we
> can see which fields we're actually dereferencing.

Please use the structures in <linux/usb/audio.h>.

> * Supported sample formats are now reported as 32bit bitmap rather than
>   as a fixed value. For now, this is worked around by choosing just one
>   of them.

I'll write a patch to change struct audioformat to use a bitmask.

> Let me know what you think.

Haven't tested yet, but the patches look fine.


Regards,
Clemens

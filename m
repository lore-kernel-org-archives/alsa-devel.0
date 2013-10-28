From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: include/uapi/firewire.h for other firewire drivers
Date: Mon, 28 Oct 2013 09:29:47 +0100
Message-ID: <526E207B.5060301@ladisch.de>
References: <526A6092.4030709@sakamocchi.jp> <526A6C50.2000901@ladisch.de>
 <526B5017.8010106@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 0A3582610A5
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 09:29:49 +0100 (CET)
In-Reply-To: <526B5017.8010106@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
>> Because every device can have settings that should not be changed
>> while streaming.
>
> Currently my Fireworks/BeBoB driver give Control interfaces for these
> settings, like changing sampling rate, switching digital interface.
> The primarry purpose of these is the same, a prevention from stopping
> streaming. The secondary purpose is debug codes for these functionality.
>
> But based on firewire.h interface, it is the applications'
> responsibility, not drivers'. Is my understanding correct?

Yes; the intent is for the kernel driver to handle only those settings
that would be impossible or very difficult to handle with a separate
user space process.  (For example, the sample rate is set by the
application on the ALSA device; it would be a bad idea for the driver to
_ask_ the control panel application to change it.)

> Here some devices has "write-only" settings. For such device, my
> driver remember these settings. If the applications has such
> responsibility, there may be some inconsistency.

This is another example of a setting that must be in the kernel driver.


Regards,
Clemens

From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Missing exactly 3 of 8 audio packets?
Date: Mon, 26 Nov 2012 22:32:31 +0100
Message-ID: <50B3DFEF.9080303@ladisch.de>
References: <p06240816ccd2e5cc9db7@[192.168.1.8]> <50AE99E7.6080008@gmail.com>
 <p06240802ccd72a8f5c3e@[192.168.1.12]> <50B21255.8080202@gmail.com>
 <50B249A6.108@ladisch.de> <p0624080eccd8028e2fa3@[192.168.1.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 011ED2651C3
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 22:32:47 +0100 (CET)
In-Reply-To: <p0624080eccd8028e2fa3@[192.168.1.12]>
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
Cc: Alsa Developer <alsa-devel@alsa-project.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Daniel Griscom wrote:
> At 5:39 PM +0100 11/25/12, Clemens Ladisch wrote:
>> You might want to try to check the
>> frames' status in retire_playback_urb(),
>
> I've looked that function over, but it's not clear where in the
> various structures I'd find the status.

Copy that code from retire_capture_urb().

> if the data is put on the USB bus, but the receiving device (my audio
> card) loses it, there's no way the above will show this?

Isochronous packets have no error handling or reporting, except for the
CRC.  You will see an error report only if it happend before the packet
was put on the bus.  (Which appears to be the case for you.)


Regards,
Clemens

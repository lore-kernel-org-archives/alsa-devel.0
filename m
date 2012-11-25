From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Missing exactly 3 of 8 audio packets?
Date: Sun, 25 Nov 2012 17:39:02 +0100
Message-ID: <50B249A6.108@ladisch.de>
References: <p06240816ccd2e5cc9db7@[192.168.1.8]> <50AE99E7.6080008@gmail.com>
 <p06240802ccd72a8f5c3e@[192.168.1.12]> <50B21255.8080202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id A23D1260202
 for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2012 17:39:19 +0100 (CET)
In-Reply-To: <50B21255.8080202@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Daniel Griscom <griscom@suitable.com>, Alsa Developer <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
>> On 21.11.2012 21:13, Daniel Griscom wrote:
>>> 1) Once in a while (every few seconds or minutes) a single
>>> packet will be missed
>>>
>>> 2) Once in a longer while (every few minutes or hours), the
>>> system will go into a continuing error condition where three of
>>> every eight packets are missed.
> [...]
> This test will tell us whether data is in fact lost before it hits the
> usb audio driver, or if it's dropped by the USB HCD.

These look like hardware errors.  You might want to try to check the
frames' status in retire_playback_urb(), but this will show only DMA/
FIFO problems on the host; the HC will not be able to detect whether the
receiving device has handled the packet.


Regards,
Clemens

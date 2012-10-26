From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Edirol M-16DX workaround found.
Date: Fri, 26 Oct 2012 10:05:01 +0200
Message-ID: <508A442D.7070401@ladisch.de>
References: <20121026012726.GA1683@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0527D2650F0
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 10:05:05 +0200 (CEST)
In-Reply-To: <20121026012726.GA1683@beast>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rick Kirk <arkays.email@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rick Kirk wrote:
> what would be required to enable a clock sync via the USB connection
> between the PC and mixer?

With USB audio, the PCM stream itself can be used as synchronization
source (similar to S/PDIF), but it appears this device does not support
that.

> I have also read that there are other devices that suffer from this
> same fault so there is potential that any fix may apply to more than
> this one device.

Yes, but nobody has found the time to write the code.

At the moment, the USB Audio Class 2.0 code supports a capture stream
as synchronization source for playback, but only for devices where the
descriptors correctly describe this.

> P.S.  I have also requested technical documentation from Roland for
> this device

The problem is entirely lack of time.


Regards,
Clemens

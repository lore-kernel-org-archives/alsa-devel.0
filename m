From: Daniel Mack <daniel@caiaq.de>
Subject: usbaudio: Support for USB audio v2.0 devices
Date: Mon, 22 Feb 2010 17:28:53 +0100
Message-ID: <1266856137-26252-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D23BE103858
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 17:29:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi,

I've been working on support for USB devices compliant to audio class
v2.0 and would like to share what I got.

First problem is that they literally changed every single descriptor
type by adding or removing fields or changing their width,
respectively. Even worse, some enum values were dropped and reassigned
so their numerical value has a different meaning now.

My first step was to clean up most of the existing descriptor parsers
by moving away from anonymous byte array access to real structs so we
can see which fields we're actually dereferencing.

In a second step, I added definitions for the replacement descriptors
and use them at appropriate places. The bInterfaceProtocol field must
always be set correctly of course, otherwise we'll parse garbage.

Other things that have changed from v1.0 to v2.0 are:

* The number of streaming interfaces is now reported by a standard
  interface association descriptor. The old approach using a proprietary
  descriptor extension is deprecated.

* The number of channels per interface is now stored in the AS_GENERAL
  descriptor (used to be part of the FORMAT_TYPE descriptor).

* The list of supported sample rates is no longer stored in a variable
  length appendix of the FORMAT_TYPE descriptor but is retrieved from
  the device using a class specific GET_RANGE command.

* Supported sample formats are now reported as 32bit bitmap rather than
  as a fixed value. For now, this is worked around by choosing just one
  of them. Eventually, the code should propagate the full ability of the
  device.

* A devices needs to have at least one CLOCK_SOURCE descriptor which
  denotes a clockID that is needed as argument to the class request
  command. If can have more than one though and the host driver is in
  charge to choose the right one. There are also new types for clock
  selectors and sample rate converters that a device might report. This
  is all unsupported at the moment. We only parse the first CLOCK_SOURCE
  and take this one.

* Many descriptors (format_type, ...) have changed their layout. Handle
  this by casting the descriptors to the appropriate structs.

With the following patches applied, a v2.0 device is recognized and
reported as ALSA device. I can even hear at least some kind of music,
but the sample rate setting does not yet seem to be correct.

Also, the existing mixer code does not work at all for v2.0 devices.
This will be quite some work to support that and I fear the whole thing
must be reimplemented for v2.0 specifically. For now, I worked around
that by not parsing them at all but bailing out very early.

However, I would like to make sure the changes I made so far won't
cause any regression for v1.0 devices, and so it would be good to see
them applied as a preliminary support. I'll continue working on this
and send more updates along.

Let me know what you think.

Thanks,
Daniel

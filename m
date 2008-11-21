From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa "short read" questions
Date: Fri, 21 Nov 2008 09:30:24 +0100
Message-ID: <492671A0.9000907@ladisch.de>
References: <1227206298.7258.1.camel@pierre-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C6E6C24368
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 09:30:13 +0100 (CET)
In-Reply-To: <1227206298.7258.1.camel@pierre-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre Vanhoucke <pierre.vanhoucke@skynet.be>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre Vanhoucke wrote:
> 1. How is it possible to get a "short read" in blocking mode ?
> I would think that in blocking mode the control is only returned after
> the read is completed.

When an error occurs, you get the data that was read successfully before
the error.  We wouldn't want to throw away this data just because an
error happened later.  (This behaviour is for consistency with other
uses of read(); in the case of audio, throwing away some data wouldn't
actually hurt that much.)

> 2. What are the possible causes for a "short read" ?

Buffer overrun, USB device or SPDIF source unplugged, other errors.

> 3. What can be done to  avoid a "short read" ?

You cannot prevent the user from unplugging a USB device, or the
administrator from suspending your program until the buffer overruns.

> 4. How am I supposed to recover from a "short read"?

Try to read the rest of that data that you wanted to read originally,
then you'll get the error code.  (Or you'll get some data if the error
has vanished, but that is very unlikely.)


Best regards,
Clemens

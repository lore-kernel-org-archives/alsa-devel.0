From: Brad Parker <brad@heeltoe.com>
Subject: force byte-swap at soc level before codec?
Date: Sat, 23 May 2009 06:28:41 -0400
Message-ID: <13717.1243074521@mini>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mini.heeltoe.com (gateway.heeltoe.com [66.134.219.32])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CC0F245BB
	for <alsa-devel@alsa-project.org>;
	Sat, 23 May 2009 12:28:44 +0200 (CEST)
Received: from mini.heeltoe.com (localhost [127.0.0.1])
	by mini.heeltoe.com (8.14.3/8.14.3/Debian-4) with ESMTP id
	n4NASfHJ013722
	for <alsa-devel@alsa-project.org>; Sat, 23 May 2009 06:28:41 -0400
Received: from mini (brad@localhost)
	by mini.heeltoe.com (8.14.3/8.14.3/Submit) with ESMTP id n4NASfer013718
	for <alsa-devel@alsa-project.org>; Sat, 23 May 2009 06:28:41 -0400
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
List-Id: alsa-devel@alsa-project.org


Hi

I'm an ALSA SOC newbie.  I created a new SOC driver for a new ARM chip
but I'm having endian issues at the codec.

I started with the pxa soc code since I am failure with the pxa* i2s
hardware.  The new code is working and data flows fine but due to
hardware constraints the bytes arrive at the codec swapped.

The codec claims S16_LE.  The i2s layer claims S16_LE as does the pcm
layer inside soc.  The source data in user land is S16_LE.  But when the
i2s hardware (which I can't change) does dma the bytes go to the codec
in reverse order.

So, I need a byte swap somewhere.  I verified this by sending constant
data from user land via the oss compat layer (i.e. /dev/dsp).  If I swap
them in userland they come out on the scope at the codec in the correct
order.

Any know the simplest way to do this?

I've tried a bunch of ways but nothing seems to work correctly. It seems like
ALSA already handles this as long as I tell the right thing from below.

-brad

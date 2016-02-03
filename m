From: Andreas =?iso-8859-1?Q?Irest=E5l?= <andreas.irestal@axis.com>
Subject: Can't use adau1361 as i2s master due to bad write
	ordering
Date: Wed, 3 Feb 2016 17:04:23 +0100
Message-ID: <20160203160421.GA21568@lnxandire1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 89E31260694
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 17:04:25 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

I've run into problems using the adau1361 codec (adau1761) as i2s master.

I'm using i2c to set up the codec, and according to the datasheet there
is an enable bit, which must be set in order to be able to access any
other register than the first two registers.

This enable bit is set when the codec enters bias level standby,
however, before entering this bias level, some other registers are
written which will have no effect due to the inner workings of this
codec. Oddly enough, it does ack all writes when measuring the i2c bus.

One of these registers is the serial port 0 register, which
configures the i2s bus. This results in the situation that the CODEC dai
thinks it is running as i2s slave and the CPU dai thinks too as well,
and the bus is dead. Since the other register fields does not change
with our dai configuration, the register never gets physically updated
by an i2c write.

If I reset/reboot the system, which in our case does not power cycle the
codec, the i2s bus is correctly set up and everything works as one would
expect.

So, either the driver behaves incorrectly relying on bias level being
set before any other registers are written, or the underlying subsystem
are behaving incorrectly. We're using the simple-card board driver as it
is sufficient for our needs.

/Andreas

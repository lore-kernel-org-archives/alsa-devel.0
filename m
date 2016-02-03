From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Can't use adau1361 as i2s master due to bad write
	ordering
Date: Wed, 3 Feb 2016 17:25:40 +0100
Message-ID: <56B22A04.1010603@metafoo.de>
References: <20160203160421.GA21568@lnxandire1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-195.synserver.de (unknown [212.40.180.141])
 by alsa0.perex.cz (Postfix) with ESMTP id 6811E260694
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 17:30:03 +0100 (CET)
In-Reply-To: <20160203160421.GA21568@lnxandire1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Andreas_Irest=c3=a5l?= <andreas.irestal@axis.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/03/2016 05:04 PM, Andreas Irest=E5l wrote:
> I've run into problems using the adau1361 codec (adau1761) as i2s master.
> =

> I'm using i2c to set up the codec, and according to the datasheet there
> is an enable bit, which must be set in order to be able to access any
> other register than the first two registers.
> =

> This enable bit is set when the codec enters bias level standby,
> however, before entering this bias level, some other registers are
> written which will have no effect due to the inner workings of this
> codec. Oddly enough, it does ack all writes when measuring the i2c bus.
> =

> One of these registers is the serial port 0 register, which
> configures the i2s bus. This results in the situation that the CODEC dai
> thinks it is running as i2s slave and the CPU dai thinks too as well,
> and the bus is dead. Since the other register fields does not change
> with our dai configuration, the register never gets physically updated
> by an i2c write.
> =

> If I reset/reboot the system, which in our case does not power cycle the
> codec, the i2s bus is correctly set up and everything works as one would
> expect.
> =

> So, either the driver behaves incorrectly relying on bias level being
> set before any other registers are written, or the underlying subsystem
> are behaving incorrectly. We're using the simple-card board driver as it
> is sufficient for our needs.

Hi,

Yes, that sounds like a bug in the driver. We probably need to enable the
clock in the probe() function before we do any other register writes.

- Lars

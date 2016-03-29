From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: ADAU1761 default register value problem
Date: Tue, 29 Mar 2016 15:58:19 +0200
Message-ID: <alpine.DEB.2.02.1603291544160.3594@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 07FCD2605C3
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 15:58:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 9672118144
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 15:58:28 +0200 (CEST)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id IIgWLF01UmJr for <alsa-devel@alsa-project.org>;
 Tue, 29 Mar 2016 15:58:25 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bastet.se.axis.com (Postfix) with ESMTP id 120B9181C6
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 15:58:25 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id F02E515E2
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 15:58:24 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.se.axis.com (Postfix) with ESMTP id E57A21202
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 15:58:24 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
 by seth.se.axis.com (Postfix) with ESMTP id E3DFB61E
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 15:58:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


I have a problem with the ADAU1761 (although the problem I would think =

would manifest itself with a veriety of codecs).

The register values are cached to minimize the number of writes needed, =

and there is a set of default values specified. However, this assumes that =

when the software boots the chip is always in the default state. This is =

not necessarily the case, because the chip has no external reset line and =

resets its internal state using an internal power-on-reset circuit, so if =

the system is rebooted without a power cycle, the regcache will contain =

the default values of the registers, whereas the actual registers in the =

chip will retain their previous values. Hence, if attempting to set a =

value in a register which is in fact identical to the default value, it =

will not be written, and the value that is currently in the register will =

remain. This can lead to all sorts of misconfigurations, depending on the =

previous state of the chip.

One way to fix this is simply to avoid setting up a set of default =

registers (looking at regcache.c, one way seems to be to omit setting the =

reg_defaults and num_reg_defaults members of the struct regmap_config =

during initialization, and instead setting num_reg_defaults_raw to the =

number of registers the chip has, but not setting reg_defaults_raw; I =

don't know if this is how it is intended to be used however). The regcache =

framework will then read all the register values from the chip and use =

them as the new defaults.

While this would seem to be technically correct, the question is if this =

is acceptable? A drawback is that there will be a lot of I2C or SPI =

accesses just to get the default values. Or should the caching behavior at =

startup be configured in some way, for instance via devicetree?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30

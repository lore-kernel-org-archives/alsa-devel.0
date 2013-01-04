From: Robin Gareus <robin@gareus.org>
Subject: Re: draft -- ALSA firewire + digi003
Date: Fri, 04 Jan 2013 14:55:26 +0100
Message-ID: <50E6DF4E.80706@gareus.org>
References: <50E6C858.3050409@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.162])
 by alsa0.perex.cz (Postfix) with ESMTP id 2764C261691
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2013 14:55:30 +0100 (CET)
In-Reply-To: <50E6C858.3050409@gareus.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, damien@zamaudio.com
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Clemens, Hi ALSA-devs,

I'm working with Damien Zammit on the Digidesign-003 driver which is
based on your alsa-kprivate dice code.

We were able to work out most of the issues so far but are now stuck
with timing problems. More specifically: the jitter of async message
timing is quite large and the AMDTP ISO stream has regular drop-outs.

Comparing 1394 data dumps, OSX sends async messages at regular 125
(+-5us) intervals. On GNU/Linux we've seen a delta -40us, + 120us. For
async messages this is not a big deal. But..

Just playing audio via aplay: there are short dropouts every couple of
seconds but otherwise the devices plays fine indefinitely.
Interestingly, when running cyclictest while playing sound: there are
no dropouts but the stream drops after ~10-15 seconds.

Any hints why that may be or how to debug the issue further?

In order to rule out kernel related issues (3.0.0 is quite old), we've
rebased the work (and alsa-kprivate's firewire-kernel-streaming
branch) onto alsa-driver.git. The issue remains the same with 3.2.0-4-rt

Alas, neither of us has detailed knowledge nor specs for AMDTP, not to
mention in-depth knowledge about Linux' firewire stack timings. Any
help or leads are appreciated.

As we believe we are close to a fully functional driver for the 003,
we are very keen to resolve the following two separate issues:

1) The timing problem we have observed with AMDTP over firewire.
2) A framework for the capture stream in ALSA firewire.


The rebased driver code is at
 git://gareus.org/alsa-driver.git
 http://gareus.org/gitweb/?p=alsa-driver.git

The broken-out digi003 driver is available from:
 https://github.com/zamaudio/snd-firewire-003
 https://github.com/x42/003amdtp

1394 bus data dumps of both OSX as well as Linux can be found at
 http://www.zamaudio.com/?p=715


Cheers!
robin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ5t9CAAoJEKCQvOAs9X8ELbsP/Re0wxZKU6v2rbBVhV/FC6zr
JYmx/jAsmoC7vtVZMKE4gGcCreszX58oU7RG323qR9iKSEgXeqtuThZSTT6l3N39
KpHW4T094FyQxmvxRYrZnRlHgWexvLfJT/YiuTUX50L/CKgS75ajRfLqADZaHSy5
Oc+CEy50Jmoi/9/dTuM0pVPVvt5APFqLyAisw1/5wzhYMTHF0mBByn5AHXBp7bIl
SVg7IoJuTNd4dYgo3PtKw9OqhjMGZ1g5DNHA9OaE7qY12r3TMMKm7Sq2iWS4HQoq
RMQLOVtyMOVUKyddK8ubWi0Cm2lYjHUXUNSLyZLcdWYTWbk5eWo6Ze83Tbl33h4T
ngiWt+DWpqKpm+U0UQDOU6p+DSAosKHsVcPPPkYVkwXKAkHctXKlPUst5NHEhhK3
5mbVQECHE9+BBy9qY2eimDZ/p3+5C2kIMofDga6jiuFWfHMqKp30uacUHwP4xY38
jHLaTmpX7VNwNYGnFLvGve709ejNjL8ByFKrUKpV1nAMTO4QP4SipHuApBF3BWS7
hAGBD6mKQAPl6AhvuJaxtCdTQc/tkAF0Ep1LClthsHnyhqPVCX+L5sb/z7vVmCkp
cFxGXJq6TujcW4kkKPfZCNsnHqea8lgY6tEonc8aRmcIZvF+L4Yp+p4/r9OxL6ma
xIIgIVDp1X9HxVayBDWL
=lVsY
-----END PGP SIGNATURE-----

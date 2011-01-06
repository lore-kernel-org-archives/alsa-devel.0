From: Andy Robinson <ajr55555@gmail.com>
Subject: CX20585 - selecting wrong digital output
Date: Thu, 6 Jan 2011 15:55:49 -0500
Message-ID: <AANLkTin7rJUrSyX+Yc=mFA1QcN3PskeGLfe7rtOEd79i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A91824538
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 21:55:50 +0100 (CET)
Received: by gxk21 with SMTP id 21so8033362gxk.38
	for <alsa-devel@alsa-project.org>; Thu, 06 Jan 2011 12:55:49 -0800 (PST)
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

I opened bug 0005235 in the bug tracking system regarding no output
from my laptop's (Asus U50F) mini-TOSLINK jack, even though ALSA was
detecting and providing a SPDIF output device. Using the alsa-info
output, somebody was able to diagnose the issue, and I was able to
confirm the problem. It looks like the CX20585 has two digital
outputs:

Node 0x12 [Audio Output] wcaps 0x611: Stereo Digital
Node 0x21 [Audio Output] wcaps 0x611: Stereo Digital

Since the CX20585 uses the CXT5066 patch in ALSA, node 0x21 is used
for the SPDIF device. However, at least in the case of my laptop, that
digital output is connected to a pin complex which is N/A:

Pin Default 0x400001f0: [N/A] Line Out at Ext N/A

However, node 0x12 IS connected to the optical out jack:

Pin Default 0x034511f0: [Jack] SPDIF Out at Ext Left

So, in this case, ALSA should use node 0x12 instead of node 0x21 for
SPDIF out. I confirmed this with the latest snapshot by changing the
digital output from 0x21 to 0x12, and that solved the problem.

If there are no volunteers that want to take a look at a "real"
solution for this :-), I might take a crack at it myself, but I'm not
all that familiar with the driver right now. There seems to be
different ways this could be handled:
(1) Introduce a model that would use 0x12 instead of 0x21 as the digital output
(2) Check the pin complexes associated with outputs 0x12 and 0x21 to
determine which one is actually connected to a jack, and use that
output as the SPDIF device instead of always choosing 0x21
(3) What if both digital outputs are connected to a valid jack? Should
ALSA then create devices for both? As of now, it's not even creating a
device for 0x12 even though it's a valid audio output.

Any comments or suggestions are welcome.

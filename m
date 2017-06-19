From: Allan Klinbail <aklinbail@gmail.com>
Subject: MIDI Clock issue when aconnect multiple times to same
	device.
Date: Mon, 19 Jun 2017 05:35:16 +0000
Message-ID: <CA+aoAJed7MuQYgG+obkUfNdYkNCh9hwvC7qG55r8yT7HO5FUVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com
 [209.85.213.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 2780F2668F0
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 07:35:28 +0200 (CEST)
Received: by mail-vk0-f44.google.com with SMTP id g66so45838140vki.1
 for <alsa-devel@alsa-project.org>; Sun, 18 Jun 2017 22:35:28 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi All,

I have noticed an issue with the handling of MIDI clock when making
multiple connections to and from the same device..

Specifically with EMAGIC AMT-8 and Unitor 8 Mk2 (I can't confirm it is
happening for other devices).

The scenario is
MIDI Port 1 is receiving MIDI clock along with note information for devices
on ports 2 & 3 ..  (in this scenario sending at 120 BPM)
The MIDI clock signal is automatically distributed by the device to all
other ports.

When connecting Input 1 to output 2 (to send MIDI from the first external
device to the second).. The MIDI clock appears to be retransmitted a second
time.. the device on port 2 then believes it is receiving a clock signal at
approximately 168 BPM. This signal is not stable

When connecting input 1 to output 3  the MIDI clock seems to be distributed
another time to the EMAGIC .. which is now sending out an even more
unstable clock signal at approximate 189 BPM..

It is possible to filter physical inputs from receiving MIDI Clock or
outputs from sending. This does not solve this issue (Filtering the input
stops the clock altogether, filtering the output stops it from being
received by the desired device)

However it is not possible to filter the messaging going to to the unit
from a connection established with aconnect (or using tools like qjackctl).

I am not sure if it is possible to fix the driver for this issue,especially
if the MIDI clock source is external. However, I thought it best to alert
you to this situation.

thanks

Allan

From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Complex hw buffer with MMAP_COMPLEX?
Date: Tue, 09 Oct 2012 15:17:57 +0200
Message-ID: <50742405.9070201@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 35D26261669
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 15:13:52 +0200 (CEST)
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
Cc: Andre Schramm <andre.schramm@iosono-sound.com>
List-Id: alsa-devel@alsa-project.org

Hi!

I'm about to start working on the driver for the new RME MADI FX card
with its 194 input and 196 output channels.

I've noticed that the device has a rather uncommon hw buffer layout.
Let's stick to the input side for the sake of simplicity:

    2ch AES, interleaved
    8ch MADI 001-008, interleaved
    8ch MADI 009-015, interleaved
    [..]
    8ch MADI 184-192, interleaved


On the output side, there is another stereo pair for headphones.

That is, we're dealing with 25 (or 26 for output) interleaved streams
with two or eight channels each.

How could we represent such a layout in ALSA, that is, how are we
talking to userspace? Would one create subdevices and rejoin them via
plughw? Or use MMAP_COMPLEX and then let every application deal with it
on its own? It's certainly not a problem to special-case the MADI FX in
jackd1 and jackd2, but OTOH, this would require other ALSA apps to do
the same (I'm thinking of proprietary custom code).

I wonder if we could afford to rearrange the buffers in the driver and
expose a single non-interleaved buffer to userspace.

WDYT?


TIA

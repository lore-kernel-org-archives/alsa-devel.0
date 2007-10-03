From: pr0t0cod7 <pr0t0cod7@free.fr>
Subject: Intel HDA digital out distortion
Date: Wed, 3 Oct 2007 22:18:46 +0200
Message-ID: <20071003221846.7bc851b9@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by alsa0.perex.cz (Postfix) with ESMTP id C125524534
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Oct 2007 22:18:48 +0200 (CEST)
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 5D8B017B529
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Oct 2007 22:18:48 +0200 (CEST)
Received: from localhost (lib59-2-82-237-111-76.fbx.proxad.net [82.237.111.76])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 2272317B52F
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Oct 2007 22:18:48 +0200 (CEST)
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

Hi,

On Monday 23 July 2007 23:09:24 Ingmar Stieger wrote:

> a couple of weeks ago, I bought an ASUS mainboard with integrated
> Intel
> HDA and an AD1988B codec. Unfortunately, the digital / SPDIF output
> gets distorted with stock 1.0.14 drivers. It does not matter what the
> volume levels of the various mixers are set to.

I have the same issues.

Any sound is distorted through spdif output (seems more pronounced with
low frequencies.)

Sound is not distorted:
 - using passthough (playing AC3)
 - when volume is set to the very minimal (no perceptible distortion)
 - with analog output

My motherboard: ASUS P5B deluxe with integrated soundchip
Kernel: 2.6.22
Alsa: Intel HD audio kernel built module
asound.conf: http://pastebin.com/f2c54b47b

> I think I might have found the source for this problem. Maybe it's
> only a workaround, but it solved the issue and digital out now works
> fine for me, so I thought I'd share.

The patch worked for me, no more distortion :)
Thanks for sharing,
Alex.

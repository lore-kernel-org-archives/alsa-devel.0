From: Luis Henriques <luis.henriques@canonical.com>
Subject: [Regression] No sound on HP Pavilion dv6, STAC92xx
Date: Tue, 26 Jun 2012 15:13:43 +0100
Message-ID: <87d34mtb3c.fsf@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 01BFB104245
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 16:13:46 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, lkml <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

After commit b0791dda813c179e539b0fc1ecd3f5f30f2571e2 ("ALSA: hda/idt
- Fix power-map for speaker-pins with some HP laptops") we have
several bug reports about not having sound on HP Pavilion laptops.

Here's a link to one of these bug reports:

 http://bugs.launchpad.net/bugs/1013183

After reverting the referred commit, everything seems to be working
fine again.

Any ideas/fixes?

Cheers,
--
Luis

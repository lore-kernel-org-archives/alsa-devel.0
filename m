From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: ASoC: sgtl5000: SMALL_POP and loud click noise 5 secs
 after playback stopped
Date: Tue, 7 Jun 2016 00:00:26 +0200
Message-ID: <20160606220025.GA2308@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.pqgruber.com (mail.pqgruber.com [178.189.19.235])
 by alsa0.perex.cz (Postfix) with ESMTP id 11F0A2652AE
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 00:00:28 +0200 (CEST)
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
Cc: Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>, Axel Lin <axel.lin@ingics.com>, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: alsa-devel@alsa-project.org

Hi,

since commit b101acfabc9377469af3abfb7cb63112da367284 I can hear a loud
click / pop noise, always occuring 5 seconds after playback stopped.

Hardware: i.MX6Q board with SGTL5000
Kernel: 4.7-rc2 master

In the commit history of sgtl5000.h I saw that SGTL5000_SMALL_POP was
previously 0 and that Fabio, who changed it to 0, had a similar problem
back then. Now with SGTL5000_SMALL_POP at 1, the problem reappeared.
Changing it back to 0 fixes the problem for me, but as Axel Lin
explained in the commit mentioned above, having 0 as mask leads to not
writing anything to the CHIP_REF_CTRL register and the SMALL_POP bit
stays as it was.

So why does this help?

Maybe having SMALL_POP active causes that noise in some circumstances?
Then we could add a devicetree property to turn it on or off as needed.

Or, the documentation of the SMALL_POP bit in the datasheet is not
correct / inverted? Then we could remove that write to the CHIP_REF_CTRL
register and leave the SMALL_POP bit at its default value?


Axel: Did changing SGTL5000_SMALL_POP to 1 remove a click/pop noise on
your board or did you just notice the error with the mask argument of
snd_soc_update_bits and fixed it?

Thanks,
Clemens

From: Xavier Claessens <xavier.claessens@collabora.com>
Subject: Split a 7.1 device into 4 stereo devices
Date: Tue, 08 Jul 2014 17:18:11 +0200
Message-ID: <1404832691.13359.9.camel@X230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id DB0F226171D
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 17:18:14 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org


Hello,

I have a 7.1 sound device and speaker-test -c8 can output on each
speaker. But what I would like to do is using it as 4 stereo devices so
I could play different sounds on each of them.

Ideally I would like to avoid dmix and friends to be able to have
gapless and bit-perfect output.

On IRC "debianuser" said it is possible with hdajackretask to make it
appear as 4 different hw devices in "aplay -l" but we didn't succeed
doing that. Anyone knows what configuration is needed for that?

Here is my setting:
http://www.alsa-project.org/db/?f=bf0744873d5e6d42d3adc0076c5f66189e9191b7

Regards,
Xavier Claessens.

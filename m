From: Daniel Mack <zonque@gmail.com>
Subject: Connecting two Codecs to the same CPU DAI
Date: Tue, 16 Jul 2013 16:31:01 +0200
Message-ID: <51E55925.5080208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f176.google.com (mail-ea0-f176.google.com
 [209.85.215.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 708B6264F8F
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 16:30:34 +0200 (CEST)
Received: by mail-ea0-f176.google.com with SMTP id z15so420758ead.35
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 07:30:33 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark, Liam,

I'm trying to find a sane solution for systems that have multiple Codecs
connected to the same CPU DAI. An example would be a codec that receives
the same I2S stream as a S/PDIF transceiver, and which is in fact
connected to the very same bus in hardware.

Currently, I'm setting up two DAI links in such cases, and userspace has
to open both subdevices and issue hw_params calls to each of them in
order to set up the hardware correctly.

This is cumbersome of course, and I wonder how the core could be
augmented in order to handle such cases correctly. Ideally, it should
only expose one PCM interface and handle a list of Codecs in the back.

Or am I unaware of an existing feature?


Thanks,
Daniel

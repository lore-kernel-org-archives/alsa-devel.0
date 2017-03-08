From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: DSD native format on SoC
Date: Wed, 8 Mar 2017 08:21:23 +0100
Message-ID: <CAOf5uwm9z+RQ=7_c12cp2_5cM1TZoTCjrXQq6LJ3pr+XczdKLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id D5A63266834
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 08:21:25 +0100 (CET)
Received: by mail-it0-f53.google.com with SMTP id m27so24176515iti.1
 for <alsa-devel@alsa-project.org>; Tue, 07 Mar 2017 23:21:25 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Mail google <adamo.a60@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi

DSD is a continuous stream of bits that flows over two separate
channels, left and right, synchronized by a clock, while I2S is a
single data wire and an additional wire that states if the incoming
sample refers to the left channel or the right channel. There is no
way to get DSD data other than a circuit which decode DSD streams
coming directly from a conventional source, like, for examples, a
SACD.

The Volta dac has an internal decoding circuitry that still employs
the I2S standard as a usual 44100Hz/16 bits, but sourcing the shift
clock at twice the DSD standard frequency of 2.8224MHz, since it has
to split two the16 bits words received on a single wire into the two
DSD channels, as the standard wants.

When DSD is enabled, the control signal PCD/DSD must be high, CK3..CK0
must be all low. The I2S interface works as a standard 44100Hz/16 bit
and the DSD streaming must be packed into 16 bits lenght words
left/right as per LRCK logic. The BCLK frequency supplied from the
interface is 5644800Hz in case of DSD and 11289600 for DSD2.

Can you explain how now DSD can be pass to audio card? The idea is to
declare it on the audio card and then configure it as a PCM card but I
don't know how data are suppose to arrive from alsa userspace.

Michael

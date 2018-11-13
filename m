From: Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Subject: using the softvol plugin with min_dB > 0
Date: Tue, 13 Nov 2018 15:23:53 +0100
Message-ID: <CABDcavZJ6FFHHOdLd90aOObk3GY3HAhAn+DGRFHbmZXjUsPh-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 04B0B267865
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 15:24:07 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id r63-v6so12172458wma.4
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 06:24:07 -0800 (PST)
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

Hi all,

I have a board with a tlv320aic3106 codec and a digital mic. The
tlv320aic3106 does not support hardware gain for the digital mic, so I
am using the softvol plugin to provide this via software.

I would like to setup softvol so that it applies a gain in a range
that goes from approx +10dB to approx +40dB. The problem is that
softvol only accepts negative values for min_dB, i.e. assumes that you
*always* want to do attenuation, and that you might or might not want
to have gain (max_dB can be zero or negative).

Is there any reason for this, or is it just historical ? (I am aware
that the original softvol plugin only supported attenuation, and that
support for gain was added later)

Is it possible to setup softvol to accept a positive min_dB value ?

Best regards,

Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com

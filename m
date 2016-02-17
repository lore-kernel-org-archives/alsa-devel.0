From: Petr Kulhavy <petr@barix.com>
Subject: Codec "virtual multiplexer" representation
Date: Wed, 17 Feb 2016 17:02:47 +0100
Message-ID: <56C499A7.2040202@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D9B926067A
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 17:02:49 +0100 (CET)
Received: by mail-wm0-f52.google.com with SMTP id g62so167770938wme.1
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 08:02:49 -0800 (PST)
Received: from [192.168.11.22] (77-57-117-158.dclient.hispeed.ch.
 [77.57.117.158])
 by smtp.gmail.com with ESMTPSA id di1sm2190526wjc.3.2016.02.17.08.02.48
 for <alsa-devel@alsa-project.org> (version=TLSv1/SSLv3 cipher=OTHER);
 Wed, 17 Feb 2016 08:02:48 -0800 (PST)
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

Hi,

I'm writing an ASoC driver for the  TAS5721 amplifier.
This 2.1 amplifier provides a complex configuration of the audio 
channels (3), PWMs(4) and output(4) mappings.
However only few (about 6) configurations really make sense.

I'm trying to model the output configurations in ALSA. In order to avoid 
a complicated set of switches and multiplexers I would like
to add just one multiplexer like control which selects one of these 6 
output configurations and a callback function which sets the proper
registers accordingly (there are 5 affected registers).

Is there a way to create such a "virtual multiplexer" in ALSA?

Thanks
Petr

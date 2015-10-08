From: Caleb Crome <caleb@crome.org>
Subject: Feasibility of adding alternative audio transport
 besides I2S/PWM/SPDIF, etc
Date: Thu, 8 Oct 2015 08:51:46 -0700
Message-ID: <CAG5mAdwOugskZrHHzeQ-GSu6mAZoN3nybOvupB09FBk2oTwJnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
 [209.85.212.182])
 by alsa0.perex.cz (Postfix) with ESMTP id E6065261B33
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 17:52:05 +0200 (CEST)
Received: by wicgb1 with SMTP id gb1so31837900wic.1
 for <alsa-devel@alsa-project.org>; Thu, 08 Oct 2015 08:52:05 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lu, Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Gautier,
 Bernard" <bernard.gautier@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi All,
   I'm in a constant struggle to bring up many channel audio on each
separate SoC.

I can easily put a microcontroller in place that will collect and
distrubute all the TDM channels to the codecs, and connect the
hardware via an SPI interface to the SoC.

So, instead of:

CODECS <---TDM--->  SoC

It would be

CODECS <---TDM---> uC <---SPI---> SoC

So, my questions are:

* I suspect the SPI interface could be used more universally than each
individual I2S/TDM interface (like FSL SSI vs. Ti McBSP vs. Ti McASP,
etc).  and the SPI port would provide a very common API regardless of
SoC.   Is that true?

* Is it feasible to integrate an SPI transport into the SoC/alsa
layer?  What are the difficulties involved with that?


Cheers,
  -Caleb

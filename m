From: Burton Samograd <burton.samograd@gmail.com>
Subject: Tascam US-366 and Alsa Firmware
Date: Sat, 29 Aug 2015 09:34:49 -0600
Message-ID: <CAM8pOuO60SdbGXBjf645C5obb5uW0MJpH1DFCr8bmO+Y6hWrTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com
 [209.85.213.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 05EB8260671
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2015 17:34:51 +0200 (CEST)
Received: by igcse8 with SMTP id se8so40593405igc.1
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2015 08:34:49 -0700 (PDT)
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

I recently bought the Tascam US-366 and forgot to check for Linux support,
which it doesn't have (yet! :). Looking through the Alsa firmware sources,
there seems to be a firmware loader called usx2yloader which supports a
number of Tascam cards, but the US-366 is not listed.  It looks like really
usx2yloader just needs the firmware and a `prepad` file. I`ve found the
firmware for the card (I think) buried in the OSX firmware download
package:


http://tascam.com/content/downloads/products/789/us-322_us-366_fw_v103_mavericks-yosemite.zip

Now I think I just need the prepad file, but there's little documentation
regarding exactly what that is (I'm assuming a number of 0s just to pad the
firmware image to alignment, but I'm not sure of what alignment).

Any ideas if usx2yloader will work at all with the US-366?  Does anyone
know what the pre-pad file should be/contain?  Has anyone tried to get the
US-366 working yet and failed?

Reference:

     http://tascam.com/product/us-366/

Thanks.

Burton Samograd

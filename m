From: Burton Samograd <burton.samograd@gmail.com>
Subject: Fwd: Tascam US-366 and Alsa Firmware
Date: Tue, 1 Sep 2015 12:04:07 -0600
Message-ID: <CAM8pOuMQBWybctdhfZE-SGHJGx7wQ-FHB81KqbhLvndeyjkx6Q@mail.gmail.com>
References: <CAM8pOuO60SdbGXBjf645C5obb5uW0MJpH1DFCr8bmO+Y6hWrTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f47.google.com (mail-vk0-f47.google.com
 [209.85.213.47])
 by alsa0.perex.cz (Postfix) with ESMTP id A03DC2616F3
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2015 20:04:09 +0200 (CEST)
Received: by vkbc123 with SMTP id c123so61320348vkb.3
 for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2015 11:04:08 -0700 (PDT)
In-Reply-To: <CAM8pOuO60SdbGXBjf645C5obb5uW0MJpH1DFCr8bmO+Y6hWrTg@mail.gmail.com>
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

Resending due to no response the first time:

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

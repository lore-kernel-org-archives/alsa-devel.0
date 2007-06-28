From: "Jan de Mooij" <jandemooij@gmail.com>
Subject: [HDA Intel/STAC92xx] Alsa 1.0.14: error in
	stac92xx_auto_fill_dac_nid
Date: Thu, 28 Jun 2007 16:22:22 +0200
Message-ID: <f25439870706280722nd03700y1441845b81b37b12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D739124420
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2007 16:22:24 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so737876wag
	for <alsa-devel@alsa-project.org>; Thu, 28 Jun 2007 07:22:22 -0700 (PDT)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

I have a strange problem with alsa on Ubuntu Gutsy. If I compile and
install the Alsa 1.0.14 driver, my sound card is not detected, and
sound doesn't work. I also get the following message in dmesg:

[   33.360190] stac92xx_auto_fill_dac_nids: No available DAC for pin 0x15

So the problem seems to be in the stac92xx_auto_fill_dac_nids
function. When I copy that function from alsa 1.0.13 into the 1.0.14
source, everything works okay...

It looks like the function is rewritten for version 1.0.14, but for me
it does not work anymore. I have to do the above steps with each new
kernel update in Ubuntu Gutsy... Therefore I would like to fix it, but
I don't know where to start.

Thanks in advance.

Jan

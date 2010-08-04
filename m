From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: [PATCH v4 0/1] A codec driver for the TI WL1273 FM
	Radio.
Date: Wed,  4 Aug 2010 12:42:58 +0300
Message-ID: <1280914979-21235-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FDAB24588
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Aug 2010 11:43:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, peter.ujfalusi@nokia.com
Cc: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hello,

and thank you for the comments...

Now I've created the patch against the multi component branch.
I haven't been able to test the codec but I thought that it makes 
sense to send the code for review anyway.

Liam wrote:
> Btw, now that we have a naming convention for components how about this
> having a "-radio" or "-fm" device suffix ?

Now the name is set to "wl1273-fm".

Thanks,
Matti

Matti J. Aaltonen (1):
  ASoC: TI WL1273 FM Radio Codec.

 sound/soc/codecs/wl1273.c |  542 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wl1273.h |   40 ++++
 2 files changed, 582 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/wl1273.c
 create mode 100644 sound/soc/codecs/wl1273.h

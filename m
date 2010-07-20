From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: [PATCH RFC 0/1] ASoC: WL1273 FM Radio codes
Date: Tue, 20 Jul 2010 15:41:57 +0300
Message-ID: <1279629718-14903-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 1057C1038EF
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 14:42:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, hverkuil@xs4all.nl, peter.ujfalusi@nokia.com
Cc: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hello.

This is the ALSA part of our WL1273 FM Radio driver. I've sent
the complete driver to the linux-media list for review. But as 
people on that list are not in general ALSA specialists I'm
sending the codec part here. So all comments are welcome.

Thank you,
Matti A.

Matti J. Aaltonen (1):
  ASoC: TI WL1273 FM Radio Codec.

 sound/soc/codecs/wl1273.c |  593 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wl1273.h |   42 ++++
 2 files changed, 635 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/wl1273.c
 create mode 100644 sound/soc/codecs/wl1273.h

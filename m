From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: [PATCH v6 0/1] A codec driver for the TI WL1273 FM
	Radio.
Date: Tue, 17 Aug 2010 14:41:19 +0300
Message-ID: <1282045280-16696-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F5972414A
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Aug 2010 13:41:23 +0200 (CEST)
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

Hello.

I didn't get any comments to the latest patch set. But now I've had
a change to test the codec in multi component environment. I had
to change the get_format function because the number of channels couldn't
be used for determining the format. Also I added a few audio related 
defines to the header file.

Thank You.

Matti J. Aaltonen (1):
  ASoC: TI WL1273 FM Radio Codec.

 sound/soc/codecs/wl1273.c |  553 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wl1273.h |  101 ++++++++
 2 files changed, 654 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/wl1273.c
 create mode 100644 sound/soc/codecs/wl1273.h

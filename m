From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: [PATCH RFC 0/1] ASoC: WL1273 FM: Change error handling.
Date: Fri, 10 Sep 2010 10:41:29 +0300
Message-ID: <1284104490-11226-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A835244A1
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 09:41:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hi.

This patch changes the error handling in the FM radio codec so that
it's always permissible to set the audio routing to the previous value/

B.R.

Matti J. Aaltonen (1):
  ASoC: WL1273 FM Radio: Eliminate unnecessary error return value.

 sound/soc/codecs/wl1273.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

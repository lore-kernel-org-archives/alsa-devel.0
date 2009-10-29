From: Bill Gatliff <bgat@billgatliff.com>
Subject: [PATCH] Add CLKOUT support to wm8731 codec driver
Date: Thu, 29 Oct 2009 10:13:21 -0500
Message-ID: <1256829202-2508-1-git-send-email-bgat@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 543B5245B0
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 16:13:27 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id d23so2300491fga.2
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 08:13:25 -0700 (PDT)
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
Cc: Bill Gatliff <bgat@billgatliff.com>
List-Id: alsa-devel@alsa-project.org

The WM8731 Codec driver lacks support for utilizing the CLKOUT signal
as the I2S master clock.  The following patch adds that support, along
with a few minor whitespace cleanups.

Bill Gatliff (1):
  Add support for CLKOUT to wm8731 codec driver

 sound/soc/codecs/wm8731.c |  155 +++++++++++++++++++++++++++------------------
 sound/soc/codecs/wm8731.h |   20 ++++++-
 2 files changed, 113 insertions(+), 62 deletions(-)

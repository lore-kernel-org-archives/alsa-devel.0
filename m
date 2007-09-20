From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: alsa driver #2234 SoundScape Elite not support
Date: Thu, 20 Sep 2007 12:18:58 +0200
Message-ID: <20070920121858.cfee1420.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.poczta.interia.pl (smtp35.poczta.interia.pl [80.48.65.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BBD72437E
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Sep 2007 12:11:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Chris Rankin <rankincj@yahoo.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I looked into the ALSA bug tracking system and found the bug that SoundScape Elite is not supported by the sscape driver.

I don't know how to contact the reporter of the bug (tjallen) so I am posting here.

I would like to ask the reporter to test the current driver which support VIVO cards. One of changes is delay to wait for codec to be ready (delay suggested by Rene Herman but the OSS code had long waiting loop in the probe function as well).

The current driver could work on the SoundScape Elite. The driver will be released as part of alsa-driver-1.0.15-rc3 in few days.

Regards,
Krzysztof


----------------------------------------------------------------------
Gra - zostan agentem ABW!
Zobacz >>> http://link.interia.pl/f1ba5

From: Jochen Henneberg <jh@henneberg-systemdesign.com>
Subject: Kernel config issue: SND_HDA_RECONFIG depends on
	SND_HDA_HWDEP
Date: Fri, 06 May 2016 17:55:04 +0200
Message-ID: <1462550104.28105.40.camel@maxwell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by alsa0.perex.cz (Postfix) with ESMTP id B8A8A2617A4
 for <alsa-devel@alsa-project.org>; Fri,  6 May 2016 17:55:04 +0200 (CEST)
Received: from [192.168.0.101] ([109.47.3.165]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0Mewsn-1bIpN31Bg9-00OYWR for
 <alsa-devel@alsa-project.org>; Fri, 06 May 2016 17:55:04 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

with kernel 4.5 (and it looks as if this has not changed since then)
the SND_HDA_RECONFIG sysfs entries still show up in the hwdep devices.
Enabling SND_HDA_RECONFIG without SND_HDA_HWDEP is worth nothing, but
the dependency has been removed from Kconfig.
The commits from 13aeaf68 / 'Manage each codec instance individually'
read as if the sysfs entries should show up at the codec
driver but they do not.

Regards,
Jochen

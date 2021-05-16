Return-Path: <SRS0=ObP5=KM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A64C433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 17 May 2021 11:31:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E1D611EE
	for <alsa-devel@archiver.kernel.org>; Mon, 17 May 2021 11:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E1D611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C269C82C;
	Mon, 17 May 2021 13:30:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C269C82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621251067;
	bh=uz12JEUkFl1zk0MKhwqoy7Swq0yIqwlg559U5vqLb64=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=S/DkShrV5zgVsgZScUe+1UHBbHhuiNPdrAW07OSGAOA83a0G2ZB4tqXQPvhYKRFdl
	 BKUGBZksFq8WfCXPqslq+4PsPjOYIB3w0jsfr/dOb0Z0NxqxO1tp7vfgU8FPzrG98d
	 hBt804vmqi18mPmZPdqO5vuPAZdWR0Ov7T9j9PvY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F26AF80169;
	Mon, 17 May 2021 13:30:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96BD8F80217; Sun, 16 May 2021 12:18:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3BCA3F8012C
 for <alsa-devel@alsa-project.org>; Sun, 16 May 2021 12:18:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BCA3F8012C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="NZoYuL4T"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 768AD611CA;
 Sun, 16 May 2021 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621160317;
 bh=uz12JEUkFl1zk0MKhwqoy7Swq0yIqwlg559U5vqLb64=;
 h=From:To:Cc:Subject:Date:From;
 b=NZoYuL4T8pZP0XVsuqpo1xaXga3djUflecwXx5LGut8qbhlW3Y9NzBmiQJpti66iQ
 XEctA9a/tkYn6eIfMFOD23iU2NVyAWENwzAu5GTKImts+lpuYv0eNqgw/CUZ2ZkWss
 fllyfJ2EOkHcmxftZ1iXvAx83SROwJwSmenZXooYhJTuiuJxIyQ+zDnL2KcckWJO3l
 HXjHP9OcKsGcnNSkEPNKSqumMlW9xOUSyWQbW7rfHCgaVLEVCKAvIaHdwvFlEJ1a7n
 T0Jc41mYwmUESpLNWcMxWdQoD+Yw7News+EAAT/i+fb8vmW0PjoNLGp13h2ptdOtyU
 rkJ7P+/53g9gg==
Received: by mail.kernel.org with local (Exim 4.94.2)
 (envelope-from <mchehab@kernel.org>)
 id 1liDr1-003o89-5Z; Sun, 16 May 2021 12:18:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: [PATCH v3 00/16] Replace some bad characters on documents
Date: Sun, 16 May 2021 12:18:17 +0200
Message-Id: <cover.1621159997.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 May 2021 13:30:14 +0200
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Thorsten Leemhuis <linux@leemhuis.info>, netdev@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-acpi@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>, Corentin Labbe <clabbe@baylibre.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-ext4@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Mike Leach <mike.leach@linaro.org>,
 Jean Delvare <jdelvare@suse.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 coresight@lists.linaro.org, Steven Rostedt <rostedt@goodmis.org>,
 rcu@vger.kernel.org, mjpeg-users@lists.sourceforge.net,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 intel-wired-lan@lists.osuosl.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
 linux-media@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The conversion tools used during DocBook/LaTeX/html/Markdown->ReST 
conversion and some cut-and-pasted text contain some characters that
aren't easily reachable on standard keyboards and/or could cause 
troubles when parsed by the documentation build system.

Replace the occurences of the following characters:

            - U+00a0 (' '): NO-BREAK SPACE
            - U+00ad ('­'): SOFT HYPHEN
            - U+2010 ('‐'): HYPHEN
            - U+2217 ('∗'): ASTERISK OPERATOR
            - U+feff ('﻿'): BOM

I'll submit in separate another series to address other character occurrences.

v3:
  - removed curly commas and changed the patch descriptions.
v2:
  - removed EM/EN dashes and changed the patch descriptions.


Mauro Carvalho Chehab (16):
  docs: hwmon: ir36021.rst: replace some characters
  docs: admin-guide: reporting-issues.rst: replace some characters
  docs: trace: coresight: coresight-etm4x-reference.rst: replace some
    characters
  docs: driver-api: ioctl.rst: replace some characters
  docs: driver-api: media: drivers: zoran.rst: replace some characters
  docs: usb: replace some characters
  docs: userspace-api: media: v4l: dev-decoder.rst: replace some
    characters
  docs: userspace-api: media: dvb: intro.rst: replace some characters
  docs: vm: zswap.rst: replace some characters
  docs: filesystems: ext4: blockgroup.rst: replace some characters
  docs: networking: device_drivers: replace some characters
  docs: PCI: acpi-info.rst: replace some characters
  docs: sound: kernel-api: writing-an-alsa-driver.rst: replace some
    characters
  docs: firmware-guide: acpi: dsd: graph.rst: replace some characters
  docs: virt: kvm: api.rst: replace some characters
  docs: RCU: replace some characters

 Documentation/PCI/acpi-info.rst               | 18 ++---
 .../Data-Structures/Data-Structures.rst       | 46 ++++++------
 .../Expedited-Grace-Periods.rst               | 36 +++++-----
 .../Tree-RCU-Memory-Ordering.rst              |  2 +-
 .../RCU/Design/Requirements/Requirements.rst  | 70 +++++++++----------
 .../admin-guide/reporting-issues.rst          |  2 +-
 Documentation/driver-api/ioctl.rst            |  8 +--
 .../driver-api/media/drivers/zoran.rst        |  2 +-
 Documentation/filesystems/ext4/blockgroup.rst |  2 +-
 .../firmware-guide/acpi/dsd/graph.rst         |  2 +-
 Documentation/hwmon/ir36021.rst               |  2 +-
 .../device_drivers/ethernet/intel/i40e.rst    |  6 +-
 .../device_drivers/ethernet/intel/iavf.rst    |  2 +-
 .../kernel-api/writing-an-alsa-driver.rst     |  2 +-
 .../coresight/coresight-etm4x-reference.rst   |  2 +-
 Documentation/usb/ehci.rst                    |  2 +-
 Documentation/usb/gadget_printer.rst          |  2 +-
 .../userspace-api/media/dvb/intro.rst         |  4 +-
 .../userspace-api/media/v4l/dev-decoder.rst   |  2 +-
 Documentation/virt/kvm/api.rst                | 28 ++++----
 Documentation/vm/zswap.rst                    |  4 +-
 21 files changed, 122 insertions(+), 122 deletions(-)

-- 
2.31.1



From: Appalayagari Sreedhar <sreecha01@gmail.com>
Subject: loading firmware to the codec not successful
Date: Tue, 30 Aug 2011 19:19:45 +0530
Message-ID: <CAODvfaHquCrfCdb8ypCcii4UE5vKRzX=_iVhUp-nvNWRCM5YOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 030EB24685
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 15:49:48 +0200 (CEST)
Received: by ywt32 with SMTP id 32so5760984ywt.38
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2011 06:49:46 -0700 (PDT)
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

Hi,

I am working with DM365 custom board the linux kernel version is 2.6.37.

I am working with a cx2070x codec which requires firmware to be
loaded. I have placed the firmware file in the path.

"usr/lib/firmware" it is not working, i am getting the error.

cx2070x_download_firmware(): Firmware cx2070x.fw not available -2
cx2070x_init: failed to download firmware

error -2 indicates file not available. I think the path is not
correct, can you please suggest which path i should place the firmware
file and also any configuration i need to enable in the kernel.

Thank you.

From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Emux hwdep ioctl requests
Date: Mon, 24 Sep 2007 09:43:39 -0300
Message-ID: <5f52f6d70709240543p39ceee18q3c566d64e76a3fcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EF6E248AD
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Sep 2007 14:43:41 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so1194112rvb
	for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2007 05:43:39 -0700 (PDT)
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

Hi,

I'm writing an application for Emux patch loading using asfxload as
reference, and noticed that there are many ioctl request definitions
specified in the application instead of in a system header file.
Should I do the same redefining SNDRV_EMUX_IOCTL_VERSION,
SNDRV_EMUX_IOCTL_LOAD_PATCH, etc. or there are plans to place these in
a common location?

Also it seems that current Ubuntu doesn't have
/usr/include/linux/awe_voice.h, has that been deprecated for some
reason or it's just a bug in the distro?

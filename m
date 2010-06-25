From: Jean-Yves Avenard <jyavenard@gmail.com>
Subject: Detecting if a pcm device is a digital or analog one
Date: Fri, 25 Jun 2010 16:57:11 +1000
Message-ID: <AANLkTinFnfXXikPmn1vGmt2WHQQnhGAzav9nYOvB4Vda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CCFC710384C
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 08:57:12 +0200 (CEST)
Received: by vws11 with SMTP id 11so263112vws.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 23:57:12 -0700 (PDT)
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

Hi there...

I was wondering if there was any way to accurately distinguish between
audio device, if it has an analog or a digital output.

I would prefer not parsing the name (like analog71 is obviously an
analog device, while "hdmi" is digital)

I see that on some devices the IEC958 bit is set, but this doesn't
seem reliable (on another PC, the IEC958 bit isn't set).

Any suggestions would be greatly appreciated...

Thank you
Jean-Yves

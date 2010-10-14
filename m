From: Cem ERGEN <cemergen@gmail.com>
Subject: install 32 soundcards
Date: Thu, 14 Oct 2010 14:14:42 +0000
Message-ID: <AANLkTimxcZO+=9NfS8mYAdGtD8vVg=FCtcvC5_FaeOVK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 76A5D2438A
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 16:15:00 +0200 (CEST)
Received: by qyk8 with SMTP id 8so49845qyk.17
	for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2010 07:14:55 -0700 (PDT)
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

Hello, i've a problem about to install 32 soundcards on my linux server
(centos 5.3) i tried all ways but i fail all times to run 32 soundcards at
the same time. after that i googled on the internet then find the text about
that.  is it possible to run 32 soundcards same time on my server?
if yes how could i do that
thank you for your helps...


- ALSA: Fix limit of 8 PCM devices in SNDRV_CTL_IOCTL_PCM_NEXT_DEVICE When
compiled with CONFIG_SND_DYNAMIC_MINORS the ALSA core is fineto have more
than 8 PCM devices per card, except one place -
theSNDRV_CTL_IOCTL_PCM_NEXT_DEVICE ioctl, which will not
enumeratedevices
> 7. This patch fixes the issue, changing the devices list organisation.

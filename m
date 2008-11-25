From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Build patch failure.
Date: Wed, 26 Nov 2008 09:41:08 +1300
Message-ID: <492C62E4.1090202@audioscience.com>
References: <200811242310.29792.maillist@superlative.org>
	<200811251345.53742.linux@audioscience.com>
	<s5hfxlgr5nq.wl%tiwai@suse.de>
	<200811251400.06736.linux@audioscience.com>
	<s5hd4gkr4am.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id C8CA31037E3
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 21:41:13 +0100 (CET)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KAW002M4PGJZP20@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 26 Nov 2008 09:41:08 +1300 (NZDT)
In-reply-to: <s5hd4gkr4am.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

are the git repositories mentioned below the recommended ones, or only
until git.alsa-project.org alsa-kmirror and alsa-driver become usable again?

I.e. should they be listed here as the preferred ones here
http://www.alsa-project.org/main/index.php/GIT_Server#Occasional_Developers

--
Eliot

Takashi Iwai wrote:
> FYI, the corresponding GIT repos are:
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver-build.git
> 
> Link these two repos via alsa-driver*/utils/setup-alsa-kernel script.
> See INSTALL file in alsa-driver repo for details.
> 
> 
> Takashi

From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: alsa-driver build problem : no lola dir
Date: Wed, 08 Jun 2011 08:40:17 +1200
Message-ID: <4DEE8CB1.7010409@audioscience.com>
References: <4DED623A.3040606@audioscience.com> <s5haaducj94.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E0EA1037FC
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 22:40:22 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LMF00IK9TF5PY30@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 08 Jun 2011 08:40:18 +1200 (NZST)
In-reply-to: <s5haaducj94.wl%tiwai@suse.de>
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

On 07/06/11 17:17, Takashi Iwai wrote:

> Always use my alsa-driver-build.git if you are using sound-2.6 git or
> the latest kernel:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver-build.git

Thanks Takashi, that seems to be working...

> The repos in alsa-project.org are still based on old versions.


For reference, are these the usable combinations?:

alsa-driver + (alsa-kmirror or alsa-kernel)

alsa-driver-build + sound-2.6


alsa-driver's gitcompile prefers sound-2.6 to alsa-kmirror, perhaps this
is wrong?

regards

-- 
Eliot Blennerhassett
AudioScience Inc.

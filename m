From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: [PATCH] Updated alsa-kernel asihpi sources so
 patches are no longer required.
Date: Tue, 06 Jul 2010 08:14:54 +1200
Message-ID: <4C323D3E.9090901@audioscience.com>
References: <1278026680-16267-1-git-send-email-linux@audioscience.com>
	<s5hr5ji1dn4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DFB4103804
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Jul 2010 22:15:01 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0L5300CCGPKVBA10@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 06 Jul 2010 08:14:56 +1200 (NZST)
In-reply-to: <s5hr5ji1dn4.wl%tiwai@suse.de>
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

Thanks Takashi,

On 05/07/10 21:28, Takashi Iwai wrote:
> At Fri, 02 Jul 2010 11:24:40 +1200,
> linux@audioscience.com wrote:
>>
>> From: Eliot Blennerhassett <eblennerhassett@audioscience.com>
>>
>> Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
> 
> Hrm, really these patches aren't needed?


You are right.  I confused myself:

We are dropping support for older kernels from our internal source, so
now I generate alsa-kernel code directly. (where previously our source
looked like patched alsa-driver version)

These patches should remain in alsa-driver to support older kernels.

> The request_firmware() API is definitely incompatible between 2.4
> and 2.6 kernels, so we'd need a fix anyway in alsa-driver build.

regards

Eliot
-- 
Eliot Blennerhassett
AudioScience Inc.

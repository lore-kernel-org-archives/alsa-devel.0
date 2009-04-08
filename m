From: Jon Smirl <jonsmirl@gmail.com>
Subject: skype and old alsa RC4 symbols
Date: Wed, 8 Apr 2009 17:55:02 -0400
Message-ID: <9e4733910904081455u181eecebi31837f490cfd85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f132.google.com (mail-qy0-f132.google.com
	[209.85.221.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 34C94103852
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 23:55:04 +0200 (CEST)
Received: by qyk38 with SMTP id 38so592270qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 08 Apr 2009 14:55:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I would like to run pulseaudio 9.15 contained in this ubuntu
repository since it fixes my problems with S/PDIF
https://launchpad.net/~themuso/+archive/ppa

However, the 32b compatibility library in this build don't work with
skype since it is missing some RC4 obsolete symbols.

jonsmirl@terra:/home/apps/alsa-lib-1.0.19/debian/lib32asound2/usr/lib32$
readelf -W -s libasound.so.2.0.0 | grep
snd_pcm_hw_params_get_channels_min
   174: 0004a970    58 FUNC    WEAK   DEFAULT   12
snd_pcm_hw_params_get_channels_min@@ALSA_0.9
   454: 0004a970    58 FUNC    GLOBAL DEFAULT   12
__snd_pcm_hw_params_get_channels_min@@ALSA_0.9

The 64b library has the missing RC4 symbols.

jonsmirl@terra:/home/apps/alsa-lib-1.0.19/debian/libasound2/usr/lib$
readelf -W -s libasound.so.2.0.0 | grep
snd_pcm_hw_params_get_channels_min
   173: 000000000004ff10    15 FUNC    GLOBAL DEFAULT   12
snd_pcm_hw_params_get_channels_min@@ALSA_0.9.0rc4
   177: 000000000004ff20    31 FUNC    GLOBAL DEFAULT   12
snd_pcm_hw_params_get_channels_min@ALSA_0.9
   462: 000000000004ff10    15 FUNC    GLOBAL DEFAULT   12
__snd_pcm_hw_params_get_channels_min@@ALSA_0.9
jonsmirl@terra:/home/apps/alsa-lib-1.0.19/debian/libasound2/usr/lib$

How do I get the RC4 symbols into the 32 library? I can pull down the
source for this and build without problem. I just can't identify what
needs to be changed to make the symbols appear in the 32b compat lib.

-- 
Jon Smirl
jonsmirl@gmail.com

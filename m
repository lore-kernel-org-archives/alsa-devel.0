From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re-reading alsa-lib configuration when opening sound
	device
Date: Sun, 30 Sep 2018 18:28:13 +0200
Message-ID: <ccfa9b8a-9aae-1dda-d127-d8c7d3efcc94@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 872CD267772
 for <alsa-devel@alsa-project.org>; Sun, 30 Sep 2018 18:28:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id D4F76A1A40B02
 for <alsa-devel@alsa-project.org>; Sun, 30 Sep 2018 18:28:23 +0200 (CEST)
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gBaT_rnnqWGd for <alsa-devel@alsa-project.org>;
 Sun, 30 Sep 2018 18:28:18 +0200 (CEST)
Received: from [192.168.105.12] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id 50847A1A40B01
 for <alsa-devel@alsa-project.org>; Sun, 30 Sep 2018 18:28:18 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am playing with virtual balanced inputs 
https://www.diyaudio.com/forums/pc-based/326747-virtual-balanced-regular-soundcard-linux-results.html 
. For proper functionality it needs a regular recalibration of the 
ttable multiplication coefficients of route plugin in .asoundrc.

The audio stack is alsa -> wine -> Arta measurement software. When I 
stop measuring in arta (without exiting the software), the soundcard 
gets closed - confirmed in /proc/asound/.../hw_params. Now I change the 
ttable coeffs. After re-opening the device (continuing with measurement 
in the running arta instance) the changes in .asoundrc are ignored. I 
have to restart the arta application for the changes to take effect.

When I run e.g. aplay inbetween, it accepts the changes right away. Upon 
continuing in arta, the original ttable coeffs are still loaded for this 
instance.

I understand it is the way wine handles the device somewhere in 
https://github.com/wine-mirror/wine/blob/master/dlls/winealsa.drv/mmdevdrv.c 
.

Please when is the alsa-lib config loaded by the library/application? Is 
there any way to force a config reload from outside?

Would e.g. calling snd_config_update before snd_pcm_open on line 
https://github.com/wine-mirror/wine/blob/master/dlls/winealsa.drv/mmdevdrv.c#L827 
  help? If so, what overhead does it impose? Perhaps I could ask the 
wine guys to consider such change if it worked and required minimum 
overhead.

I very much appreciate any help.

Best regards,


Pavel.

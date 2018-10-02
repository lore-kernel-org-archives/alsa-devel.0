From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Re-reading alsa-lib configuration when opening
 sound device
Date: Tue, 2 Oct 2018 15:52:18 +0200
Message-ID: <6ed2bf2b-76ed-8151-dc75-581080f427c1@ivitera.com>
References: <ccfa9b8a-9aae-1dda-d127-d8c7d3efcc94@ivitera.com>
 <21c1c8da-2635-55a6-dc6e-c868c7b29289@ladisch.de>
 <f4f7d0a2-9fb9-84b0-405a-73a282bb1bdc@ivitera.com>
 <6a927fa3-4a7c-c2bd-9c10-587c53eddbde@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 47EA82678AB
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 15:52:19 +0200 (CEST)
In-Reply-To: <6a927fa3-4a7c-c2bd-9c10-587c53eddbde@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Dne 2.10.2018 v 15:42 Clemens Ladisch napsal(a):
> 
> It checks only the top configuration file.

Thanks. When knowing what to look for, I see the code in 
https://github.com/tiwai/alsa-lib/blob/master/src/conf.c#L3960 .
> 
>> Could I setup ALSA_CONFIG_PATH=$USER/.my_global_alsa.conf as a symlink to
>> /usr/share/alsa/alsa.conf and touch this symlink only?
> 
> No; stat() would return the timestamp of the target.

OK, I will touch the global file instead (no problem with modifying perms).

Again, thanks a lot for your great help.

Best regards,

Pavel.

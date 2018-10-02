From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Re-reading alsa-lib configuration when opening
 sound device
Date: Tue, 2 Oct 2018 13:36:40 +0200
Message-ID: <f4f7d0a2-9fb9-84b0-405a-73a282bb1bdc@ivitera.com>
References: <ccfa9b8a-9aae-1dda-d127-d8c7d3efcc94@ivitera.com>
 <21c1c8da-2635-55a6-dc6e-c868c7b29289@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 3897E267819
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 13:36:41 +0200 (CEST)
In-Reply-To: <21c1c8da-2635-55a6-dc6e-c868c7b29289@ladisch.de>
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



Dne 2.10.2018 v 13:26 Clemens Ladisch napsal(a):
> Pavel Hofman wrote:
>> when is the alsa-lib config loaded by the library/application?
> 
> Whenever a device is opened, alsa-lib checks the timestamp of the alsa.conf file.
 >

  Hi Clemens,

Thanks a lot. Does it concern only /usr/share/alsa/alsa.conf file, or 
the files configured in the config hooks too (/etc/asound.conf, 
/alsa.conf.d/, ~/.asoundrc)? Based on your answer I assume not :-)

 > Touch that file.  If you cannot modify the global configuration file, 
redirect
 > the program to use your own file by setting the ALSA_CONFIG_PATH 
environment
 > variable.

Could I setup ALSA_CONFIG_PATH=$USER/.my_global_alsa.conf as a symlink 
to /usr/share/alsa/alsa.conf and touch this symlink only?

I very much appreciate this great help.

Pavel.

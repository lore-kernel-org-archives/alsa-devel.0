From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re-reading alsa-lib configuration when opening
 sound device
Date: Tue, 2 Oct 2018 15:42:40 +0200
Message-ID: <6a927fa3-4a7c-c2bd-9c10-587c53eddbde@ladisch.de>
References: <ccfa9b8a-9aae-1dda-d127-d8c7d3efcc94@ivitera.com>
 <21c1c8da-2635-55a6-dc6e-c868c7b29289@ladisch.de>
 <f4f7d0a2-9fb9-84b0-405a-73a282bb1bdc@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 88177267889
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 15:42:41 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id AB07E5583699
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 15:42:40 +0200 (CEST)
In-Reply-To: <f4f7d0a2-9fb9-84b0-405a-73a282bb1bdc@ivitera.com>
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

Pavel Hofman wrote:
> Dne 2.10.2018 v 13:26 Clemens Ladisch napsal(a):
>> Whenever a device is opened, alsa-lib checks the timestamp of the alsa.conf file.
>
> Does it concern only /usr/share/alsa/alsa.conf file, or the files configured in the
> config hooks too (/etc/asound.conf, /alsa.conf.d/, ~/.asoundrc)?

It checks only the top configuration file.

> Could I setup ALSA_CONFIG_PATH=$USER/.my_global_alsa.conf as a symlink to
> /usr/share/alsa/alsa.conf and touch this symlink only?

No; stat() would return the timestamp of the target.


Regards,
Clemens

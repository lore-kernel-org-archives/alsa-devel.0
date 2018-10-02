From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re-reading alsa-lib configuration when opening
 sound device
Date: Tue, 2 Oct 2018 13:26:16 +0200
Message-ID: <21c1c8da-2635-55a6-dc6e-c868c7b29289@ladisch.de>
References: <ccfa9b8a-9aae-1dda-d127-d8c7d3efcc94@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F24B2676A7
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 13:26:17 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id F395D55836FB
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 13:26:16 +0200 (CEST)
In-Reply-To: <ccfa9b8a-9aae-1dda-d127-d8c7d3efcc94@ivitera.com>
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
> when is the alsa-lib config loaded by the library/application?

Whenever a device is opened, alsa-lib checks the timestamp of the alsa.conf file.

> Is there any way to force a config reload from outside?

Touch that file.  If you cannot modify the global configuration file, redirect
the program to use your own file by setting the ALSA_CONFIG_PATH environment
variable.


Regards,
Clemens

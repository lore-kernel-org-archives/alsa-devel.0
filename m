From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ioctl(fd, SNDRV_CTL_IOCTL_ELEM_REPLACE,
 ... not working from userspace ?
Date: Mon, 3 Jul 2017 16:29:31 +0200
Message-ID: <a8252c34-c9ac-22d9-589d-ff2af5ea1188@ladisch.de>
References: <c7599ba3-f6c3-bb46-c08d-efff67ca60e9@iot.bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D7E5266B38
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 16:29:34 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 46A365581D2D
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 16:29:33 +0200 (CEST)
In-Reply-To: <c7599ba3-f6c3-bb46-c08d-efff67ca60e9@iot.bzh>
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

Fulup Ar Foll wrote:
> I try to rename existing sound control from userspace.

This is allowed only for user controls, i.e., controls that were added
from userspace.


Regards,
Clemens

From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ioctl(fd, SNDRV_CTL_IOCTL_ELEM_REPLACE,
 ... not working from userspace ?
Date: Mon, 3 Jul 2017 17:10:50 +0200
Message-ID: <4acc2dbc-299b-521e-33c5-1c17d0db0142@ladisch.de>
References: <c7599ba3-f6c3-bb46-c08d-efff67ca60e9@iot.bzh>
 <a8252c34-c9ac-22d9-589d-ff2af5ea1188@ladisch.de>
 <10b9b084-d29d-07ca-1e06-15e255fabf36@iot.bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 81D3426680F
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 17:10:53 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 7E33F558298F
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 17:10:52 +0200 (CEST)
In-Reply-To: <10b9b084-d29d-07ca-1e06-15e255fabf36@iot.bzh>
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Fulup Ar Foll wrote:
> Looking at this code I do not understand why the replace iotcl is refused.

	if (!(kctl->vd[0].access & SNDRV_CTL_ELEM_ACCESS_USER)) {
		ret = -EINVAL;

Kernel drivers do not expect that their own controls change.


Regards,
Clemens

From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: udev rules prefix
Date: Thu, 14 Nov 2013 03:48:32 +0100
Message-ID: <52843A00.2080309@canonical.com>
References: <CABdmW1cQmesQfC2Kwt4CBOJzrVGBdaC2m2KFb4XeQZYhJAzfMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 07964260795
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 03:48:28 +0100 (CET)
In-Reply-To: <CABdmW1cQmesQfC2Kwt4CBOJzrVGBdaC2m2KFb4XeQZYhJAzfMQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ivailo <xakepa10@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/13/2013 09:36 PM, Ivailo wrote:
> Hello,
> 
> the default prefix for alsa-utils is /usr however the udev rules directory
> is /lib/udev/rules.d thus on setups with separate partition for /usr the
> binaries, from /usr/bin and /usr/sbin, will likely not be available during
> the boot process and the udev rule will fail to restore the state.
> 
> I suggest that the udev rules directory follows the prefix or append /usr
> to it to resolve this.
> 
> Cheers!

Hi,

ALSA merely follows what udev dictates, so I think your
question/suggestion is better redirected on the udev (now systemd)
mailinglist. Or potentially that of your distro.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

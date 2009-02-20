From: Florian Faber <faber@faberman.de>
Subject: Re: Hammerfall hdsploader not working in ubuntu 8.10
Date: Fri, 20 Feb 2009 16:14:02 +0100
Message-ID: <1235142842.13319.7.camel@x200.solimage.local>
References: <499EB3A6.8020200@gmail.com>  <499EC779.3060708@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E24C103918
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 16:14:09 +0100 (CET)
In-Reply-To: <499EC779.3060708@klingt.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tim,

> i did experience some `strange' behavior on my hdsp as well, starting a
> few months ago.

It was PulseAudio in his case. hdsploader showed an error message
because the firmware was already present.

> in my case, the hdsp tells me, that the io box is not connected. my
> workaround was to unload/reload the module.
> maybe related to that issue, sometimes, the hdspmixer doesn't read the
> meter values from the interface, giving me the same `hwdep ioctl error',
> you are experiencing with hdsploader (i don't use hdsploader, since it
> is basically obsolete).

Didn't we get to the source of this?


Flo
-- 
Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net

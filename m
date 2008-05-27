From: Florian Faber <faber@faberman.de>
Subject: Re: hdsp rpm support
Date: Tue, 27 May 2008 15:08:32 +0200
Message-ID: <200805271508.32695.faber@faberman.de>
References: <c62722740805260033t68f1ab1cu7ed5908f803fbacd@mail.gmail.com>
	<200805270814.36011.faber@faberman.de>
	<c62722740805270559q6a47d5fq3e3084a995494e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de
	(static-ip-85-25-152-101.inaddr.intergenia.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id B44BC243B9
	for <alsa-devel@alsa-project.org>;
	Tue, 27 May 2008 15:08:17 +0200 (CEST)
In-Reply-To: <c62722740805270559q6a47d5fq3e3084a995494e1@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Martin Tufnel <martin.tufnel@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Martin,

> > The driver itself won't help you since the old user space tools
> > don't know the io box. You wouldn't be able to upload the firmware,
> > adjust the mixer levels etc. (unless you patch the old user space
> > tools, of course).
> I'm sorry, I'm a bit confused here.  You said above that "You have
> IO, you can adjust the input levels, switch standby and disconnect
> the box. So everything works as you would expect it." 

With the hdsp*-tools that are currently part of the alsa-tools suite, 
you cannot control the RPM. Neither can you control a lot of the other 
RME cards. That's going to change with a whole new set of userspace 
tools.

So, if you are curious, I can give you the new driver and a small 
command line program that enables the RPM io box (which is on bypass 
mode by default). Or you wait until I finished the new user space 
tools..


Flo
-- 
Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net

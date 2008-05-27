From: Florian Faber <faber@faberman.de>
Subject: Re: hdsp rpm support
Date: Tue, 27 May 2008 08:14:35 +0200
Message-ID: <200805270814.36011.faber@faberman.de>
References: <c62722740805260033t68f1ab1cu7ed5908f803fbacd@mail.gmail.com>
	<47321.137.248.1.11.1211815832.squirrel@webmail.naturestudies.eu>
	<c62722740805262000i33e9ea00p88bc808ef286732c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de
	(static-ip-85-25-152-101.inaddr.intergenia.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C8B3103839
	for <alsa-devel@alsa-project.org>;
	Tue, 27 May 2008 08:14:24 +0200 (CEST)
In-Reply-To: <c62722740805262000i33e9ea00p88bc808ef286732c@mail.gmail.com>
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

> Just to clarify, given the driver is finished but the user tools are
> still under development, this means that the unit will basically work
> but not have its full functionality - is this correct?

You have IO, you can adjust the input levels, switch standby and 
disconnect the box. So everything works as you would expect it.

> Also, did you use the new patched version of the firmware that Karl
> worked on?

No, it's the original firmware. Why would one want to patch it?

> And, when do you think the driver will be incorporated into the main
> Alsa code branch?

The driver itself won't help you since the old user space tools don't 
know the io box. You wouldn't be able to upload the firmware, adjust 
the mixer levels etc. (unless you patch the old user space tools, of 
course).


Flo
-- 
Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net

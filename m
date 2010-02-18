From: Florian Faber <faber@faberman.de>
Subject: Re: alsamixer crashes with SIGFPE
Date: Thu, 18 Feb 2010 09:51:23 +0100
Message-ID: <4B7CFF8B.7040601@faberman.de>
References: <4B7CFA78.6090104@faberman.de> <4B7CFDE6.5080700@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 60E481038BE
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 09:51:24 +0100 (CET)
In-Reply-To: <4B7CFDE6.5080700@ladisch.de>
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

Clemens,

>> bar_height = ((volumes[c] - min) * volume_height + max - min - 1) / (max - min);
>> value = ((volumes[0] - min) * 100 + (max - min) / 2) / (max - min);
> 
> Thanks.  With which hardware do you see this error?

I tried it with the hdspm driver after seeing all the complaints about
hdsp no longer working with 2.6.32.

Unfortunately cannot look into that as I no longer have hdsp cards around.


Flo
-- 
Machines can do the work, so people have time to think.
public key DA43FEF4          x-hkp://wwwkeys.eu.pgp.net

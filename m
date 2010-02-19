From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsamixer crashes with SIGFPE
Date: Fri, 19 Feb 2010 17:54:07 +0100
Message-ID: <4B7EC22F.9010001@ladisch.de>
References: <4B7CFA78.6090104@faberman.de> <4B7CFDE6.5080700@ladisch.de>
	<4B7CFF8B.7040601@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 5C98C103958
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 17:54:11 +0100 (CET)
In-Reply-To: <4B7CFF8B.7040601@faberman.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Florian Faber <faber@faberman.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Florian Faber wrote:
>>> bar_height = ((volumes[c] - min) * volume_height + max - min - 1) / (max - min);
>>> value = ((volumes[0] - min) * 100 + (max - min) / 2) / (max - min);
>> 
>> Thanks.  With which hardware do you see this error?
> 
> I tried it with the hdspm driver after seeing all the complaints about
> hdsp no longer working with 2.6.32.

That driver does not appear to have any controls where min==max.
Anyway, I've fixed alsamixer.

The hdsp problems are probably caused by the firmware loader change.


Regards,
Clemens

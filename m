From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: namehint: Evaluate more possibilities for hw
	devices
Date: Fri, 1 Oct 2010 14:08:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010011408410.20467@eeebox2.perex-int.cz>
References: <4CA4B6BF.3080503@aknet.ru>
	<alpine.LNX.2.00.1010011332210.20467@eeebox2.perex-int.cz>
	<4CA5CB0D.9030003@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7442E24403
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 14:08:57 +0200 (CEST)
In-Reply-To: <4CA5CB0D.9030003@aknet.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@aknet.ru>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 1 Oct 2010, Stas Sergeev wrote:

> 01.10.2010 15:32, Jaroslav Kysela wrote:
>> I tried to fix this issue in this commit:
>> 
>> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=0244370be695372a05344ac760d624e0b40ec9ea 
>> 
>> Could you confirm?
> No, not confirming the fix. Still the same.
> Is there anything I can do to help with debugging?

This patch should definitely fix it:

http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=c049d48407ff0459ff15e466edeeee6ecff67fcd

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

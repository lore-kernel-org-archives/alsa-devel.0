From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Testers Wanted: OPL3 hwdep loader interface
Date: Mon, 29 Oct 2007 17:51:23 +0100
Message-ID: <47260F8B.5010406@keyaccess.nl>
References: <s5hfxzyoxvf.wl%tiwai@suse.de>	<47223817.7060508@keyaccess.nl>	<472273AC.9020702@keyaccess.nl>	<1193643700.13559.1218328069@webmail.messagingengine.com>
	<s5hir4qnvcr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 297B824430
	for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2007 17:54:35 +0100 (CET)
In-Reply-To: <s5hir4qnvcr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/29/2007 10:06 AM, Takashi Iwai wrote:

> At Mon, 29 Oct 2007 08:41:40 +0100,
> Clemens Ladisch wrote:

>> Several instruments aren't played at all, at least those with program
>> number 40 and up (strings) and 64 and up (saxophones).
> 
> OK, how about the revised patch below to alsa-tools?

Yes, I believe my OPL3 is back to its good ol' horrible self again with that 
version.

Do you by the way know of other, nicer and/or better patches than the 
supplied std and drums? Couldn't find any, at least not in the correct 
format it seems.

[ README ]

> -	sbiload --opl3 std.o3 drums.o3 
> +	% sbiload std.o3 drums.o3

Should the example indeed lose the --opl3?

Rene.

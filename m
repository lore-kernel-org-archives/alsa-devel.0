From: Rene Herman <rene.herman@gmail.com>
Subject: [PATCH 3/4] alsa-kernel: schedule_timeout() fix for
	core/seq/seq_instr.c
Date: Tue, 18 Sep 2007 16:27:36 +0200
Message-ID: <46EFE058.2030300@gmail.com>
References: <46E58D01.9080809@gmail.com>	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>	<46EF18FF.7070906@gmail.com>	<46EF3097.7060300@gmail.com>	<46EF52E4.90401@gmail.com>
	<s5habrkchpa.wl%tiwai@suse.de> <46EFD955.1000601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 39957244EC
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 16:28:36 +0200 (CEST)
In-Reply-To: <46EFD955.1000601@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

On 09/18/2007 03:57 PM, Rene Herman wrote:

Subject was supposed to be as above.

> Well, if you insist, but thought I'd submit is seperately once again. 
> The schedule_timeout() calls in there are so-so, will simply not 
> schedule, but that
> 
>     while (instr->use)
>         schedule_timeout(1);
> 
> loop is dangerous. There's nothing that I can see that's stopping the 
> compiler from turning this into an infinite loop:
> 
>     if (instr->use)
>         while (1)
>             schedule_timeout(1);
> 
> I'll admit I have no idea where this code ends up, but if it's _ever_ 
> used this seems to not be good.
> 
> Ofcourse, feel free to drop on the floor if you really do insist.
> 
> Signed-off-by: Rene Herman <rene.herman@gmail.com>

Rene.

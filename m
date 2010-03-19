From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: Are ALSA io plugins implemented as threads or does
 ALSA use fork() ?
Date: Fri, 19 Mar 2010 16:20:44 +0100
Message-ID: <4BA3964C.4000603@gmail.com>
References: <4BA3882B.4030809@gmail.com>
	<alpine.LNX.2.00.1003191530230.3925@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from keymachine.tbmn.org (mail.tbmn.org [87.118.84.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D8ED2436E
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 16:20:47 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1003191530230.3925@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Fri, 19 Mar 2010, Stefan Schoenleitner wrote:
>> * Are these instances running as separate processes (i.e. fork()) or are
>> they implemented as threads ? How is this implemented internally in the
>> ALSA code ?
> 
> No forks or threads. Both instances will run in one process with the
> audio application. The plugin code must take core how many pcm instances
> are active and send the appropriate communication file descriptors to
> application for select/poll I/O multiplexing.

Thanks for the quick answer, I have a better understanding of the plugin
concept now.

cheers,
Stefan

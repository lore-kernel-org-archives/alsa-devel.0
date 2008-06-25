From: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Subject: Re: Still have choppy audio using 1.0.17
Date: Wed, 25 Jun 2008 15:34:17 -0300
Message-ID: <48628FA9.50502@tet.com.br>
References: <4856C768.1060404@tet.com.br>
	<485952C5.30307@tet.com.br>	<485965B0.9020102@tet.com.br>
	<485A58A1.6040002@tet.com.br>	<48622AF1.3000304@tet.com.br>
	<s5hprq5qz2t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einstein.tteng.com.br (mail.tteng.com.br [201.86.232.130])
	by alsa0.perex.cz (Postfix) with ESMTP id E060B24415
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 20:34:25 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by einstein.tteng.com.br (Postfix) with ESMTP id 9A078DE83DF
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 15:34:16 -0300 (BRST)
Received: from [192.168.0.84] (gserra.tteng.com.br [192.168.0.84])
	by einstein.tteng.com.br (Postfix) with ESMTP id 472B4DE8035
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 15:34:13 -0300 (BRST)
In-Reply-To: <s5hprq5qz2t.wl%tiwai@suse.de>
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

Thanks!!!! I will try that right now!

Takashi Iwai escreveu:
> At Wed, 25 Jun 2008 08:24:33 -0300,
> Gustavo da Silva Serra wrote:
>   
>> If I keep the difference between the playback and capture pointers at 
>> one period, no choppy audio occurs. If the difference is 0, 2 or 5 
>> periods for example, choppy audio will always occur. Any ideas why?
>>     
>
> Through a quick look at the code, it's likely the problem of the
> timing of timer handlers for playback/capture streams.  In the current
> code, the timer handlers are invoked individually.
>
> One possible fix would be to force to synchronize the updates of both
> directions instead of individual timers.  That is, share the same
> timer for the connected streams so that the update order is
> guaranteed.
>
>
> Just my $0.02.
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> __________ NOD32 3217 (20080625) Information __________
>
> This message was checked by NOD32 antivirus system.
> http://www.eset.com
>
>   

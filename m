From: Lieven Moors <lievenmoors@hotmail.com>
Subject: Re: distinguish events based on input ports
Date: Wed, 22 Jul 2009 17:56:05 +0200
Message-ID: <COL110-W1E81C344039186D508894BE1B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from col0-omc3-s4.col0.hotmail.com (col0-omc3-s4.col0.hotmail.com
	[65.55.34.142]) by alsa0.perex.cz (Postfix) with ESMTP id 989B9243CA
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 17:56:55 +0200 (CEST)
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


Clemens Ladisch wrote:
> Lieven Moors wrote:
>   
>> I had a question regarding the use of input(read) ports.
>> What I want to do is distinguish events based on the input port
>> they came through. Since the destination of the event is mostly
>> set to 'broadcast', I cannot extract this information from the event
>> itself.
>>     
>
> Yes you can; when delivering broadcast or to-all-subscribers events,
> ALSA sets the event's destination field to the actual destination.
>
>
> HTH
> Clemens
>
>   
Thanks for confirming that. it was my own silly mistake, because i had
used snd_seq_ev_set_subs before trying to filter...

Sorry for that...

greets,

Lieven

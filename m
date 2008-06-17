From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: hda-intel on Asus M2N-X Plus NVIDIA GeForce
 6100/nForce 430 mobo
Date: Tue, 17 Jun 2008 09:54:16 -0700
Message-ID: <4857EC38.2030502@cox.net>
References: <200806162000.02321.cave.dnb2m97pp@aliceadsl.fr>
	<4856B078.1000002@cox.net>
	<200806162054.12813.cave.dnb2m97pp@aliceadsl.fr>
	<200806171817.03604.cave.dnb2m97pp@aliceadsl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao106.cox.net (fed1rmmtao106.cox.net [68.230.241.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DDF324595
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jun 2008 18:54:19 +0200 (CEST)
In-Reply-To: <200806171817.03604.cave.dnb2m97pp@aliceadsl.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nigel Henry wrote:
> I've CC'd the Alsa-user list on this reply, in case it's usefull to those that 
> arn't subscribed to Alsa-devel.
>
> Anyway sound problem resolved, as below.
>   
>   
[snip]
> I may try some of the model options for the hda intel card, but it seems to be 
> producing sounds ok with the default. Speaker-test just trying left front is 
> strange though.
>   
I don't know if this is related but there has been a problem with the 
ice1724 driver forever
that until you change the volume on boot, only the left channel works.  
Once it has been
adjusted once, it is ok until reboot.  Maybe your driver copied some of 
that ice1724 code
and copied the behavior as well.
> http://pastebin.ca/1049215
>
> Thanks Stan, and all you other folks at Alsa-devel who are working on 
> resolving Alsa driver problems.
>
> Nigel.
>
>   
You're welcome.  Good to hear a success story once in a while. :-)

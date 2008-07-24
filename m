From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: [Fwd:  Filling "Struct snd_dma_buffer" manually]
Date: Thu, 24 Jul 2008 09:45:51 -0700
Message-ID: <4888B1BF.4050109@cox.net>
References: <1216908561.2846.35.camel@dinesh.dua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao107.cox.net (fed1rmmtao107.cox.net [68.230.241.39])
	by alsa0.perex.cz (Postfix) with ESMTP id B3DBC103811
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 18:45:53 +0200 (CEST)
In-Reply-To: <1216908561.2846.35.camel@dinesh.dua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: dinesh <dinesh.dua@coraltele.com>
Cc: ALSA list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

dinesh wrote:
> 
> 
> Hello,
> 
> I am stuck with a problem please help me.
> 
> I have allocated a buffer in ram and i want that if i playback something
> from user end then alsa library exchanges data with this buffer using
> memory  mapping but for this i have to fill a
> 
>  structure  "snd_dma_buffer" in driver code but as i have told i dont
> want to use dma so i have to fill it manually with address of ram
> buffer.
> 
> Please tell me if it is possible if yes then help me.
> 
> Thanks in advance..
> 
> Regards,
> Dinesh Dua
> 

I don't know the part of alsa you are working with so I 
can't answer your question.  But I have some advice.

The list you are posting to is called alsa-devel.  The 
devel stands for development, but it really isn't meant 
for development using alsa, but development of alsa. 
If the developers choose to they might answer your 
question.  Or not.  The other list for alsa is 
alsa-user, and this is for users of the api as well as 
end users of alsa.  Again, you might have luck there 
with your query, or not.

However, your question is very ill formed.  To you your 
problem is immediate and obvious, you understand the 
context, you know all the details.  No one on this list 
does.  You are more likely to get help if you explain 
the context of your question at a higher level.  What 
are you trying to accomplish?  How are you trying to 
accomplish it?  Also put in snippets of code 
illustrating your approach where appropriate.  This 
gives the information someone needs to answer your 
question.  Someone might even be able to give you a 
better way to accomplish what you want to do.  But no 
guarantees, this is a mailing list, no one is required 
to answer.

Your other alternative is to 'use the source'.  All of 
the source for alsa is available, so you can look at 
that source to see if what you want to do is possible, 
and how it would have to be done.  You could probably 
start with a grep of snd_dma_buffer in the library and 
driver source trees.  This will likely bring up many 
hits, but you can then search for other context in 
those hits to find the area of interest.  Then read the 
code to see how it works.

Slightly slower than getting a ready made answer, but 
surer. The code doesn't lie.

From: "Till Crueger" <Till.Crueger@gmx.net>
Subject: Which transfer mode to use
Date: Wed, 14 Oct 2009 13:14:05 +0200
Message-ID: <op.u1setrz8soui26@mail.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 02989103825
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Oct 2009 13:10:46 +0200 (CEST)
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

Hi,

First of all, I am fairly new to this list, as well as sound development.  
So if this list is the wrong place for this question, it would be nice if  
you could point me in the right direction.

I am trying to use ALSA in my OCaml [1] programms. As far as I could see  
there are no well documented bindings to ALSA for this language, so I am  
stuck with writing my own bindings. I have gotten to the point where I can  
open a pcm device with a minimal configuration space on my desktop as well  
as on my laptop. However I am not sure which transfer mode to use, since  
it is hard to see for me, what the advantages and disadvantages would be.  
Here is what I have found out so far.

1. Asynchronous callback:
This method seems to be the best explained by all the tutorials I could  
find, so I am guessing this is the best choice for audio applications.  
However for my purpose this seems hard to do, since the thread which  
contains the callback must never enter the OCaml side of the wrapper. This  
constraint is due to the OCaml garbage collector, which AFAIK would be  
messed up severely. So to use this method I would have to write an extra  
buffer in the C side, to which I write the data from OCaml. Depending on  
the way this buffer is set up -- I was thinking of using a linked list to  
contain all the single packets -- I would have to keep track what part of  
the usage of this buffer to be able to synchronise anything to the sound.  
Not the best choice I as far as I can see.

2. read/write:
So far this seems the best choice. This way I could probably rewrite the  
asynchronous callback method on the OCaml side. For this however I would  
have to figure out after each polling, how much data can be written. I had  
a look at the API documentation and it seems ALSA provides function to get  
this information. However when I had a look at the example sine-wave  
generator [2], those functions were only used by the mmap method. So the  
question would be if this information could still be provided when using  
the read/write method.

3. mmap:
During the research I did for this project I found some posts on the  
portaudio list, that said this method could not be used with all  
soundcards. Also I would have to figure out if the memory layout of the  
data passed from the OCaml side is at all compatible to this method. If it  
is incompatible the use of mmap does not seem to make sense at all.

So far this are the points I have gathered to help me make a choice. As  
you can see I already have a clear preference, but at this point I am  
still not quite sure. I also found some links that hinted at other issues  
that would have to be taken into consideration. For example I found some  
concerns about differences in lattency between these three methods.

So what is your opinion on this. Do you think reintroducing the async.  
callback on the OCaml side would be a good idea, or would you rather use  
the second buffer that is accesible from the OCaml side. As I said, I  
haven't done any real sound development, so I am really new to this.

Thanks for your help,
   Till

[1] OCaml is a functional language developed by Inria.  
http://caml.inria.fr/
[2]  
http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html

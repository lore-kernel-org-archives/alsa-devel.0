From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Moving from OSS to ALSA
Date: Mon, 12 Jan 2004 01:11:43 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401120053050.22195-100000@vaino.wakkanet.fi>
References: <200401120829.54299.lpotter@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200401120829.54299.lpotter@trolltech.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lorn Potter <lpotter@trolltech.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 12 Jan 2004, Lorn Potter wrote:

>>  I am currently looking into rewriting our current OSS sound routines to
>> native ALSA, as it seems OSS will invariably be phased out now that the
>> ALSA driver is distrubuted with the Linux kernel, plus ALSA seems to have a
> Personally, I hope OSS compat will never be phased out. Why? OSS is simple, 
> and concise. If I am writing a simple audio recording/playing app, I can get 
> the job done using OSS code in _much_ less lines of code.

Excuse me!? A major problem of OSS/kernel is that it is _not_ concise.  
Different OSS drivers implement the OSS API slightly differently
(full-duplex, triggering, mmap support). This is a huge pain for the app
developers as you have to verify your app against n+1 different drivers.

With ALSA, when you write an application that works with one card, it is 
very likely that it will work perfectly on all the others too. This is 
made possible by the common alsa-kernel middle layer that is shared by all 
drivers. With OSS, there are n+1 implementations in the kernel of this 
middle level functionality. 

Now the commercial OSS (www.opensound.com) is a different thing. It too 
(like ALSA) provides coherent behaviour across different drivers.

> _Dont get me wrong_, ALSA is great and a lot more powerful than OSS, but it is 
> lacking a simple API. 
> Ever try to write an In/Out volume control mixer in OSS? Ever try to port that 
> same mixer to ALSA? 

Believe me, I agree with you 100% with regards to importance of
simplicity. ALSA still has some complex edges, but is has come a long way.
More documentation, tutorials and example code are still needed, but it
takes time (and volunteers) to create them. I'm sure help is appreciated.

> From what I can gather (alsa seems to be lacking mixer 
> docs/tutorial) , the only way to change the mic input level (alsa), I have to 
> enumerate over every mixer gizmo and check to see if its the mic, and then 
> change it if I think it appears to be the Mic.
[...]
> Using OSS, I can do that in one line.

But that's just one example. ALSA needs to support much more complex mixer
configurations than OSS, and this of course comes with a price. 

It is very difficult to try to hide all this complexity from the developer
without in the end limiting what the developer can do. So it's a question
of finding out a good balance between what can be done and how easy it is.
I guess currently ALSA is still too much on the complex side, but slowly
the correct balance will be found... So your input is very much 
appreciated, but at the same time, please don't lose hope just yet. :)

--
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html

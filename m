From: Lorn Potter <lpotter@trolltech.com>
Subject: Re: Moving from OSS to ALSA
Date: Mon, 12 Jan 2004 11:15:05 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401121115.05195.lpotter@trolltech.com>
References: <Pine.LNX.4.44.0401120053050.22195-100000@vaino.wakkanet.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0401120053050.22195-100000@vaino.wakkanet.fi>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 12 January 2004 9:11 am, Kai Vehmanen wrote:

> Now the commercial OSS (www.opensound.com) is a different thing. It too
> (like ALSA) provides coherent behaviour across different drivers.

I guess this is what I am talking about, really.


> > _Dont get me wrong_, ALSA is great and a lot more powerful than OSS, but
> > it is lacking a simple API.
> > Ever try to write an In/Out volume control mixer in OSS? Ever try to port
> > that same mixer to ALSA?
>
> Believe me, I agree with you 100% with regards to importance of
> simplicity. ALSA still has some complex edges, but is has come a long way.
> More documentation, tutorials and example code are still needed, but it
> takes time (and volunteers) to create them. I'm sure help is appreciated.

The problem here is, the people writing docs/tutorials need in depth knowledge 
of how this all works. And unfortunately, the best people to do this are the 
developers themselves. 


> But that's just one example. ALSA needs to support much more complex mixer
> configurations than OSS, and this of course comes with a price.
>
> It is very difficult to try to hide all this complexity from the developer
> without in the end limiting what the developer can do. So it's a question
> of finding out a good balance between what can be done and how easy it is.
> I guess currently ALSA is still too much on the complex side, but slowly
> the correct balance will be found... So your input is very much
> appreciated, but at the same time, please don't lose hope just yet. :)

Oh, I havent lost hope at all. I am very excited about ALSA nearing version 1.

I don't want to limit what alsa can do, only have access to a simple-ized part 
of the API, that's fast and easy for developers to write.  Which is what I 
view the OSS compat. to be.

I work with embedded devices, and so I am always thinking of ways to optimize 
the code and make apps smaller, which also means writing more app with less 
code.



> --
>  http://www.eca.cx
>  Audio software for Linux!

-- 
Lorn 'ljp' Potter
Qtopia Community Manager
lpotter at trolltech.com



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html

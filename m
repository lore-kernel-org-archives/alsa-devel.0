From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Why do I get broken pipe on write to a pcm in   statePREPARED?
Date: Mon, 16 Sep 2002 22:14:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209162014.g8GKEc014124@d1o87.telia.com>
References: <Pine.LNX.4.33.0209131137140.521-100000@pnote.perex-int.cz> <s5h4rcqtdoy.wl@alsa2.suse.de> <3D863177.51DB8C79@libero.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D863177.51DB8C79@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Monday 16 September 2002 21.31, you wrote:
> I think that the best behaviour is the current and it's also the
> simplest to describe and to understand: poll/select never blocks when
> there is nothing to wait.
>
> ... and in PREPARED state definitely there's nothing to wait from
> sound card.

I don't agree. To a beginner which has never seen a unix system before, 
this might be the case. For anyone that has programmed with file 
descriptors before, this behaviour appears broken, and is therefore 
harder to understand.

Also, as we have noted, there is no real use for the current behaviour 
(at least no-one has said what it is), while there is use for the 
proper work-as-all-other-file-descriptors behaviour.

* It behaves as programmers expect it to behave
* It simplifies multi-threaded programming

If you don't agree to the first, just make a poll of the following:

"If the sound card output buffer is full of data, and it is not 
running, what would happen if you poll that file descriptor for writing"

1) it will block, because it is not ready for writing
2) it would not block, because it would then block forever

and then 

"If you write to a non-blocking sound card output file descriptor, but 
the buffer is full, and the sound card is not running, what will then 
happen?"

1) it will return with errno set to EAGAIN, because it is not ready for 
   writing
2) it will return with errno set to EPIPE, because there is a buffer
   overflow

If you ask experienced programmers these questions, which has no prior 
knowledge to alsa or at least not this particular subject, I can assure 
you that the answers will be 1) on both questions. The current 
behaviour just seems broken.

It makes sense to block, there may be another thread, or even another 
process starting the sound card. And it makes sense to return EAGAIN 
when writing to a non-blocking socket when it is not ready to accept 
data.

You might be right that the current behaviour is easier to understand 
for a beginner, but what will the beginner then expect from all other 
file descriptors? It's just confusing. I think it is wise to try to 
stick with established behaviour when possible, and only invent some 
own when necessary. In this case, the own behaviour does not even have 
any real function.

In conclusion, I advice you to change the behaviour to what we as 
programmers expect, and sometimes program for. I would very much 
appriciate it, and I'm sure others will as well

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Tim Goetze <tim@quitte.de>
Subject: Re: Why do I get broken pipe on write to a pcm in  
 statePREPARED?
Date: Tue, 17 Sep 2002 00:04:35 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209162345440.584-100000@summer.quitte>
References: <3D8638F6.AC6DE0C2@racine.ra.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D8638F6.AC6DE0C2@racine.ra.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abbagnara@racine.ra.it>
Cc: Abramo Bagnara <abramo.bagnara@libero.it>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Abramo Bagnara wrote:

>> >I think that the best behaviour is the current and it's also the
>> >simplest to describe and to understand: poll/select never blocks when
>> >there is nothing to wait.
>> >
>> >... and in PREPARED state definitely there's nothing to wait from sound
>> >card.
>> 
>> you know that linux supports multi-threading, don't you?
>
>Oh, yes... and easy message passing between threads too.
>
>You get the point now?
>
>The usual rule of thumb is: "don't make in kernel space what is feasible
>in user space"

if you really believed in this rule, i'd expect you to start work on
moving the sequencer out of ring 0 asap. ;)

let's imagine:

* a single-threaded app. if the coder omits starting the stream before
poll, he'll quickly find out that nothing is played/recorded, and that
poll will hit the timeout, and consequently revise his code logic.

* a multi-threaded app. it is *very* convenient not to do the 'easy'
message passing for starting/stopping streams in many, many
applications. all you have to do in the 'engine' thread is poll and
process. i wonder if you can imagine how much easier things get when
things work this way.

and, afaict, fixing the behaviour actually removes code from the poll
logic in kernel.

i mean, alsa is great, but why do you have to make it a pita to code
for?

tim



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

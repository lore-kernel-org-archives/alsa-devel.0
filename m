From: Tim Goetze <tim@quitte.de>
Subject: Re: Why do I get broken pipe on write to a pcm in  
 statePREPARED?
Date: Mon, 16 Sep 2002 21:49:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209162148140.584-100000@summer.quitte>
References: <3D863177.51DB8C79@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Abramo Bagnara wrote:

>Takashi Iwai wrote:
>> 
>> At Sun, 15 Sep 2002 19:56:59 +0200,
>> Abramo Bagnara wrote:
>> >
>> > Jaroslav Kysela wrote:
>> > >
>> > > I think that the current behaviour of write() is ok, the behaviour of
>> > > poll() might be "fixed". I see advantages for both. I would prefer to have
>> > > this configurable to satisfy multi-threaded applications. We can put a new
>> > > variable to sw_params.
>> >
>> > Implementing that specific behaviour for poll I've paid most attention
>> > to efficiency issues.
>> >
>> > Consider that if you choose a differente behaviour for poll you're
>> > forced to check for xruns (i.e. enter kernel space) just before *every*
>> > poll!
>> 
>> well, the origianl question was the behavior of poll at the prepare
>> (and pause) state, so the theme has nothing to do with xruns (it
>> cannot happen :)
>> 
>> the behavior of poll at other states should be as well as before.
>> 
>
>I think that the best behaviour is the current and it's also the
>simplest to describe and to understand: poll/select never blocks when
>there is nothing to wait.
>
>... and in PREPARED state definitely there's nothing to wait from sound
>card.

you know that linux supports multi-threading, don't you?

;) tim



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

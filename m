From: Tim Goetze <tim@quitte.de>
Subject: Re: Why do I get broken pipe on write to a pcm in
 statePREPARED?
Date: Mon, 16 Sep 2002 15:18:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209161511250.584-100000@summer.quitte>
References: <s5h4rcqtdoy.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4rcqtdoy.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Abramo Bagnara <abramo.bagnara@libero.it>, Jaroslav Kysela <perex@suse.cz>, Anders Torger <torger@ludd.luth.se>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Sun, 15 Sep 2002 19:56:59 +0200,
>Abramo Bagnara wrote:
>> 
>> Jaroslav Kysela wrote:
>> > 
>> > I think that the current behaviour of write() is ok, the behaviour of
>> > poll() might be "fixed". I see advantages for both. I would prefer to have
>> > this configurable to satisfy multi-threaded applications. We can put a new
>> > variable to sw_params.
>> 
>> Implementing that specific behaviour for poll I've paid most attention
>> to efficiency issues.
>> 
>> Consider that if you choose a differente behaviour for poll you're
>> forced to check for xruns (i.e. enter kernel space) just before *every*
>> poll!
>
>well, the origianl question was the behavior of poll at the prepare
>(and pause) state, so the theme has nothing to do with xruns (it
>cannot happen :)
>
>the behavior of poll at other states should be as well as before.
>
>> Sincerely I think this is a stupid approach and I doubt that making it
>> conditional is a smarter idea.
>
>agreed here.

i can't say i understand precisely what you agree on here. what i see
is that so far every now and then somebody writes to this list puzzled
at how poll can return immediately from polling a pcm stream that is
not running.

if you don't think this behaviour is broken then *please* update the
documentation, and clearly state how and why the poll implementation
handles things like it does.

tim



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

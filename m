From: "Jan P." <jipekau@yahoo.com>
Subject: xruns, numlock, and threads
Date: Tue, 26 Feb 2002 23:09:57 -0800 (PST)
Message-ID: <20020227070957.35300.qmail@web9103.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E16cR6o-00020K-00@usw-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: jackit-devel@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi folkx-

developing my looping application, i noticed a couple
of things:

1) adding a thread to a jack application while it is
active causes a big (~15ms) xrun.

2) pressing numlock, capslock, or scrollock causes a
big (~9ms) xrun.

this is running 2.4.18-pre6 with LL patch and alsa
0.9.0beta10, jack cvs as of about a month ago.

btw paul, using the cvs jack instead of the old 0.4.7
that was on the jack page fixed the problems i was
having with my ac97 crashing at low buffersizes... 

besides the above cases, i still get the occasional
xrun (always short, within 1-2 samples of the fragment
size). but nothing totally poops the system out. i
suspect these shorty xruns are coming from the poopy
ac97. 

i solved the problem with threads by changing my
design so that i create all threads before i start
processing. its not that big a deal, its just that my
memory allocation manager which handles preallocating
blocks for recording needed to be shuffled around.

as for the numlock thing, totally weird. i wonder if
its a RH7.1 console thing... anyway, as it is, im
psyched to have  lowlatency fullduplex audio FX on my
$300 computer with a consumer sound card.


best,
yon


__________________________________________________
Do You Yahoo!?
Yahoo! Greetings - Send FREE e-cards for every occasion!
http://greetings.yahoo.com

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

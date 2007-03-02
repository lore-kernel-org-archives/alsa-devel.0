From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Bridging captured stream to playback stream
Date: Fri, 2 Mar 2007 16:49:13 -0500
Message-ID: <75b66ecd0703021349i303f18e2l34de37c3b8e695e4@mail.gmail.com>
References: <9c1cad6e0703020822g88eae6bq4a2943db42101b2@mail.gmail.com>
	<75b66ecd0703020844v1bba0dbax4dbf6a4273e792aa@mail.gmail.com>
	<f2b55d220703021259h2b96dc2em822047902e836cd@mail.gmail.com>
	<9c1cad6e0703021312n2fe8b370ibb2aec1c607e8971@mail.gmail.com>
	<75b66ecd0703021324q39c4d765ge487293ec39fa90e@mail.gmail.com>
	<f2b55d220703021330l50ca4f4ej8fa7cd86f57ef38b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <f2b55d220703021330l50ca4f4ej8fa7cd86f57ef38b@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 3/2/07, Michael K. Edwards <medwards.linux@gmail.com> wrote:
> On 3/2/07, Lee Revell <rlrevell@joe-job.com> wrote:
> > nice -n -20 arecord | nice -n -20 aplay should work also...
>
> Actually, no, it doesn't.  Negative nice levels are no substitute for
> SCHED_FIFO priority -- not if you care about controlled end-to-end
> latency.
>
> > Of course you have to pass additional arguments to aplay and arecord
> > to set the format (-f cd or -f dat) as they default to 8Khz mono.
>
> Sample aplay -C | aplay -P incantation posted along with the
> sched_fifo patch a week or so ago.

Your patch is useful but not mergeable as is.  Can you please remove
the stdout->stderr stuff, add a command line switch to make SCHED_FIFO
optional rather than setting it unconditionally, to accept the RT
priority as an argument rather than hardcoding it, and to check the
return value of sched_setscheduler()?

Lee

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

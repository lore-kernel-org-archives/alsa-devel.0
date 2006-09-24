From: "enrico_groups@libero.it" <enrico_groups@libero.it>
Subject: Re: [Alsa-user] USB card @48kHz only: at what layer to
	resample?
Date: Sun, 24 Sep 2006 23:48:05 +0200
Message-ID: <J649W5$DBADF2C416041073C113A1B7F4D6A2F5@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: rlrevell <rlrevell@joe-job.com>
Cc: alsa-user <alsa-user@lists.sourceforge.net>, mrechberger <mrechberger@gmail.com>, alsa-devel <alsa-devel@lists.sourceforge.net>, stk <stk@ccrma.stanford.edu>
List-Id: alsa-devel@alsa-project.org

Hi Lee,

> You just need to patch STK to allow plughw devices to be used, or give
> up and run at 48Khz.  There's no other solution.

Thanks for the concise and clear answer.

I decided to change my code and run at 48kHz.

I am now facing a new problem.  If I run at 48kHz with the old soundcard everything works fine.  If I switch to the Terratec I get quite some problems.  The system slows down a lot, things got better switching the module param nrpacks=1 and making the buffer larger, but it still clicks and the system is still very slow.

I am currently using the blocking version of the STK real-time audio classes.  Despite the fact that I have them in a separate threads, the new card is slowing also the other threads.  Shall I consider switching to the non-blocking callback methods?  If so, why?

What else shall I look at to make my system perform normally?

I'll be happy to provide more info if that helps.

Thanks,
Enrico




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

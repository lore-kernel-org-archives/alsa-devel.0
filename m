From: Mark Knecht <markknecht@attbi.com>
Subject: Re: HDSP 96/52
Date: 27 Apr 2003 07:00:34 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1051452034.3415.15.camel@localhost.localdomain>
References: <20030427080603.GB641@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030427080603.GB641@always.joy.eth.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joshua N Pritikin <vishnu@pobox.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-04-27 at 01:06, Joshua N Pritikin wrote:
> Mark Knecht wrote:
> > I'm getting a lot of reasonable or even good results, but no actual
> > audio unfortunately.
> 
> Me too.  The driver loads fine.  hdspconf works great.  My A/D
> converter is happy.  i tried running the following script to
> set all the mixer levels to unity.
> 
> for dest in $(seq 0 26);do
>   for i in $(seq 0 51);do
>     amixer cset numid=5 $i,$dest 32768 > /dev/null;
>   done
> done
> 
> However, i've never gotten any audio through the card.  Only silence.
> If there is any patch available then i'm happy to test it.

Joshua,
   No, there is no patch or fix for this yet that I know of. Paul Davis
did write early in the week (4/22) he was going to work on it that day
or the next, but I haven't heard of anything posted yet.

   As a check, does you card identify itself this way:

[root@localhost root]# lspci
<SNIP>
00:0e.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall
DSP (rev 68)

   I'm most interested in what revision you have? 68?

   Anyway, I share your frustrations, but I've pretty much given up.
It's been months now since I've had any Alsa working. Linux is now just
an email environment for me. So much for taking advice on which card to
buy!! ;-)

Cheers,
Mark



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

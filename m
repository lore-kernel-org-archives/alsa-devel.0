From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: cs46xx sound quality and CD volume
Date: Sun, 13 Oct 2002 10:22:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA92D58.4090603@cucumelo.org>
References: <E180JU9-0004lc-00@usw-sf-list2.sourceforge.net> <20021012223943.GA8862@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Bob McElrath <bob+alsa-devel@mcelrath.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>So I'm using 0.90pre3 right now with the new DSP code, and it does
>something different-strange.  When I first insert the module everything
>sounds great, but if I unmute the IEC958, I get a constant tone in my
>speakers (~3 kHz, I'm guessing) and anything which tries to play PCM
>audio just hangs.
>  
>
That is a problem not related to the "CD Volume" that should be fixed by 
now.
The  "~3 kHz sound" that you are talking about usually happen when
the DSP hangs and it leaves some junk left in the HW FIFO.

I think you should try latest CVS.

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

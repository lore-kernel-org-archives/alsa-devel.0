From: Shayne O'Connor <forums@machinehasnoagenda.com>
Subject: Re: emu10k1 driver broken in CVS
Date: Wed, 16 Mar 2005 15:48:40 +1100
Message-ID: <4237BAA8.3020405@machinehasnoagenda.com>
References: <1110947679.19739.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110947679.19739.3.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>With current ALSA CVS and the following hardware (an old SBLive
>platinum):
>
>0000:00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 05)
>        Subsystem: Creative Labs CT4760 SBLive!
>
>the emu10k1 driver locks up the machine as soon as you try to play
>anything.  I tried both JACK and aplay.  I am doing a binary search to
>find the problem.
>  
>
i had the same sort of problem with alsa cvs earlier on today, with my
son's computer (i think it's exactly the same card you describe, Lee) ...

after compiling, i tried inserting the alsa modules and got a whole
bunch of errors ... when rebooting back into xfce4.2, it just froze at
the splash screen ... had to boot into an earlier kernel and re-install
the Planet CCRMA alsa modules.

shayne


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

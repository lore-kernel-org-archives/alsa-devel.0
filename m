From: Philip Thiem <ptt@umr.edu>
Subject: Re: Opl3 Yamaha7xx Answered
Date: Tue, 08 Oct 2002 17:18:27 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <35550000.1034115507@werg>
References: <9030000.1033964713@werg> <s5hofa52q6i.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hofa52q6i.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi,

I was going to send this message:

>Thank you very much for your response, I appreciate the help.
>I turned AUX up, but that doesn't seem to have helped.
>
>I've also taken the opportunity to update my system info textfile.
>Overview of changes:
>        * latest CVS stuff
>        * verbose-printk and debug=full are compiled in
>        * cleaned up my startup to use a stock init.d script
>        * extra modprobes and opl3 patches now loaded in
>          /etc/alsa.d/ymfpci
>        * aux turned up all the way
>        * included a test program I wrote to use the
>          /dev/dmfm interface.
>
>        http://www.icequake.net/~witwerg/ymfpci.txt
>
>Thanks to all,

However, I got an urge to kernel hack and added a mixer for
the FM synth.  I also tried to make sure that the ioport for
volume wasn't being written to or read from, if the card didn't
have fm enabled.  However, it works!  I have fm synth now.
The following is what `cvs diff` outputs in regards to the
alsa-kernel directory.  If the patch isn't in a usable format,
one might have to tell me the exact CVS arguments to use:

         http://www.icequake.net/~witwerg/ymfpci-patch.txt

Thanks all,

Philip Thiem

>
> the options look already good.  perhaps only the mixer issue.
>
> on the YMFPCI chip, the FM might be connected to Aux.
> try to turn on Aux Playback and raise its volume.
>
>
> Takashi



GPG Pub Key Archived at wwwkeys.us.pgp.net
Isn't it obvious lumberjacks love traffic lights?




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Zenaan Harkness <zen@getsystems.com>
Subject: [Fwd: Re: Syncing rme9652 with yamaha 01v]
Date: 11 Oct 2002 09:16:00 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1034288160.500.107.camel@zen8100a>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Forwarde as requested. Sorry if it gets through twice or not at all...

zen


-----Forwarded Message-----

> From: Paul Davis <pbd@op.net>
> To: Zenaan Harkness <zen@getsystems.com>
> Cc: alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] Syncing rme9652 with yamaha 01v
> Date: 10 Oct 2002 09:17:04 -0400
> 
>   [ 
>     please forward this response to alsa-devel@lists.sourceforge.net;
>     i can't send mail there at this time. 
>   ]
> 
> >I want to know how to set the sync options in the rme9652 (the manual
> >says it "can be configured to use the following clock sources: external
> >input signal (AutoSync), internal clock (Master), or external word clock
> >signal (Wordclock).
> 
> all such configuration is done just like with any other ALSA device:
> using the control API via one of text-based tools such as alsactl or
> amixer. a typical sequence with alsactl:
> 
> 	% alsactl -f foo store name-of-your-rme9652-card
> 	% your-favorite-editor foo
> 	    ... edit file ...
> 	% alsactl -f foo restore name-of-your-rme9652-card
> 
> while in your favorite editor, look for this block:
> 
> 	control.7 {
> 		comment.access 'read write'
> 		comment.type ENUMERATED
> 		comment.item.0 AutoSync
> 		comment.item.1 Master
> 		comment.item.2 'Word Clock'
> 		iface PCM
> 		name 'Sync Mode'
> 		value AutoSync
> 	}
> 
> and change the "value" field to your preferred choice (see below).
> 
> it can be quicker to do this with amixer:
> 
>   % amixer -D name-of-your-9652-card cset iface=PCM,name='Sync Mode' 'Master'
> 
> see man amixer for more details on this. i generally use alsactl
> myself.
> 
> >The main problem is sync error - the desk has two options - auto, and
> >external (ADAT) - choosing either results in ongoing sync pops and
> >dropouts, etc.
> 
> you need the rme9652 set to "Master". repeat after me: any digital
> audio system must have one and only sample clock source. since the
> desk can't be a master (apparently), then the rme9652 must be.
> 
> >Should aconnectgui help me?
> 
> no. it has nothing to do with this - its related to use of the ALSA sequencer.
> 
> --p
> 
-- 
Mr Zenaan Harkness, Manager, VIDC
Phone: +678 25 151  Fax: +678 25 178  Mobile: +678 45 179
Please respect the confidentiality of this email.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

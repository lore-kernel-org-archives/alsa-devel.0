From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: cs46xx sound quality and CD volume
Date: Sun, 13 Oct 2002 10:33:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA92FD2.1050302@cucumelo.org>
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
>Is the amplifier the IEC 958?  (it now shows up in the mixer with the
>new DSP code)
>  
>
That's not the amplifier, that's the SPDIF input/output control. On the
Game Theater XP card the amplifier is always turned on (with the
exception when unmute the CD volume). There is no mixer
control for this.

>Also it seems like every mixer element is duplicated in alsamixer, but
>you probably know that.
>  
>
One is for the primary AC97 codec, and the other one for the secondary
AC97 codec. The Game Theater XP got two cs4294 codecs.
That's why many mixer control are duplicated, and probably
some of them may be obsolete. Like microphone and headphone
on the secondary codecs are not wired to anything.

>Also I tried the SPDIF in with this new DSP code, and it doesn't seem to
>work.  There is an 'Optical/Coaxial SPDIF Input' in alsamixer but I
>can't change its levels, only mute it.
>  
>
With that control you selects to use Coaxial digital input or Optical 
digital
input. Look on the back on your beutiful blue break-out box and you
will find them -;)

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

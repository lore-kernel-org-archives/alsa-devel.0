From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: [PATCH] cs46xx SPDIF input && some cleanups && bug
 fixes
Date: Mon, 12 Aug 2002 12:59:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D579526.1000505@cucumelo.org>
References: <27526.1029143696@www32.gmx.net>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Friedrich.Ewaldt@gmx.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>Switching around in alsamixer at the SPDIF controls for some time causes a
>high frequency tone to be played back all the time until I reboot. I'll have
>to do further examinations when this happens exactly.
>regards, fritz_e
>
It's a known problem, read the note in cs46xx_lib.c, i think it's becourse
some times the DSP tasks get unsynchronized. I dont know how to fix it yet.

To get around the problem just mute and unmute the SPDIF input controll
in mixer and,  that usually fix it.

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

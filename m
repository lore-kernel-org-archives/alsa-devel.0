From: Christian Esken <c.esken@cityweb.de>
Subject: alsa-lib mixer-interface: snd_mixer_selem_get_capture_switch()
Date: Sun, 23 Nov 2003 20:23:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311232023.11189.c.esken@cityweb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I have problems with snd_mixer_selem_get_capture_switch(elem,pos,&value)
in my KMix mixer application. The "value" returned does *not* reflect the 
actual state in all cases.
Probably I am doing something wrong, if somebody could throw me a hint I would 
be more than happy. I have investigated for days and feel completely lost.

It is a bit complicated, so I'll do a step-by-step walkthrough of an example:

1) Initially switch "1" is ON and switch "2" is OFF
2) I enable switch "2". 
3) The ALSA driver detects that switches "1" and "2" cannot be ON at
  the same time. So the ALSA driver disables "1".
4a) KMix now shows switches "1" and "2" both as ON, because
  snd_mixer_selem_get_capture_switch() reports them as ON.
4b) alsamixer shows switch "1" is OFF and switch "2" is ON.

So I wonder why snd_mixer_selem_get_capture_switch() works in alsamixer and 
not in KMix.
The only differenece I see is that alsamixer has these poll-descriptor stuff 
in it. Do I possibly need to implement it (I don't understand what I would 
have to do there - it looks complicated)? Or is there some other means to 
"update" the state of the mixer elements?

Hint: I also have the problem that I don't see volume changes done with other 
applications like xmms. So I am pretty sure I have an "update" problem, I 
just don't know how to solve it.


Any help is greatly appreciated,
  Chris


PS: I already looked at other mixer applications like gamix, but that did not 
help me: For example the latter one seems to be using alsa kernel interface 
instead of alsa-lib.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

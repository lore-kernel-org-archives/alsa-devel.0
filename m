From: "mahendra  sp" <mahendra_sp@rediffmail.com>
Subject: clarification needed
Date: 6 May 2003 08:18:15 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030506081815.6430.qmail@webmail16.rediffmail.com>
Reply-To: "mahendra  sp" <mahendra_sp@rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed
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

hi,

    i finally got rid of errors while executing the program.

  for playback program, i am  filling the buffer with junk data  
and i am using the writei function. I   am hearing some sound.

   but, for capture, i am not getting any errors. if my exe is 
"capture.out",
   when i give ./capture.out, it doesn;t give anything. I know 
that it will not give any sound here. but if i want to talk, and 
then capture the samples( using readi) , store it to the buffer 
and then call writei function .
   But i know the method and logic behind it. First ,

i will call snd_pcm_capture_prepare -> snd_pcm_readi-> 
snd_pcm_playback_prepare->snd_pcm_writei.

   what shold be the buffer size? channels=?, frames =? for full 
duplex application?

  am i correct? please help me.

thanks,
mahendra.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

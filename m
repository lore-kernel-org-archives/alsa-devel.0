From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: ALSA + jack + xrun = kernel crash
Date: Mon, 19 May 2003 21:16:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EC92D8C.3000205@cucumelo.org>
References: <E19HnYU-0003Fd-00@sc8-sf-list1.sourceforge.net>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Takashi Iwai <tiwai@suse.de>, Arthur Peters <amp@singingwizard.org>, Alsa dev list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>
>
>aw shoot. of course it returns true: jack tries to link
>capture+playback so that we only have to issue single commands to
>start+stop. damn, i forgot that, sorry.
>
>  
>
One thing that would be interesting to known more about is
why does jack not the hangup the machine at once when I start it
without the "-R" flag. (wich will results in a lot more xruns)

Without the "-R" flag: (almost all the times ...)
- jackd runs without locking up the machine
 until I try to connect any client.
- after stopping jackd (Ctrl-C) without conecting any client,
the machine dont behave correctly after this, for example
when a 'A' key in the terminal I got any other character, programs
does not start correctly, the machine does not shutdown
correctly, but have not seen any "oops" (but maybe just a random
coincidence ....)
But if it's a spin_lock(...) problem why does not just lock up my 
machine in this
case ?

I would interesting to known what happens  if someone else could try 
starting
the jackd without the "-R" and latest ALSA CVS. (on a SMP machine .. -;)

/Benny




-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge

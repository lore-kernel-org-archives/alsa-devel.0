From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: ALSA + jack + xrun = kernel crash
Date: Sat, 17 May 2003 22:57:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EC6A254.4010303@cucumelo.org>
References: <1053136440.1197.213.camel@newbie.localnet.local>
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
To: Arthur Peters <amp@singingwizard.org>
Cc: Alsa dev list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>
>
>Hello, I am experiencing a reletivly hard crash (SysRq works but SysRq-B
>prints a message saying it will reboot then doesn't). The crash happens
>when jackd xruns. I've been reproducing it using "jackd -d alsa" (other
>options don't make a difference) then "ladccad". Once the system crashs
>the only way to get any responce is with SysRq. Keys don't echo to the
>console and I can't switch VTs.
>
>Generally there is no error message or oops that I can see, even when
>debug=full is enable in ALSA. Early on I saw a message from jackd to the
>tune of "error write 512 somethings to device", but I have not been able
>to reproduce it. I am willing to run any tests that might help. I use
>journaling filesystems ;-) 
>
>My hardware is:
>Dual PIII 1Ghz with 512M RAM on a Tyan MB.
>SoundBlaster Live! Value
>ATI Radeon 8500 (using the closed-source ATI drivers; version 2.9.8)
>
>My software is:
>ALSA drivers 0.9.3a or current CVS
>Linux 2.4.20 (vanilla or gentoo patched)
>Jack 0.71.2
>Current Gentoo with testing packages enabled (~x86)
>  
>
Just want to tell that I'm experiencing almost the same problem (I got a 
Dual PIII 1Gz 256Mb
and two cs46xx soundcards)
After updating ALSA CVS today, jack is no longer able to start, it just 
locks up my machine, and
sometimes even the SysRQ hack dont react. (I've been several hours today 
fighting with this problem .....)
What I was able to find out from the SysRQ is that the EIP all the times 
seems
to be somewhere at: c0153804 <.text.lock.inode+135/211>, or 
sync_unlocked_inodes(...)
which dont make any sense to me. (?????????????)

One more interesting point is that if I start the jackd without the "-R" 
flag jack starts for a while,
sometimes I'm able to even stop/kill it. But after that no program is 
able to start or run correctly,
which feels like  that something is seriously corrupted in the kernel.

Now, for first time in my life I've downgraded ALSA to a previous CVS 
version, which seems
to work with JACK :(

/Benny



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge

From: Gabriel Gatzsche <gabrielg@emt.iis.fhg.de>
Subject: Sound in QT-Threads
Date: Wed, 03 Jul 2002 08:04:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D2293E1.1060903@emt.iis.fhg.de>
References: <3D2287D0.1020600@emt.iis.fhg.de>
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> Hello!
> I have made a program with two qt-threads. One for reading from 
> soundcard, one for writing.
> There are no problems if the threads work allone. But if both threads 
> work in the same time, the program
> chrashes some times with following message:
>      wavplay: pcm.c:5191: snd_pcm_mmap_commit: Assertion `offset == 
> *pcm->appl_ptr % pcm->buffer_size' failed.
> Can somebody tell, what to do?
>
> Thanks for your help
>       Gabriel
>





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf

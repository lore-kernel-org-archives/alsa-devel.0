From: Peter Vollmer <remllov_@gmx.de>
Subject: snd_async_add_pcm_handler() and SND_PCM_ACCESS_MMAP_INTERLEAVED
Date: Thu, 15 May 2003 10:23:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.2.20030515095924.03421e38@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi all,

I am trying to use the mmap access method together with an async_handler 
function (ice1712 in multitrack mode),
but in a setting where multiple periods fit into a buffer, I get back the 
same address pointer to the accessible data in  snd_pcm_mmap_begin(...) in 
areas[x].addr multiple times (one for every period in the buffer, I guess) 
in the signal handler. I was following the pcm.c sinus generator demo more 
or less, but the combination of mmap/async_handler is not used there.

I was trying to dereference the appl.ptr and hw.ptr pointers from the 
snd_pcm_t handler to get exact information about the buffer pointers, but 
this does not work from my application since the struct type definition of 
snd_pcm_t seems to be hidden. What else can I use to get information about 
the pointers inside the capturing buffer ? Or did I simply fail to include 
the right header ?

Thanks for any hints

Peter



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

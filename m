From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: alsa-driver will not compile with kernel
     2.6.9-rc2-mm4-S7
Date: Sat, 2 Oct 2004 01:32:52 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32862.192.168.1.8.1096677172.squirrel@192.168.1.8>
References: <1096675930.27818.74.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1096675930.27818.74.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> At first I thought my build was incorrect, but I reproduced this error
> with a clean build and ALSA CVS from today:
>
>   CC [M]  /home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore/pcm_native.o
> /home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3202:57: macro
> "io_remap_page_range" requires 5 arguments, but only 4 given
> /home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c: In function
> `snd_pcm_lib_mmap_iomem':
> /home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3200: error:
> `io_remap_page_range' undeclared (first use in this function)
> /home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3200: error: (Each
> undeclared identifier is reported only once
> /home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3200: error: for
> each function it appears in.)
> make[3]: ***
> [/home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore/pcm_native.o] Error 1
> make[2]: *** [/home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore] Error 2
> make[1]: *** [_module_/home/rlrevell/cvs/alsa/alsa-driver/kbuild] Error 2
> make[1]: Leaving directory
> `/home/rlrevell/kernel-source/linux-2.6.9-rc2-mm4-S7'
> make: *** [compile] Error 2
>
> I am not sure if this is an ALSA issue or -mm4.  I suspect -mm4 because
> -mm3-S6 worked.  The VP patch does not seem to be involved.
>
> Lee
>

Good grief! I'm having this too, and I was desperate thinking I was the
only one, and ultimately offering the blame to gcc 3.4.1 which is what I'm
test-driving now on my laptop (Mdk 10.1c).

Now I remember that -mm4 has some issue about remap_page_range kernel
symbol being renamed to something else, which is breaking the build of
outsider modules (i.e. not the ones bundled under the kernel source tree).
Or so it seems.

Maybe someone on the lkml may have a clue and help here?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl

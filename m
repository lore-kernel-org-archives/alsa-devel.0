From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: Alsa-tools 1.0.0 rc1 error with 2.6.0-test11
Date: Wed, 03 Dec 2003 15:36:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FCDF505.60305@undata.org>
References: <000401c3b928$6e273700$0801a8c0@svrmarty.gnome.at>	<3FCDB470.6010005@undata.org>	<3FCDD72C.9020907@undata.org> <s5h7k1ec8x4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7k1ec8x4.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Martin Holzer <mholzer@gentoo.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote :
> At Wed, 03 Dec 2003 13:29:32 +0100,
> Thomas Charbonnel wrote:
> 
>>I wrote :
>>
>>>Martin Holzer a écrit :
>>>
>>>
>>>>make[1]: Entering directory 
>>>>`/var/tmp/portage/alsa-tools-1.0.0_rc1/work/alsa-tools-1.0.0rc1/hdspmixer/sr 
>>>>
>>>>c' if g++ -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\" 
>>>>-DPACKAGE_VERSION=\"\" -DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\" 
>>>>-DPACKAGE=\"hdspmixer\" -DVERSION=\"1.6\" -DSTDC_HEADERS=1 
>>>>-DHAVE_LIBASOUND=1  -I. -I.   -I/usr/include/fltk-1.1  -march 
>>>>=athlon-xp -O3 -pipe -fomit-frame-pointer 
>>>>-I/lib/modules/2.6.0-test11-gentoo-r1/build/include
>>>>-I/lib/modules/2.6.0-test 11-gentoo-r1/build/include 
>>>>-I/usr/include/fltk-1.1 -I/usr/include/freetype2 -march=athlon-xp 
>>>>-mcpu=athlon-xp -O3 -pipe - I/usr/X11R6/include -fno-exceptions -MT 
>>>>hdspmixer.o -MD -MP -MF ".deps/hdspmixer.Tpo" \   -c -o hdspmixer.o 
>>>>`test -f 'hdspmixer.cxx' || echo './'`hdspmixer.cxx; \ then mv -f 
>>>>".deps/hdspmixer.Tpo" ".deps/hdspmixer.Po"; \ else rm -f 
>>>>".deps/hdspmixer.Tpo"; exit 1; \ fi In file included from 
>>>>hdspmixer.cxx:31: HDSPMixerCard.h:57: error: 'hdsp_9632_aeb_t' is used 
>>>>as a type, but is not    defined as a type. hdspmixer.cxx: In function 
>>>>`int main(int, char**)': hdspmixer.cxx:68: error: `H9632' undeclared 
>>>>(first use this function) hdspmixer.cxx:68: error: (Each undeclared 
>>>>identifier is reported only once
>>>>for    each function it appears in.) make[1]: *** [hdspmixer.o] Error 
>>>>1 make[1]: Leaving directory 
>>>>`/var/tmp/portage/alsa-tools-1.0.0_rc1/work/alsa-tools-1.0.0rc1/hdspmixer/sr 
>>>>
>>>>c' make: *** [all-recursive] Error 1
>>>>
>>>>Martin Holzer
>>>>sVrmARTY-/irc.freenode.net
>>>>
>>>>Bug-Wrangler, Gentoo Linux
>>>> 
>>>>
>>>
>>>Hi Martin,
>>>
>>>You should install alsa-driver before alsa-tools, as it will install the 
>>>hdsp.h file on your system, containing the missing declaration.
>>>
>>>Thomas
>>>
>>
>>Ooops, I misread your subject line. This is because the driver version 
>>included in 2.6.0-test11 is a little bit outdated. Update your kernel 
>>tree with latest alsa, and compile again, then.
> 
> 
> there are configure options to specify the header files for
> alsa-kernel.  one is --with-kernel and another is --with-soundbase.
> 
> the former specifies the top path of 2.6 kernel source tree, and the
> header files in that tree will be used.  the latter specifies directly
> the path of alsa-driver's include directory.
> 
> for example,
> 
> 	./configure --with-kernel=/my/src/linux-2.6.0-test9
> 
> 	./configure --with-soundbase=/somewhere/alsa-driver-1.0.0/include
> 
> when no these options are given, the standard path,
> i.e. /usr/include/sound will be searched.
> 
> these options are necessary only for (some of) alsa-tools.  usually,
> applications don't need (and shouldn't) access to the kernel header
> files.
> 
> 

I used the hdsp.h header file to ease the task of building userspace 
application using the hwdep interface to communicate with the driver 
(sharing structures and type definitions).
If this was a bad idea, I'll reconsider it, no problem.

Thomas



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

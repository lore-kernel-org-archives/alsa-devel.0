From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: build changes
Date: 07 Jun 2003 00:38:26 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054946307.13620.41.camel@Jay>
References: <Pine.LNX.4.44.0306041339290.1174-100000@pnote.perex-int.cz>
	<XFMail.20030604175732.pochini@shiny.it>  <s5h65nln4o7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h65nln4o7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On mer, 2003-06-04 at 17:17, Takashi Iwai wrote:
> At Wed, 04 Jun 2003 17:57:32 +0200 (CEST),
>
> wouldn't it better to put another Makefile in sub directories?

Sure. I followed the instrutions you wrote here a couple of months ago.
When I do cvscompile --with-cards=powermac,echoaudio[...] it stops here:

make  -C echoaudio fastdep
make[2]: Entering directory
`/home/Giu/tttttt/alsa-driver-0.9.4/pci/echoaudio'
/home/Giu/tttttt/alsa-driver-0.9.4/include/sndversions.h was not updated
make[2]: *** No rule to make target `GenericDriver/OsSupportLinux.c',
needed by `fastdep'.  Stop.
make[2]: Leaving directory
`/home/Giu/tttttt/alsa-driver-0.9.4/pci/echoaudio'
make[1]: *** [_sfdep_echoaudio] Error 2
make[1]: Leaving directory `/home/Giu/tttttt/alsa-driver-0.9.4/pci'
make: *** [dep] Error 1


But any subsequent "make" completes successfully.

These are the changes I did to the various files:


pci/Makefile

-extra-subdir-y	:= pdplus
+extra-subdir-y	:= pdplus echoaudio


utils/Modules.dep
 
+%dir linux/sound/pci/echoaudio
+|snd-echoaudio snd-pcm


acore/Makefile

+obj-$(CONFIG_SND_ECHOAUDIO) += snd-pcm.o snd-page-alloc.o snd.o
snd-rawmidi.o
 


Bye.




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.

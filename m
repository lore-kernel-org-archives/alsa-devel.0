From: lupus <de_lupus@pandora.be>
Subject: Re: alsa-driver-1.0.0rc2 won't compile with kernel 2.6
Date: Thu, 11 Dec 2003 13:36:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1071146177.11093.7.camel@d51521F6A.kabel.telenet.be>
References: <1071145317.11093.2.camel@d51521F6A.kabel.telenet.be>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1071145317.11093.2.camel@d51521F6A.kabel.telenet.be>
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

After removing 

sndversions.h & linux/modversions.h

from

/pcmcia/vx/vxpocket.c &
/pcmcia/vx/vxp440.c

I was able to compile alsa but this probably broke the vxp driver :)


Op do 11-12-2003, om 13:21 schreef lupus:
> package: alsa-driver-1.0.0rc2
> kernel: 2.6.0-0.test11
> 
> kernel 2.6 doesn't use make dep any more so modversions.h isn't created
> anymore
> 
> 
> make[1]: Binnengaan van map `/lib/modules/2.6.0-0.test11.1.99/build'
>   CHK     include/linux/version.h
> *** Warning: Overriding SUBDIRS on the command line can cause
> ***          inconsistencies
>   CHK     include/asm-i386/asm_offsets.h
>   CC [M]  /home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx/vxp440.o
> /home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx/vxp440.c:6:31:
> linux/modversions.h: Onbekend bestand of map
> /home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx/vxp440.c:7:25: sndversions.h:
> Onbekend bestand of map
> make[3]: *** [/home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx/vxp440.o] Fout
> 1
> make[2]: *** [/home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx] Fout 2
> make[1]: *** [/home/lupus/alsa-driver-1.0.0rc2/pcmcia] Fout 2
> make[1]: Weggaan uit map `/lib/modules/2.6.0-0.test11.1.99/build'
> 
> maybe it's my fault but plz check it out.
> 
> Kristof Vansant
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

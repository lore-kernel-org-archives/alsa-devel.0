From: Andrei Boros <andrei@srr.ro>
Subject: alsa-cvs linking error
Date: Mon, 07 Apr 2003 10:03:51 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E9122D7.90B71AF7@srr.ro>
References: <3E876E9C.1070905@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I wanted to see if latest updates to alsa-cvs tree will make my opti924
work, so I updated.

This is the configuration requested:
./configure --with-cards=dummy,cs46xx,opti92x-ad1848 --with-oss=yes
--with-sequencer=yes --with-isapnp=yes --with-debug=detect
--enable-verbose-printk

This is the error I got during make

ld  -r -o snd-opl4-lib.o opl4_lib.o opl4_mixer.o opl4_proc.o
opl4_mixer.o(.modinfo+0x0): multiple definition of
`__module_kernel_version'
opl4_lib.o(.modinfo+0x0): first defined here
opl4_mixer.o(.modinfo+0x16): multiple definition of
`__module_using_checksums'
opl4_lib.o(.modinfo+0x16): first defined here
opl4_proc.o(.modinfo+0x0): multiple definition of
`__module_kernel_version'
opl4_lib.o(.modinfo+0x0): first defined here
opl4_proc.o(.modinfo+0x16): multiple definition of
`__module_using_checksums'
opl4_lib.o(.modinfo+0x16): first defined here
make[2]: *** [snd-opl4-lib.o] Error 1
make[2]: Leaving directory
`/serve/install/alsa-cvs/alsa-driver/drivers/opl4'
make[1]: *** [_modsubdir_opl4] Error 2
make[1]: Leaving directory `/serve/install/alsa-cvs/alsa-driver/drivers'
make: *** [compile] Error 1





-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/

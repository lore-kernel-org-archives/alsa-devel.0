From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: [Fwd: Re: Cross compiling alsa-lib]
Date: Thu, 01 Dec 2005 21:02:51 +0000
Message-ID: <1133470971.9016.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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


On Thu, 2005-12-01 at 10:45 +0100, Takashi Iwai wrote:

> Did you try the ALSA CVS version?
> 
> 
I cannot get that to compile at all...

adrian@bossclass:~/alsa-lib$ make
Making all in alsalisp
make[1]: Entering directory `/home/adrian/alsa-lib/alsalisp'
/home/adrian/buildroot/build_sh4/staging_dir/sh4-linux-uclibc/bin/gcc
-DHAVE_CONFIG_H -I. -I. -I../include -I../include -I../src/alisp    -g
-O2 -c alsalisp.c
In file included from alsalisp.c:28:
../include/asoundlib.h:43:26: alsa/version.h: No such file or directory
make[1]: *** [alsalisp.o] Error 1
make[1]: Leaving directory `/home/adrian/alsa-lib/alsalisp'
make: *** [all-recursive] Error 1




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

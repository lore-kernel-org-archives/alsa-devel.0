From: Paul Davis <paul@linuxaudiosystems.com>
Subject: problems compiling current CVS
Date: Mon, 2 Jun 2003 19:08:35 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306022308.h52N8ZT20263@linuxaudiosystems.com>
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

this is with CVS as of this morning (US EST), trying to build alsa-driver
outside a 2.4.20 kernel using:

        ./cvscompile --with-oss=yes --with-sequencer=yes --with-cards=rme9652,hd
sp,trident

  [ ... ]

ake[2]: Entering directory `/usr/local/music/src/alsa-cvs/newer/alsa-driver/acor
e/ioctl32'
make[2]: Leaving directory `/usr/local/music/src/alsa-cvs/newer/alsa-driver/acor
e/ioctl32'
make  -C oss fastdep
make[2]: Entering directory `/usr/local/music/src/alsa-cvs/newer/alsa-driver/aco
re/oss'
/bin/sh: ${xtmp:0:5}: bad substitution
make[2]: *** [mixer_oss.c] Error 1
make[2]: Leaving directory `/usr/local/music/src/alsa-cvs/newer/alsa-driver/acor
e/oss'
make[1]: *** [_sfdep_oss] Error 2
make[1]: Leaving directory `/usr/local/music/src/alsa-cvs/newer/alsa-driver/acor
e'
make: *** [dep] Error 1



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5

From: Lee Revell <rlrevell@joe-job.com>
Subject: gmplayer error with ALSA output plugin
Date: Sun, 25 Jul 2004 18:18:37 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1090793916.14951.107.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

When I select the 'ALSA 0.9.x/1.0.x' option for audio output in
gmplayer, the sound seems to work, but I get tons of popup windows with
this error:

alsa-control: mixer attach /dev/mixer: no such file or directory

As a result I am forced to use OSS emulation mode, which causes latency
problems due to its use of ioctl().  /dev/mixer exists and is writable
by the user.  In fact when using OSS emulation mode this is the mixer
device used.  Is this just a bug in gmplayer?

I am using debian unstable, here is where I got the gmplayer packages:

deb ftp://ftp.nerim.net/debian-marillat unstable main

deb http://dept-info.labri.fr/~danjean/debian unstable main
deb-src http://dept-info.labri.fr/~danjean/debian unstable main

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click

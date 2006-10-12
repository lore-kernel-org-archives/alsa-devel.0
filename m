From: Jaroslav Kysela <perex@suse.cz>
Subject: alsa-lib - name hints - next round
Date: Thu, 12 Oct 2006 16:34:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610121629090.9072@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 77BAB14C
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Oct 2006 16:34:32 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
	44F6F994DC for <alsa-devel@alsa-project.org>;
	Thu, 12 Oct 2006 16:34:32 +0200 (MEST)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
	2E4D4E9486 for <alsa-devel@alsa-project.org>;
	Thu, 12 Oct 2006 16:34:31 +0200 (CEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

	I've commited updated name hint code into ALSA repo. The result of 
'aplay -L' on my notebook is:

default:CARD=Intel
    HDA Intel at 0xc8000000 irq 122, ALC880 Analog
    Default Audio Device
front:CARD=Intel,DEV=0
    HDA Intel at 0xc8000000 irq 122, ALC880 Analog
    Front speakers
surround40:CARD=Intel,DEV=0
    HDA Intel at 0xc8000000 irq 122, ALC880 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=Intel,DEV=0
    HDA Intel at 0xc8000000 irq 122, ALC880 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Intel,DEV=0
    HDA Intel at 0xc8000000 irq 122, ALC880 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Intel,DEV=0
    HDA Intel at 0xc8000000 irq 122, ALC880 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Intel,DEV=0
    HDA Intel at 0xc8000000 irq 122, ALC880 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=Intel,DEV=0
    HDA Intel at 0xc8000000 irq 122, ALC880 Digital {Playback}
    IEC958 (S/PDIF) Digital Audio Output
null
    Discard all samples (playback) or generate zero samples (capture)

	The behaviour is configurable:

# put this line to ~/.asoundrc to see all your PCM definitions
# without hint {} section

defaults.namehint.!showall on

# put this line to ~/.asoundrc to see all extended PCM definitions
# (like hw and plughw)

defaults.namehint.!extended on

	Also, I suggest to add "plugsurround" and "plugspdif" devices 
into alsa.conf and move current definitions from basic to extended level.
Opinions?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

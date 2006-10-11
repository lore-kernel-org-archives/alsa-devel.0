From: Jaroslav Kysela <perex@suse.cz>
Subject: alsa-lib: snd_device_name_hint() function
Date: Wed, 11 Oct 2006 13:45:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610111323470.8848@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 80948163
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Oct 2006 13:45:54 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
	4E15C9932B for <alsa-devel@alsa-project.org>;
	Wed, 11 Oct 2006 13:45:54 +0200 (MEST)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
	1B363E9486 for <alsa-devel@alsa-project.org>;
	Wed, 11 Oct 2006 13:45:54 +0200 (CEST)
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

Hi,

	because no one objected against new snd_device_name_hint() 
function prototype (see bellow for hg URL), I commited my implementation 
to the hg repository.

http://hg.alsa-project.org/alsa-lib?cs=b4ac1aee3f07

	Additions from last update:

1) add hint {} section to the device definition
   hint.description "Description"
   hint.device integer
   hint.device_input integer
   hint.device_output integer
2) hint 0 - disable listing of this device definition
3) show device name like:

front:CARD=Intel,DEV=0|ALC880 Analog: Front speakers and multichannel output

4) notify available direction (if possible) in comment like

spdif:CARD=Intel,DEV=0|ALC880 Digital {Playback}: IEC958 (S/PDIF) Output

5) gather strings from namehint.IFACE {} section (see function 
   documentation for example)

Please, because I and Takashi have different meaning about the default 
behavior, if definitions of devices should be visible by default or not, 
let us know (to this mailing list) your meaning. I'll gather your votes 
and change behaviour of alsa-lib (if required).

Proposals:

a) my implementation - device definitions in ~/.asoundrc are listed
   by default and user can disable listing using 'hint 0' in the
   device definition
b) Takashi's proposal - if the hint {} section is missing, the device
   will not be listed

Testing (PCM devices):

The aplay and arecord -L command uses new function (hg version).

Testing (all interfaces):

alsa-lib/test/namehint utility can be used:

alsa-lib/test/namehint rawmidi
(actually, it seems that other interfaces than PCM does not work - fixing 
right now)

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

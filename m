From: "Denis, jMarc" <jm@ilfesprit.fr>
Subject: RE: compilation
Date: Mon, 21 Jul 2003 16:29:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <DFEEJKMCBANHCIJNKLLGGEPCCFAA.jm@ilfesprit.fr>
References: <3F1BF563.4060507@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F1BF563.4060507@free.fr>
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

Hi i forgot to tell you my configuration :

[root@localhost alsa-oss-0.9.4]# rpm -qa |grep alsa
alsa-lib-0.9.0-fr0.rc7.0.rh73.1
alsa-driver-0.9.0-fr0.rc7.0.rh73.2
alsa-utils-0.9.0-fr0.rc7.0.rh73.1

[root@localhost alsa-oss-0.9.4]# locate libasound
/usr/lib/libasound.so
/usr/lib/libasound.so.2
/usr/lib/libasound.so.2.0.0

And when i run ./configure i have this problem :

checking for libasound headers version >= 0.9.0... not present.
configure: error: Sufficiently new version of libasound not found.


Anyone can help me please ?
TU.

jM.


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0

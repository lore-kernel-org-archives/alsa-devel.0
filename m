From: jcarwana@ucla.edu
Subject: hwdep.c
Date: Mon, 14 Mar 2005 19:16:25 PST
Message-ID: <200503150316.j2F3GP820306@webmail.my.ucla.edu>
Reply-To: jcarwana@ucla.edu
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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

Alsa Developers Please Help!!

I have been trying to trace an error through the alsa-lib code but to no
avail and was wondering if anybody could help.  I am using ALSA v1.0.4 as=
=20
I am running a specialized system with kernel version 2.4.19.  What
happens seems to be an error inside libasound.so.2 and occurs when I
attempt to manually run vxloader.  The error I get is as follows:

ALSA lib hwdep.c:151:(snd_hwdep_open_noupdate) Unknown HwDep hw:0

This code points to a function called snd_hwdep_open_noupdate and the
lines of code are:
err =3D snd_config_search_definition(root, "hwdep", name, &hwdep_conf)
if (err < 0)
     SNDERR("unknown HwDep %s", name);

Does anybody know what could be causing this error???

Thank you for your consideration - James




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick

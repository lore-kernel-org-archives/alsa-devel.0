From: <ico@fuse.net>
Subject: dxs_support and via82xx (yet once more)
Date: Fri, 23 Apr 2004 4:12:57 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040423041257.PVVR19268.smtp2.fuse.net@smtp.fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
Cc: ico@fuse.net
List-Id: alsa-devel@alsa-project.org

Hi all, =

 =

Apologies for my persistence but is this feature =

broken in the 1.0.4.pre2 drivers or am I simply =

unable to put the right syntax into the =

modules.conf? =

 =

alias char-major-116 snd =

alias char-major-14 soundcore =

alias snd-card-0 via82xx =

#I tried every possible option =

options via82xx dxs_support=3D1 =

options snd-card-0 dxs_support=3D1 =

options snd-via82xx dxs_support=3D1 =

 =

alias sound-slot-0 snd-card-0 =

alias sound-service-0-0 snd-mixer-oss =

alias sound-service-0-1 snd-seq-oss =

alias sound-service-0-3 snd-pcm-oss =

alias sound-service-0-8 snd-seq-oss =

alias sound-service-0-12 snd-pcm-oss =

 =

Even with all this the syslog still complains: =

via82xx: Assuming DXS channels with 48k fixed =

sample rate. =

         Please try dxs_support=3D1 or =

dxs_support=3D4 option =

         and report if it works on your machine. =

 =

What am I doing wrong? =

 =

Best wishes, =

 =

Ico =

 =




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297

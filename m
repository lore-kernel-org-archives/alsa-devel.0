From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: new rme firmware
Date: Mon, 17 Feb 2003 11:50:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030217105006.GB1442@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

arecord seems to work with the new revision of the hdsp pci (rev
11). The computer still freezes if pd is used with input
enabled. G=FCnther Geiger, the author of the new alsa port of pd, said
the way he implemented the pd port freezing of computer can only be
related to kernel/alsa problems.

The situation:

- pd works fine in and out with the older revision
- the computer freezes starting pd input enabled with the new revision
- the computer doesn't crash with arecord

The question remains, whether this is due to an incompleted load of
the firmware as the syslogs suggest. I wonder, whether it is even
possible to get arecord and sound out to work when the firmware load
is incomplete or whether this is a bogus message from the driver. =20

Let me know, if any syslogs or other material is needed to pin down
the problem. If worse comes to worse I'm considering to downgrade the
firmware to revision 10, but I'd rather avoid that for obvious
reasons.

--
Orm=20


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

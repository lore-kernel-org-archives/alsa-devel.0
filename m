From: aknuds-1@broadpark.no
Subject: Acquring poll descriptors
Date: Wed, 23 Jul 2003 00:19:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1058912365.3f1db86de8730@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
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

Hi

Was just wondering if there is any particular reason to acquire a pcm's p=
oll=20
descriptor(s) (snd_pcm_poll_descriptors) before each poll, or can I simpl=
y do it=20
after opening the pcm and be done with it? Can the associated poll fds, o=
r even=20
the number of fds change after a pcm has been opened?

Thanks

A




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0

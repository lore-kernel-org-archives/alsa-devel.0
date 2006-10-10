From: Remy Bruno <remy.bruno@trinnov.com>
Subject: Re: Issue with Intel HDA Sound card 82801G (laptop
	Medion)
Date: Tue, 10 Oct 2006 15:30:19 +0200
Message-ID: <20061010133019.GA19725@trinnov.com>
References: <1160438676.452ae39456ad3@imp6-g19.free.fr>
	<1160439314.452ae61245cdb@imp6-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1160439314.452ae61245cdb@imp6-g19.free.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: albox@free.fr
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

In fact, I didn't use their alsa_driver directly (it doesn't compile for me
neither), but I too the alsa-kernel/pci/hda directory of it and replaced the
corresponding dir in 1.0.13 by this one, and I used the resulting modified
1.0.13 tree. As I said, I needed to change minor things (see the patch I se=
nt
you together with the alsa-driver-1.0.9b_25 tar). And as I said, don't forg=
et
to "modprobe -r" the driver before suspending to disk, or the kernel will
crash.

Regards,
Remy

On Tuesday 10 October at 02:15, albox@free.fr wrote:
> I tried to compile the version included in the tarball that Remy posted l=
ast
> weekend but I got some error messages :
> =

> /home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.9b_25=
/acore/init.c:749:
> error: field =91pdev=92 has incomplete type
> /home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.9b_25=
/acore/init.c:762:
> error: =91platform_bus_type=92 undeclared here (not in a function)
> /home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.9b_25=
/acore/init.c:763:
> warning: initialization from incompatible pointer type
> =

> Remy, which version of GCC did you use ?
> =

> Thanks
> =

> Al

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV

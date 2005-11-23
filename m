From: "Yang, Libin" <libin.yang@intel.com>
Subject: RE: [ALSA - driver 0001563]: No Sound on	CybersystemS28 (hda_codec: Unknown model for ALC880, trying auto-probe from	BIOS...)
Date: Wed, 23 Nov 2005 23:39:25 +0800
Message-ID: <D4DBC33C8102AB409C7F44B414D99438015BAF41@bjsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


 This patch is to fix the problem of calculating the nid incorrectly =
when auto-probe for ALC880. The problem to be fixed often behaves with =
such words when using dmesg, 'num_steps =3D 0 for NID=3D0x8' when =
auto-probe for ALC880.

The patch contains:
- alsa-kernel/pci/hda/patch_realtek.c: replace 'alc880_dac_to_idx' with =
'alc880_idx_to_dac' in function 'alc880_auto_fill_dac_nids()'

Signed-off-by: Libin Yang <libin.yang@intel.com>


--- alsa-driver-1.0.10/alsa-kernel/pci/hda/patch_realtek.c	2005-11-02 =
10:26:49.000000000 -0800
+++ my_alsa-driver-1.0.10/alsa-kernel/pci/hda/patch_realtek.c	2005-11-23 =
05:52:36.000000000 -0800
@@ -1809,7 +1809,7 @@
 		nid =3D cfg->line_out_pins[i];
 		if (alc880_is_fixed_pin(nid)) {
 			int idx =3D alc880_fixed_pin_idx(nid);
-			spec->multiout.dac_nids[i] =3D alc880_dac_to_idx(idx);
+			spec->multiout.dac_nids[i] =3D alc880_idx_to_dac(idx);
 			assigned[idx] =3D 1;
 		}
 	}


-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]=20
Sent: 2005=C4=EA11=D4=C223=C8=D5 19:50
To: Lee Revell
Cc: Yang, Libin; alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] [ALSA - driver 0001563]: No Sound on =
CybersystemS28 (hda_codec: Unknown model for ALC880, trying auto-probe =
from BIOS...)

At Wed, 23 Nov 2005 01:04:07 -0500,
Lee Revell wrote:
>=20
> On Wed, 2005-11-23 at 13:55 +0800, Yang, Libin wrote:
> > Here is the patch file for 1.0.10.=20
> >=20
> > The problem is that in the patch_realtek.c file, it should use
> > alc880_idx_to_dac() function in the first 'for' loop, not
> > alc880_dac_to_idx() in function alc880_auto_fill_dac_nids().
> >=20
> > Thanks.=20
>=20
> Thank you!
>=20
> Please provide a Signed-Off-By line with your name and email address,
> for example:
>=20
> Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
>=20
> This is Linux kernel submission policy.

Also please provide a short description for the patch as a changelog
like below:

	Summary: Fix blah on xyz

	This patch fixes the problem blah on xyz....
	....

	Signed-off-by: Foo Bar <foo@bar.com>


thanks,

Takashi


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

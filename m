From: James@superbug.co.uk
Subject: Re: Re: [PATCH] emu10k1: minor send routing cleanup
Date: Sun, 21 Nov 2004 01:21:25 +0000
Message-ID: <200411210121.25291.James@superbug.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_V2+nB2+wegsKlcD"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_V2+nB2+wegsKlcD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Lee Revell wrote:
> On Wed, 2004-11-17 at 14:38 +0100, Takashi Iwai wrote:
>=20
>>>Use snd_emu10k1_compose_audigy_fxrt* macro where appropriate. =A0Also add
>>>a few comments to explain send routing structure.
>>>
>>>Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
>>
>>Thanks, applied to CVS.
>>
>=20
>=20
> Sorry, please revert this one. =A0It disables the right channel. =A0The
> macro must not be correct.
>=20
> Lee
>=20

Use the attached patch to fix this problem.

--Boundary-00=_V2+nB2+wegsKlcD
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="emu10k1.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="emu10k1.h.diff"

--- emu10k1.h.org	2004-11-21 01:04:06.875103895 +0000
+++ emu10k1.h	2004-11-21 01:04:10.252609912 +0000
@@ -840,10 +840,10 @@
 ((route[0] | (route[1] << 4) | (route[2] << 8) | (route[3] << 12)) << 16)
 
 #define snd_emu10k1_compose_audigy_fxrt1(route) \
-(((unsigned int)route[0] | ((unsigned int)route[1] << 8) | ((unsigned int)route[2] << 16) | ((unsigned int)route[3] << 12)) << 24)
+((unsigned int)route[0] | ((unsigned int)route[1] << 8) | ((unsigned int)route[2] << 16) | ((unsigned int)route[3] << 24))
 
 #define snd_emu10k1_compose_audigy_fxrt2(route) \
-(((unsigned int)route[4] | ((unsigned int)route[5] << 8) | ((unsigned int)route[6] << 16) | ((unsigned int)route[7] << 12)) << 24)
+((unsigned int)route[4] | ((unsigned int)route[5] << 8) | ((unsigned int)route[6] << 16) | ((unsigned int)route[7] << 24))
 
 typedef struct snd_emu10k1_memblk {
 	snd_util_memblk_t mem;

--Boundary-00=_V2+nB2+wegsKlcD--


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8

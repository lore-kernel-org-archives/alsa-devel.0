From: "Andreas Fenkart" <afenkart@gmx.ch>
Subject: Patch,
Date: Mon, 22 Nov 2004 00:58:51 +0100 (MET)
Message-ID: <7979.1101081531@www9.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary79791101081531"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary79791101081531
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi list

My gnomemeeting hung when accessing the microphone.
The problem was that the rate variable was not initialized when jumping to
the __partial label.

Greetings

Andreas

-- 
NEU +++ DSL Komplett von GMX +++ http://www.gmx.net/de/go/dsl
GMX DSL-Netzanschluss + Tarif zum supergünstigen Komplett-Preis!
--========GMXBoundary79791101081531
Content-Type: text/x-patch; name="grab_period.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="grab_period.patch"

LS0tIGFsc2EtbGliLTEuMC42L3NyYy9wY20vcGNtX3JhdGUuYwkyMDA0LTA4LTA5IDA4OjMxOjQx
LjAwMDAwMDAwMCArMDIwMAorKysgL21udC9pY2Uvc3JjL2Fsc2EtbGliLTEuMC42L3NyYy9wY20v
cGNtX3JhdGUuYwkyMDA0LTExLTIyIDAyOjUzOjEzLjAwMDAwMDAwMCArMDEwMApAQCAtMTA4Miw3
ICsxMDgyLDYgQEAgc3RhdGljIGludCBzbmRfcGNtX3JhdGVfZ3JhYl9uZXh0X3BlcmlvZAogCQkJ
cmV0dXJuIDA7CiAJCX0KIAl9IGVsc2UgewotCQlzbmRfcGNtX3JhdGVfdCAqcmF0ZSA9IHBjbS0+
cHJpdmF0ZV9kYXRhOwogCQlzbmRfcGNtX3VmcmFtZXNfdCB4ZmVyOwogCiAJCS8qIG9rLCBncmFi
IGZpcnN0IGZyYWdtZW50ICovCg==

--========GMXBoundary79791101081531--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

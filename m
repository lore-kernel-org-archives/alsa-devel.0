From: Erik Albert <albert17@umcs.maine.edu>
Subject: Gateway M675PRR notebook, Sigmatel STAC9758
Date: Mon,  7 Feb 2005 13:13:21 -0500
Message-ID: <20050207131321.r9essh2fs0k4oss4@sith.umcs.maine.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_4vxoee1gszk"
Content-Transfer-Encoding: 7bit
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

This message is in MIME format.

--=_4vxoee1gszk
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On my Gateway M675PRR notebook, the vendor ID is reported as 0xffff.  I needed
to change the test in the ac97_patch.c file to get the special m675_regs to be
used.

--- ac97_patch.c        2005-02-07 12:51:35.000000000 -0500
+++ /root/ac97_patch.c  2005-02-07 12:50:10.303610056 -0500
@@ -657,7 +657,7 @@

        /* Gateway M675 notebook */
        if (ac97->pci &&
-           ac97->subsystem_vendor == 0x107b &&
+           (ac97->subsystem_vendor == 0x107b || ac97->subsystem_vendor ==
0xffff) &&
            ac97->subsystem_device == 0x0601)
                pregs = m675_regs;



--=_4vxoee1gszk
Content-Type: application/pgp-keys
Content-Description: PGP Public Key
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.2.4 (GNU/Linux)

mQGiBECEHZ8RBADeck19M75GLJ0hOOiEEAKT/iaprAubK8eH/Oj6+aHTH8c4s8Zc
Yk5fsHW4QWFZmzM2BcOPmhbV3JHHG0BQQPfqoiMrLWmg6uYaze4RLx2t9665lgVB
6KQJZ44vggddr9NJ6u2ZJujWep2UHHiX/elgc6P49/L0o5gBJqZJ2EZzfwCg5g1y
3duPdile61yrI4poaZpV9jMD/3DZ1Adx+5/79KEcVSlBDTNP9FoHpIycO5aJ3POU
dOl12Tc9dme8iO7hyxYttWilaQJBxXG/cZe+lp2M5Nd/4by+mjZNg663vT4Y9qcR
O8RObywKQnW8RBP82g1Q84iSYWXB9k9Z8PTObLM6dcEgyVdVpGtFd/nsq5xck2SD
QZV5A/9/1+tMKwjKdLIlQp2+1XArcSpAs3pWt5SBAa1XoPmVPbGjwROCrQQuBdL+
S7aNVn414ua1cN2HSF0bCZiVcGNxnvbIVSBte+C2B9idyewSPC4TdypCzqtZu07A
MIGDk4lnF4ULvSmgkOdquNVz3N2p1cIUk89ZPW3+orY2gwidk7QlRXJpayBBbGJl
cnQgPGFsYmVydDE3QHVtY3MubWFpbmUuZWR1PohbBBMRAgAbBQJAhB2fBgsJCAcD
AgMVAgMDFgIBAh4BAheAAAoJEJOiQBYr+pxj51sAoMm/DABISakywkAVGlDqfJ8M
Yq0oAKC8xsOrFmdPgAgW00Kk2EQSla2TyrkCDQRAhB2lEAgAkxdbTDSLDl0WgwAu
/4NbGoIB+cToQCSIAW7STppz4nonTNAxEhT+rLEHJ08JjM36P5ud/uvpT93uQsID
8l6FyP7byEsYN96tsZfRAMIEHLfu0ihqj9pkg0RsZcdwNzzPNczUwB2i/omMJR+k
2auOqoi2lNVdmPjmFEedpZXgaD1gBSK5OpOACju88k/9DfW2s+KZ1jtR7n+AiPbU
ZWDNegCdp7qmKnEONMurFe7/nWWDiihq0pdrU+mDeXDzkTKpk1pK+m1ezCnt1yFN
Bdw5ehM3kE3M7S07mayIWWkD4Wg5WE+BB51WVBXKjCoVo5zVfC9JzbcY4wV3q9Jm
IHzPmwADBQf9EVr956tosLBV5EoOAkmw2lsejqb2KQ+3JvNMjVe3XL3ZWO9uHBqj
zLzWpTlYmn1sVw+y/4Ngvjv9xd6KgLW25KOgOABzKcXbrQY5issyxOwuKBUclLlw
NAR9a4HKy8nsE1gOjp+IeMESEjEoJP/gaHTAYnqeXzVXOrBwAm1y8Tc6nRYvx9C7
/n3J6N2toCG9xTGY88EyLu5cOEyvCPq3wU9kGcGVDkqByn1esdkioIED4czuxA9b
YOxHTIurf+LL8nXeChI8onWDhRQdL/e/RxD2QYNEJmhP15OKHBErsKisWUQyFmPj
MJiW02OwvqJFWNTUW+hzuu9LZA4/+a8y/YhGBBgRAgAGBQJAhB2lAAoJEJOiQBYr
+pxjs+4AoNMPG3lfNIN0wsosdLP/XxpnNQwEAJwIVDgvbFltIX7HYcAn4x7iBZCc
FA==
=VuOQ
-----END PGP PUBLIC KEY BLOCK-----

--=_4vxoee1gszk--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl

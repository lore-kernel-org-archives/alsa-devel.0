From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: [PATCH] alsamixer
Date: Tue, 27 May 2003 20:36:34 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030527203635.27840.h002.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1054092994-27840-0"
Content-Transfer-Encoding: binary
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

This is a multi-part message in MIME format...

------------=_1054092994-27840-0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: binary

this patch enables alsamixer to adjust controls correctly where the min value is
negative (non-zero?)

I have tested with my controls that have ranges of -100,0 and -10,22 and it
seems to work OK.

Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html
------------=_1054092994-27840-0
Content-Type: application/octet-stream;
    name="alsamixer.c.diff";
    name="alsamixer.c.diff"
Content-Disposition: attachment; filename="alsamixer.c.diff"
Content-Transfer-Encoding: base64

SW5kZXg6IGFsc2FtaXhlci5jCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNT
IGZpbGU6IC9jdnNyb290L2Fsc2EvYWxzYS11dGlscy9hbHNhbWl4ZXIvYWxz
YW1peGVyLmMsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNjQKZGlmZiAtYyAt
dyAtdSAtcjEuNjQgYWxzYW1peGVyLmMKLS0tIGFsc2FtaXhlci5jCTI0IEZl
YiAyMDAzIDEzOjUxOjE1IC0wMDAwCTEuNjQKKysrIGFsc2FtaXhlci5jCTI4
IE1heSAyMDAzIDAzOjI0OjE3IC0wMDAwCkBAIC00OTMsNiArNDkzLDcgQEAK
ICAgICAgIHZvbDEgPSBtYXg7CiAgICAgZWxzZQogICAgICAgdm9sMSA9IG1p
eGVyX2NvbnYodm9sMSwgMCwgMTAwLCBtaW4sIG1heCk7CisgICAgdm9sMSAt
PSBtaW47IC8vIGNvbnZlcnQgdmFsdWUgdG8gYSBkZWx0YSBpbiB1bml0cyBv
ZiB0aGUgdm9sdW1lIGNvbnRyb2wuCiAgICAgaWYgKHZvbDEgPD0gMCkKICAg
ICAgIHZvbDEgPSAxOwogICAgIGlmICh2b2wgPCAwKQpAQCAtNTgzLDcgKzU4
NCw5IEBACiAgICAgICB2YmFsYW5jZSAvPSAyOwogICAgIH0gZWxzZQogICAg
ICAgdnJpZ2h0ID0gdmxlZnQ7Ci0gICAgaWYgKHZsZWZ0ID49IDAgJiYgdnJp
Z2h0ID49IDApIHsKKyAgICAvKiBMZWF2ZSByYW5nZSBjaGVja2luZyB0byBt
aXhlcl9jYWxjX3ZvbHVtZSAqLworICAgIC8qIGlmICh2bGVmdCA+PSAwICYm
IHZyaWdodCA+PSAwKSovIAorICAgIHsKICAgICAgIGlmIChqb2luZWQpIHsK
IAlmb3IgKGNobiA9IDA7IGNobiA8IFNORF9NSVhFUl9TQ0hOX0xBU1Q7IGNo
bisrKQogCSAgaWYgKHR5cGUgIT0gTUlYRVJfRUxFTV9DQVBUVVJFKSB7Cg==

------------=_1054092994-27840-0--


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge

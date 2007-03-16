From: "Joachim Deguara" <joachim.deguara@amd.com>
Subject: HDA buffer alignment
Date: Fri, 16 Mar 2007 12:54:02 +0100
Message-ID: <45FA855A.3040205@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=------------020903050804070205080204
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020903050804070205080204
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

>From the HDA spec it appears that the buffers written to the BDL and
sent to a codec must be 128 byte aligned (section 4.5.1).  The alignment
was not happening especially when playing 6 channels.  This patch set
the alignment of buffers and periods to 128 bytes.

-Joachim

--------------020903050804070205080204
Content-Type: text/plain;
 name=align_hda_buffers
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename=align_hda_buffers

ZGlmZiAtciBmODI4NDI2MWIyYmUgcGNpL2hkYS9oZGFfaW50ZWwuYwotLS0gYS9wY2kvaGRh
L2hkYV9pbnRlbC5jCVRodSBNYXIgMTUgMTU6MTA6MjggMjAwNyArMDEwMAorKysgYi9wY2kv
aGRhL2hkYV9pbnRlbC5jCUZyaSBNYXIgMTYgMDY6MzQ6MDMgMjAwNyArMDEwMApAQCAtMTA4
Nyw2ICsxMDg3LDEwIEBAIHN0YXRpYyBpbnQgYXp4X3BjbV9vcGVuKHN0cnVjdCBzbmRfcGNt
X3MKIAlydW50aW1lLT5ody5yYXRlcyA9IGhpbmZvLT5yYXRlczsKIAlzbmRfcGNtX2xpbWl0
X2h3X3JhdGVzKHJ1bnRpbWUpOwogCXNuZF9wY21faHdfY29uc3RyYWludF9pbnRlZ2VyKHJ1
bnRpbWUsIFNORFJWX1BDTV9IV19QQVJBTV9QRVJJT0RTKTsKKwlzbmRfcGNtX2h3X2NvbnN0
cmFpbnRfc3RlcChydW50aW1lLCAwLCBTTkRSVl9QQ01fSFdfUEFSQU1fQlVGRkVSX0JZVEVT
LAorMTI4KTsKKyAgICAgICAgc25kX3BjbV9od19jb25zdHJhaW50X3N0ZXAocnVudGltZSwg
MCwgU05EUlZfUENNX0hXX1BBUkFNX1BFUklPRF9CWVRFUywKKzEyOCk7CiAJaWYgKChlcnIg
PSBoaW5mby0+b3BzLm9wZW4oaGluZm8sIGFwY20tPmNvZGVjLCBzdWJzdHJlYW0pKSA8IDAp
IHsKIAkJYXp4X3JlbGVhc2VfZGV2aWNlKGF6eF9kZXYpOwogCQltdXRleF91bmxvY2soJmNo
aXAtPm9wZW5fbXV0ZXgpOwo=
--------------020903050804070205080204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------020903050804070205080204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------020903050804070205080204--

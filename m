From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Atom: fix regression on compress
	DAI
Date: Mon,  1 Feb 2016 13:25:16 -0600
Message-ID: <1454354716-17313-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AE2026044B
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2016 20:25:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, broonie@kernel.org, tiwai@suse.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Q29tbWl0IGExMDY4MDQ1ODgzZWQ0YTE4MzYzYTRlYmFkMGMzZDU1ZTQ3M2I3MTYgYWRkZWQgYQpk
ZXBlbmRlbmN5IG9uIHRoZSBjb21wcmVzcy1jcHUtZGFpIGNoYW5uZWxfbWluIGZpZWxkCndoaWNo
IHdhcyByZW1vdmVkIGVhcmxpZXIgYnkgY29tbWl0Cjc3MDk1Nzk2YWU5Y2JhZjMxNWY4MDYxMWVk
YjVhYTU2OTc5NmUzMzkgYXMgcGFydCBvZiB0aGUKYmF5dHJhaWwgY2xlYW51cHMuCgpUaGUgbmV0
IHJlc3VsdCB3YXMgYSByZWdyZXNzaW9uIGF0IHByb2JlIG9uIGFsbCBBdG9tIHBsYXRmb3Jtcwp3
aXRoIG5vIHNvdW5kIGNhcmQgY3JlYXRlZC4KCkZpeCBieSBhZGRpbmcgZXhwbGljaXQgaW5pdGlh
bGl6YXRpb24gZm9yIGNoYW5uZWxfbWluIHRvIDEKZm9yIHRoZSBjb21wcmVzcy1jcHUtZGFpLgoK
UmVwb3J0ZWQtYnk6IFRvYmlhcyBNw6RkZWwgPGFsc2EtZGV2ZWxAdGJzcGFjZS5kZT4KU2lnbmVk
LW9mZi1ieTogUGllcnJlLUxvdWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4
LmludGVsLmNvbT4KLS0tCiBzb3VuZC9zb2MvaW50ZWwvYXRvbS9zc3QtbWZsZC1wbGF0Zm9ybS1w
Y20uYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEv
c291bmQvc29jL2ludGVsL2F0b20vc3N0LW1mbGQtcGxhdGZvcm0tcGNtLmMgYi9zb3VuZC9zb2Mv
aW50ZWwvYXRvbS9zc3QtbWZsZC1wbGF0Zm9ybS1wY20uYwppbmRleCA1NWMzM2RjLi41MmVkNDM0
IDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvaW50ZWwvYXRvbS9zc3QtbWZsZC1wbGF0Zm9ybS1wY20u
YworKysgYi9zb3VuZC9zb2MvaW50ZWwvYXRvbS9zc3QtbWZsZC1wbGF0Zm9ybS1wY20uYwpAQCAt
NTI4LDYgKzUyOCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19kYWlfZHJpdmVyIHNzdF9wbGF0
Zm9ybV9kYWlbXSA9IHsKIAkub3BzID0gJnNzdF9jb21wcl9kYWlfb3BzLAogCS5wbGF5YmFjayA9
IHsKIAkJLnN0cmVhbV9uYW1lID0gIkNvbXByZXNzIFBsYXliYWNrIiwKKwkJLmNoYW5uZWxzX21p
biA9IDEsCiAJfSwKIH0sCiAvKiBCRSBDUFUgIERhaXMgKi8KLS0gCjEuOS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK

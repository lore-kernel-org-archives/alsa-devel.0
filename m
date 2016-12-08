From: Vinod Koul <vinod.koul@intel.com>
Subject: =?utf-8?q?=5BPATCH_11/14=5D_ASoC=3A_img=3A_remove_un?=
	=?utf-8?b?dXNlZCDigJhmb3JtYXTigJk=?=
Date: Thu,  8 Dec 2016 23:01:34 +0530
Message-ID: <1481218297-17568-12-git-send-email-vinod.koul@intel.com>
References: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 96C932674ED
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 18:32:40 +0100 (CET)
In-Reply-To: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Damien.Horsley" <Damien.Horsley@imgtec.com>
List-Id: alsa-devel@alsa-project.org

SW4gaW1nX3BybF9vdXRfaHdfcGFyYW1zKCksICdmb3JtYXQnIGlzIGluaXRpYWxpemVkIGJ1dCBu
ZXZlciB1c2VkLgpTbyByZW1vdmUgaXQuCgpzb3VuZC9zb2MvaW1nL2ltZy1wYXJhbGxlbC1vdXQu
YzogSW4gZnVuY3Rpb24g4oCYaW1nX3BybF9vdXRfaHdfcGFyYW1z4oCZOgpzb3VuZC9zb2MvaW1n
L2ltZy1wYXJhbGxlbC1vdXQuYzoxMjY6MTk6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmGZvcm1hdOKA
mSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQogIHNuZF9wY21f
Zm9ybWF0X3QgZm9ybWF0OwoKQ2M6IERhbWllbi5Ib3JzbGV5IDxEYW1pZW4uSG9yc2xleUBpbWd0
ZWMuY29tPgpTaWduZWQtb2ZmLWJ5OiBWaW5vZCBLb3VsIDx2aW5vZC5rb3VsQGludGVsLmNvbT4K
LS0tCiBzb3VuZC9zb2MvaW1nL2ltZy1wYXJhbGxlbC1vdXQuYyB8IDIgLS0KIDEgZmlsZSBjaGFu
Z2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9pbWcvaW1nLXBhcmFs
bGVsLW91dC5jIGIvc291bmQvc29jL2ltZy9pbWctcGFyYWxsZWwtb3V0LmMKaW5kZXggYzE2MTBh
MDU0ZDY1Li4zM2NlYjIwN2VlNzAgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9pbWcvaW1nLXBhcmFs
bGVsLW91dC5jCisrKyBiL3NvdW5kL3NvYy9pbWcvaW1nLXBhcmFsbGVsLW91dC5jCkBAIC0xMjMs
MTAgKzEyMyw4IEBAIHN0YXRpYyBpbnQgaW1nX3BybF9vdXRfaHdfcGFyYW1zKHN0cnVjdCBzbmRf
cGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAogCXN0cnVjdCBpbWdfcHJsX291dCAqcHJsID0gc25k
X3NvY19kYWlfZ2V0X2RydmRhdGEoZGFpKTsKIAl1bnNpZ25lZCBpbnQgcmF0ZSwgY2hhbm5lbHM7
CiAJdTMyIHJlZywgY29udHJvbF9zZXQgPSAwOwotCXNuZF9wY21fZm9ybWF0X3QgZm9ybWF0Owog
CiAJcmF0ZSA9IHBhcmFtc19yYXRlKHBhcmFtcyk7Ci0JZm9ybWF0ID0gcGFyYW1zX2Zvcm1hdChw
YXJhbXMpOwogCWNoYW5uZWxzID0gcGFyYW1zX2NoYW5uZWxzKHBhcmFtcyk7CiAKIAlzd2l0Y2gg
KHBhcmFtc19mb3JtYXQocGFyYW1zKSkgewotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=

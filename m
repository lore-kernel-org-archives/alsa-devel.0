From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH V4 1/3] ASoC: fsl_asrc: Fix the issue about unsupported rate
Date: Fri, 19 Apr 2019 10:23:50 +0000
Message-ID: <06c3e420b9fabfbec67becc2f9de009ce79a1d4b.1555669068.git.shengjiu.wang@nxp.com>
References: <cover.1555669068.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <cover.1555669068.git.shengjiu.wang@nxp.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

V2hlbiB0aGUgb3V0cHV0IHNhbXBsZSByYXRlIGlzIFs4a0h6LCAzMGtIel0sIHRoZSBsaW1pdGF0
aW9uDQpvZiB0aGUgc3VwcG9ydGVkIHJhdGlvIHJhbmdlIGlzICgxLzI0LCA4KS4gSW4gdGhlIGRy
aXZlcg0Kd2UgdXNlICg4a0h6LCAzMGtIeikgaW5zdGVhZCBvZiBbOGtIeiwgMzBrSHpdLg0KU28g
dGhpcyBwYXRjaCBpcyB0byBmaXggdGhpcyBpc3N1ZSBhbmQgdGhlIHBvdGVudGlhbCByb3VuZGlu
Zw0KaXNzdWUgd2l0aCBkaXZpZGVyLg0KDQpGaXhlczogZmZmNmUwM2M3YjY1ICgiQVNvQzogZnNs
X2FzcmM6IGFkZCBzdXBwb3J0IGZvciA4LTMwa0h6DQpvdXRwdXQgc2FtcGxlIHJhdGUiKQ0KQ2M6
IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogU2hlbmdqaXUgV2FuZyA8
c2hlbmdqaXUud2FuZ0BueHAuY29tPg0KLS0tDQogc291bmQvc29jL2ZzbC9mc2xfYXNyYy5jIHwg
OCArKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2ZzbF9hc3JjLmMgYi9zb3VuZC9zb2Mv
ZnNsL2ZzbF9hc3JjLmMNCmluZGV4IDBiOTM3OTI0ZDJlNC4uNWI4YWRjN2ZiMTE3IDEwMDY0NA0K
LS0tIGEvc291bmQvc29jL2ZzbC9mc2xfYXNyYy5jDQorKysgYi9zb3VuZC9zb2MvZnNsL2ZzbF9h
c3JjLmMNCkBAIC0yODIsMTAgKzI4MiwxMCBAQCBzdGF0aWMgaW50IGZzbF9hc3JjX2NvbmZpZ19w
YWlyKHN0cnVjdCBmc2xfYXNyY19wYWlyICpwYWlyKQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogCX0N
CiANCi0JaWYgKChvdXRyYXRlID4gODAwMCAmJiBvdXRyYXRlIDwgMzAwMDApICYmDQotCSAgICAo
b3V0cmF0ZS9pbnJhdGUgPiAyNCB8fCBpbnJhdGUvb3V0cmF0ZSA+IDgpKSB7DQotCQlwYWlyX2Vy
cigiZXhjZWVkIHN1cHBvcnRlZCByYXRpbyByYW5nZSBbMS8yNCwgOF0gZm9yIFwNCi0JCQkJaW5y
YXRlL291dHJhdGU6ICVkLyVkXG4iLCBpbnJhdGUsIG91dHJhdGUpOw0KKwlpZiAoKG91dHJhdGUg
Pj0gODAwMCAmJiBvdXRyYXRlIDw9IDMwMDAwKSAmJg0KKwkgICAgKG91dHJhdGUgPiAyNCAqIGlu
cmF0ZSB8fCBpbnJhdGUgPiA4ICogb3V0cmF0ZSkpIHsNCisJCXBhaXJfZXJyKCJleGNlZWQgc3Vw
cG9ydGVkIHJhdGlvIHJhbmdlICgxLzI0LCA4KSBmb3IgaW5yYXRlL291dHJhdGU6ICVkLyVkXG4i
LA0KKwkJCQlpbnJhdGUsIG91dHJhdGUpOw0KIAkJcmV0dXJuIC1FSU5WQUw7DQogCX0NCiANCi0t
IA0KMS45LjENCg0K

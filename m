From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] Fixes for AMD Stoney ACP audio
Date: Fri,  3 Nov 2017 16:35:42 -0400
Message-ID: <1509741345-1589-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org
Cc: tiwai-l3A5Bk7waGM@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

VGhpcyBwYXRjaCBzZXQgaXMganVzdCBhIGNvdXBsZSBmaXhlcyBmb3IgdGhlIEF1ZGlvIENvUHJv
Y2Vzc29yIChBQ1ApCm9uIEFNRCBTdG9uZXkgcGxhdGZvcm1zIGFuZCBhIHNtYWxsIGdlbmVyYWwg
Zml4IGZvciB0aGUgcnQ1NjQ1CmNvZGVjIGRyaXZlci4KClRoZSBlbnRpcmUgcGF0Y2ggc2V0IGNh
biBhbHNvIGJlIHZpZXdlZCBoZXJlOgpodHRwczovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL35hZ2Q1
Zi9saW51eC9sb2cvP2g9c291bmQtZm9yLW5leHQtc3RvbmV5CgpUaGFua3MhCgpBbGV4CgpBa3No
dSBBZ3Jhd2FsICgyKToKICBBU29DOiBBTUQ6IE1ha2UgdGhlIGRyaXZlciBuYW1lIGNvbnNpc3Rl
bnQgYWNyb3NzIGZpbGVzCiAgQVNvQzogcnQ1NjQ1OiBXYWl0IGZvciA0MDBtc2VjIGJlZm9yZSBj
b25jbHVkaW5nIG9uIHZhbHVlIG9mCiAgICBSVDU2NDVfVkVORE9SX0lEMgoKVmlqZW5kYXIgTXVr
dW5kYSAoMSk6CiAgQVNvQzogYW1kOiBSZXBvcnQgYWNjdXJhdGUgaHdfcHRyIGR1cmluZyBkbWEK
CiBzb3VuZC9zb2MvYW1kL01ha2VmaWxlICAgICAgfCAgNCArLS0KIHNvdW5kL3NvYy9hbWQvYWNw
LXBjbS1kbWEuYyB8IDc3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tLQogc291bmQvc29jL2FtZC9hY3AuaCAgICAgICAgIHwgMTAgKysrKysrCiBzb3VuZC9zb2Mv
Y29kZWNzL3J0NTY0NS5jICAgfCAxMiArKysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDczIGluc2Vy
dGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQoKLS0gCjIuNS41CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK

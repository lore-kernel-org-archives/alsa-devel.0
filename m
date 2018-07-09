From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] vgaswitchroo: set audio client id according to bound gpu
 client id
Date: Mon, 9 Jul 2018 11:27:59 +0200
Message-ID: <20180709092759.GA3649@wunner.de>
References: <1530166933-21655-1-git-send-email-Jim.Qu@amd.com>
 <CADnq5_NcNfMD9UDN17c-513rD--kQY7nzw6OTgimV0pVqLjbOg@mail.gmail.com>
 <DM3PR12MB08737CF35AF6D0CE1A1BDC64994E0@DM3PR12MB0873.namprd12.prod.outlook.com>
 <20180629080634.GA7357@wunner.de>
 <DM3PR12MB08737DC9FB94BB6F3AEF5634994E0@DM3PR12MB0873.namprd12.prod.outlook.com>
 <20180629092138.GA11849@wunner.de>
 <DM3PR12MB08732DAAAA57739DCE431D66994E0@DM3PR12MB0873.namprd12.prod.outlook.com>
 <20180629111108.GA11609@wunner.de>
 <DM3PR12MB0873FEC702770190057B49F799440@DM3PR12MB0873.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <DM3PR12MB0873FEC702770190057B49F799440-4hRkV8tDpBiYEITDcfEJ8AdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Qu, Jim" <Jim.Qu-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBKdWwgMDksIDIwMTggYXQgMDg6NTI6MzNBTSArMDAwMCwgUXUsIEppbSB3cm90ZToK
PiBOb3csIEkgZm91bmQgdGhlIGF1ZGlvIGRldmljZSB3aWxsIGF1dG8gc3VzcGVuZCBldmVuIGlm
IHRoZSBncHUgaXMgYWN0aXZlLAo+IGFuZCBpZiBJIHBsdWcgaW4gYSBIRE1JIGRldmljZSBpdCBh
bHNvIGRvIG5vdCByZXN1bWUgYmFjay4gCj4gCj4gMS4gRGlkIHlvdSBlbmNvdW50ZXIgc2ltaWxh
ciBpc3N1ZSBiZWZvcmU/Cj4gMi4gYXVkaW8gd2lsbCBhdXRvIHN1c3BlbmQgYXMgZGVmYXVsdCBh
dCBiZWdpbm5pbmcgb2YgYm9vdCwgaXMgaXQgZXhwZWN0Cj4gYmVoYXZpb3VyPwoKWWVzLCB0aGF0
J3MgZXhwZWN0ZWQuICBPbmNlIHlvdSBzdGFydCBzdHJlYW1pbmcgYXVkaW8gdG8gYXR0YWNoZWQg
ZGlzcGxheXMsCnVzZXIgc3BhY2Ugb3BlbnMgdGhlIGNvZGVjIGRldmljZSBhbmQgdGhpcyBjYXVz
ZXMgdGhlIEhEQSBjb250cm9sbGVyIHRvCnJ1bnRpbWUgcmVzdW1lLiAgSWYgdGhlIGRpc2NyZXRl
IEdQVSBpcyBzdXNwZW5kZWQgYXQgdGhhdCBtb21lbnQsIGl0IHdpbGwKYmUgcG93ZXJlZCBvbiBh
bmQga2VwdCBwb3dlcmVkIG9uIGFzIGxvbmcgYXMgdXNlciBzcGFjZSBpcyBzdHJlYW1pbmcgYXVk
aW8uCgpEbyB5b3UgbmVlZCB0byBydW50aW1lIHJlc3VtZSB0aGUgSERBIGNvbnRyb2xsZXIgZXZl
biBpZiB1c2VyIHNwYWNlIGlzbid0CnN0cmVhbWluZyBhdWRpbz8gIFdoeSwgYW5kIGluIHdoaWNo
IHNpdHVhdGlvbiBleGFjdGx5PwoKWW91J3JlIHNheWluZyBhYm92ZSB0aGF0IHRoZSBIREEgY29u
dHJvbGxlciBpc24ndCBydW50aW1lIHJlc3VtZWQgb24KaG90cGx1ZyBvZiBhIGRpc3BsYXkuICBJ
cyB0aGF0IG5lY2Vzc2FyeSB0byByZXRyaWV2ZSBFTEQgb3Igc29tZXRoaW5nPwpJJ20gbm90IHN1
cmUgaWYgdGhlcmUncyBjb2RlIGluIHRoZSBIREEgZHJpdmVyIHRvIGFjcXVpcmUgYSBydW50aW1l
IFBNCnJlZiBvbiBIUEQsIGJ1dCBtYXliZSBpdCdzIG5lY2Vzc2FyeS4gIE9yIG1heWJlIHRoZSBj
b2RlIGlzIHRoZXJlIGJ1dApzb21laG93IG5vIEhQRCBpbnRlcnJ1cHQgaXMgcmVjZWl2ZWQgYnkg
dGhlIEhEQSBkcml2ZXI/CgpUaGFua3MsCgpMdWthcwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK

From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] caiaq/NativeInstruments: input
	handling fixes
Date: Wed, 21 Nov 2007 08:34:33 -0500
Message-ID: <d120d5000711210534t75887c73labdb17eea0cefb88@mail.gmail.com>
References: <20071120133528.GB4425@buzzloop.caiaq.de>
	<s5hd4u3j51s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_25984_8521743.1195652073684"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 4175324C1D
	for <Alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 14:34:35 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id h2so107968ugf
	for <Alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 05:34:34 -0800 (PST)
In-Reply-To: <s5hd4u3j51s.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_25984_8521743.1195652073684
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Nov 21, 2007 4:55 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 20 Nov 2007 14:35:28 +0100,
> Daniel Mack wrote:
> >
> > Hi,
> >
> > I'm re-posting a patch from Dmitry Torokhov which cleans up some input
> > layer related things. It hasn't made its way to any repository yet but

Yes, I am being slow lately, sorry.

> > my subsequent patch needs it as dependency. I Cc'ed Dmitry to avoid
> > confusion.
>
> Dmitry, will this patch go to 2.6.24 from your tree?
>
> If it's a 2.6.25 material,

Yes, it is .25 material.

> then I'd like to put it rather to ALSA
> tree together with Daniel's another patch.

Thet would be great. The only reason I offered to send through my tree
is that I did not see any response from you guys... I actually prefer
not to touch code outside of drivers/input.

BTW, attached is a small Kconfig patchs for caiaq. Probably good for .24.

-- 
Dmitry

------=_Part_25984_8521743.1195652073684
Content-Type: application/octet-stream; name=caiaq-depend-on-input.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f99wby1i0
Content-Disposition: attachment; filename=caiaq-depend-on-input.patch

U09VTkQ6IGNhaWFxIC0gaW5wdXQgZGV2aWNlIHN1cHBvcnQgbXVzdCBkZXBlbmQgb24gQ09ORklH
X0lOUFVUCgpTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgVG9yb2tob3YgPGR0b3JAbWFpbC5ydT4KLS0t
CiBzb3VuZC91c2IvS2NvbmZpZyB8ICAgIDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspCgpJbmRleDogbGludXgvc291bmQvdXNiL0tjb25maWcKPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgu
b3JpZy9zb3VuZC91c2IvS2NvbmZpZworKysgbGludXgvc291bmQvdXNiL0tjb25maWcKQEAgLTUx
LDYgKzUxLDcgQEAgY29uZmlnIFNORF9VU0JfQ0FJQVEKIGNvbmZpZyBTTkRfVVNCX0NBSUFRX0lO
UFVUCiAJYm9vbCAiZW5hYmxlIGlucHV0IGRldmljZSBmb3IgY29udHJvbGxlcnMiCiAJZGVwZW5k
cyBvbiBTTkRfVVNCX0NBSUFRCisJZGVwZW5kcyBvbiBJTlBVVD15IHx8IElOUFVUPVNORF9VU0Jf
Q0FJQVEKIAloZWxwCiAJICBTYXkgWSBoZXJlIHRvIHN1cHBvcnQgaW5wdXQgY29udHJvbGxlcnMg
bGlrZSBidXR0b25zLCBrbm9icywKIAkgIGFscGhhIGRpYWxzIGFuZCBhbmFsb2cgcGVkYWxzIG9u
IHRoZSBmb2xsb3dpbmcgcHJvZHVjdHM6Cg==
------=_Part_25984_8521743.1195652073684
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_25984_8521743.1195652073684--

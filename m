From: Sophie Hamilton <sophie-alsa@theblob.org>
Subject: Re: Problems with safe API and snd-cs46xx
Date: Mon, 7 Sep 2009 18:04:12 +0100
Message-ID: <a080dbc80909071004h13a17f2bg3dd06ffd90cd72f4@mail.gmail.com>
References: <a080dbc80909050524o7b00ceas46184b52fdac9cbc@mail.gmail.com>
	<s5hljkrrl3s.wl%tiwai@suse.de>
	<a080dbc80909070802u544c185erc1efb3f87a95a190@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175cff16c1e1c40472ffd604
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id DD44F24458
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 19:04:14 +0200 (CEST)
Received: by fxm3 with SMTP id 3so2171018fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 07 Sep 2009 10:04:13 -0700 (PDT)
In-Reply-To: <a080dbc80909070802u544c185erc1efb3f87a95a190@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0015175cff16c1e1c40472ffd604
Content-Type: text/plain; charset=ISO-8859-1

On 9/7/09, Sophie Hamilton <sophie-alsa@theblob.org> wrote:
>  I decided to go investigating myself and discovered that the cs46xx
>  driver has a silly minimum period size declared of 1. Increasing this
>  to 256 fixes the problem, though I haven't yet tested to see if lower
>  values will work too. (I'll do this and regenerate the patch later.)

Turns out that a value of 64 is the optimum value. I've regenerated
the patch, and attached it again. (And since I know now that this list
doesn't strip attachments, I didn't upload the new one.)

This should be the final patch. How should I go about submitting this?

 - Sophie.

--0015175cff16c1e1c40472ffd604
Content-Type: application/octet-stream; name="cs46xx-fix.patch"
Content-Disposition: attachment; filename="cs46xx-fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fzbgpb30

VGhpcyBwYXRjaCB3aWxsIGZpeCB0aGUgY3M0Nnh4IG1pbmltdW0gcGVyaW9kIHNpemUsIGFsbG93
aW5nIHBsYXliYWNrCm9uIGNzNDZ4eC1iYXNlZCBjYXJkcy4KClNpZ25lZC1vZmYtYnk6IFNvcGhp
ZSBIYW1pbHRvbiA8a2VybmVsQHRoZWJsb2Iub3JnPgoKLS0tIGEvc291bmQvcGNpL2NzNDZ4eC9j
czQ2eHhfbGliLmgJMjAwOS0wOS0wNyAxNToyNDoyNi4wMDAwMDAwMDAgKzAxMDAKKysrIGIvc291
bmQvcGNpL2NzNDZ4eC9jczQ2eHhfbGliLmgJMjAwOS0wOS0wNyAxNTo0MTozMS4wMDAwMDAwMDAg
KzAxMDAKQEAgLTM1LDcgKzM1LDcgQEAKIAogCiAjaWZkZWYgQ09ORklHX1NORF9DUzQ2WFhfTkVX
X0RTUAotI2RlZmluZSBDUzQ2WFhfTUlOX1BFUklPRF9TSVpFIDEKKyNkZWZpbmUgQ1M0NlhYX01J
Tl9QRVJJT0RfU0laRSA2NAogI2RlZmluZSBDUzQ2WFhfTUFYX1BFUklPRF9TSVpFIDEwMjQqMTAy
NAogI2Vsc2UKICNkZWZpbmUgQ1M0NlhYX01JTl9QRVJJT0RfU0laRSAyMDQ4Cg==
--0015175cff16c1e1c40472ffd604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0015175cff16c1e1c40472ffd604--

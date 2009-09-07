From: Sophie Hamilton <sophie-alsa@theblob.org>
Subject: Re: Problems with safe API and snd-cs46xx
Date: Mon, 7 Sep 2009 16:02:45 +0100
Message-ID: <a080dbc80909070802u544c185erc1efb3f87a95a190@mail.gmail.com>
References: <a080dbc80909050524o7b00ceas46184b52fdac9cbc@mail.gmail.com>
	<s5hljkrrl3s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00032555a9ca77f41e0472fe2469
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 924C2243C5
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 17:02:47 +0200 (CEST)
Received: by fxm3 with SMTP id 3so2100701fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 07 Sep 2009 08:02:47 -0700 (PDT)
In-Reply-To: <s5hljkrrl3s.wl%tiwai@suse.de>
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

--00032555a9ca77f41e0472fe2469
Content-Type: text/plain; charset=ISO-8859-1

On 9/7/09, Takashi Iwai <tiwai@suse.de> wrote:
> A small test case, preferably a short C program just to reproduce
>  the problem would be really needed in such a case.  It's very hard to
>  guess what's going on and what is actually wrong in the driver only
>  from your problem description, because of no obvious debug logs.

I can go one better... I have a fix. :)

I decided to go investigating myself and discovered that the cs46xx
driver has a silly minimum period size declared of 1. Increasing this
to 256 fixes the problem, though I haven't yet tested to see if lower
values will work too. (I'll do this and regenerate the patch later.)

The patch, based on the latest stable kernel tree (2.6.30.5), is
attached, though in case the mailing list strips attachments, it's
also available at http://neo.theblob.org/cs46xx-fix.patch .

If I need to submit the patch in some other way when it comes to
actually submitting the final thing, please let me know.

 - Sophie.

--00032555a9ca77f41e0472fe2469
Content-Type: application/octet-stream; name="cs46xx-fix.patch"
Content-Disposition: attachment; filename="cs46xx-fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fzbccxn2

VGhpcyBwYXRjaCB3aWxsIGZpeCB0aGUgY3M0Nnh4IG1pbmltdW0gcGVyaW9kIHNpemUsIGFsbG93
aW5nIHBsYXliYWNrCm9uIGNzNDZ4eC1iYXNlZCBjYXJkcy4KClNpZ25lZC1vZmYtYnk6IFNvcGhp
ZSBIYW1pbHRvbiA8a2VybmVsQHRoZWJsb2Iub3JnPgoKLS0tIGEvc291bmQvcGNpL2NzNDZ4eC9j
czQ2eHhfbGliLmgJMjAwOS0wOS0wNyAxNToyNDoyNi4wMDAwMDAwMDAgKzAxMDAKKysrIGIvc291
bmQvcGNpL2NzNDZ4eC9jczQ2eHhfbGliLmgJMjAwOS0wOS0wNyAxNTo0MTozMS4wMDAwMDAwMDAg
KzAxMDAKQEAgLTM1LDcgKzM1LDcgQEAKIAogCiAjaWZkZWYgQ09ORklHX1NORF9DUzQ2WFhfTkVX
X0RTUAotI2RlZmluZSBDUzQ2WFhfTUlOX1BFUklPRF9TSVpFIDEKKyNkZWZpbmUgQ1M0NlhYX01J
Tl9QRVJJT0RfU0laRSAyNTYKICNkZWZpbmUgQ1M0NlhYX01BWF9QRVJJT0RfU0laRSAxMDI0KjEw
MjQKICNlbHNlCiAjZGVmaW5lIENTNDZYWF9NSU5fUEVSSU9EX1NJWkUgMjA0OAo=
--00032555a9ca77f41e0472fe2469
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00032555a9ca77f41e0472fe2469--

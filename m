From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-lib] test/namehint.c: Removed compilation
	warning
Date: Sun, 9 Apr 2017 10:25:58 +0900
Message-ID: <4043048d-6ab7-5c79-899c-b45dfa0dbad5@sakamocchi.jp>
References: <932326173.1977898.1491628491751.ref@mail.yahoo.com>
 <932326173.1977898.1491628491751@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 2A91626669C
 for <alsa-devel@alsa-project.org>; Sun,  9 Apr 2017 03:26:04 +0200 (CEST)
In-Reply-To: <932326173.1977898.1491628491751@mail.yahoo.com>
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
List-Id: alsa-devel@alsa-project.org

On Apr 8 2017 14:14, varun sood wrote:
> Removed compilation warning Changed hint variable from char ** to void ** to match function snd_device_name_hint
> Signed-off-by: varun <soodvarun78@gmail.com>--- test/namehint.c | 5 +++-- 1 file changed, 3 insertions(+), 2 deletions(-)
> diff --git a/test/namehint.c b/test/namehint.cindex e978d5c..18bad1d 100644--- a/test/namehint.c+++ b/test/namehint.c@@ -4,7 +4,8 @@ int main(int argc, char *argv[]) {    const char *iface = "pcm";-   char **hints, **n;+   void **hints;+   char **n;    int err;
>     if (argc > 1)@@ -12,7 +13,7 @@ int main(int argc, char *argv[])    err = snd_device_name_hint(-1, iface, &hints);    if (err < 0)        errx(1, "snd_device_name_hint error: %s", snd_strerror(err));-   n = hints;+   n = (char **)hints;    while (*n != NULL) {        printf("%s\n", *n);        n++;-- 1.9.1

I note that the author contacted to me and I sent some instructions to 
post patches in better ways.


Regards

Takashi Sakamoto

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] [alsa-lib] Removed compilation warning
 from test/namehint.c
Date: Mon, 10 Apr 2017 16:31:17 +0900
Message-ID: <6de301f0-794a-ab2e-13e2-a76ac9dbde7a@sakamocchi.jp>
References: <1491759907-10912-1-git-send-email-soodvarun78@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id A1CD3266B6D
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 09:31:24 +0200 (CEST)
In-Reply-To: <1491759907-10912-1-git-send-email-soodvarun78@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: soodvarun78@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Apr 10 2017 02:45, soodvarun78@gmail.com wrote:
> From: varun <soodvarun78@gmail.com>
>
> Changed hint variable from char ** to void ** to match function snd_devic=
e_name_hint
>
> Signed-off-by: varun <soodvarun78@gmail.com>
> ---
>  test/namehint.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

This patch can suppress below compiler warnings:

```
alsa-lib/test$ make namehint
   CC       namehint.o
namehint.c: In function =91main=92:
namehint.c:12:40: warning: passing argument 3 of =91snd_device_name_hint=92 =

from incompatible pointer type [-Wincompatible-pointer-types]
   err =3D snd_device_name_hint(-1, iface, &hints);
                                         ^
In file included from ../include/asoundlib.h:58:0,
                  from namehint.c:1:
../include/alsa/control.h:228:5: note: expected =91void ***=92 but argument =

is of type =91char ***=92
  int snd_device_name_hint(int card, const char *iface, void ***hints);
      ^~~~~~~~~~~~~~~~~~~~
namehint.c:20:28: warning: passing argument 1 of =

=91snd_device_name_free_hint=92 from incompatible pointer type =

[-Wincompatible-pointer-types]
   snd_device_name_free_hint(hints);
                             ^~~~~
In file included from ../include/asoundlib.h:58:0,
                  from namehint.c:1:
../include/alsa/control.h:229:5: note: expected =91void **=92 but argument =

is of type =91char **=92
  int snd_device_name_free_hint(void **hints);
      ^~~~~~~~~~~~~~~~~~~~~~~~~
   CCLD     namehint
```

The combination of 'void ***' and 'char **' variables are also used by =

'aplay' in alsa-utils.git, therefore it's not so odd.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/test/namehint.c b/test/namehint.c
> index e978d5c..18bad1d 100644
> --- a/test/namehint.c
> +++ b/test/namehint.c
> @@ -4,7 +4,8 @@
>  int main(int argc, char *argv[])
>  {
>  	const char *iface =3D "pcm";
> -	char **hints, **n;
> +	void **hints;
> +	char **n;
>  	int err;
>
>  	if (argc > 1)
> @@ -12,7 +13,7 @@ int main(int argc, char *argv[])
>  	err =3D snd_device_name_hint(-1, iface, &hints);
>  	if (err < 0)
>  		errx(1, "snd_device_name_hint error: %s", snd_strerror(err));
> -	n =3D hints;
> +	n =3D (char **)hints;
>  	while (*n !=3D NULL) {
>  		printf("%s\n", *n);
>  		n++;


Thanks

Takashi Sakamoto

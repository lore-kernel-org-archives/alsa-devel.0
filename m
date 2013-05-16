From: Olivier Langlois <olivier@trillion01.com>
Subject: Re:
 =?utf-8?q?=5BPATCH_5/8=5D_Fix_spelling_of_=E2=80=9Cs?=
 =?utf-8?b?dWNjZXNzZnVsbHnigJ0u?=
Date: Wed, 15 May 2013 21:48:54 -0400
Message-ID: <1368668934.1131.13.camel@Wailaba2>
References: <1368638351-29200-1-git-send-email-jordi@debian.org>
 <1368638351-29200-6-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy9.bluehost.com (oproxy9.bluehost.com [69.89.24.6])
 by alsa0.perex.cz (Postfix) with SMTP id 1E1BF2616EF
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 03:48:57 +0200 (CEST)
In-Reply-To: <1368638351-29200-6-git-send-email-jordi@debian.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jordi Mallach <jordi@debian.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jordi,

Just nitpicking but while you're correcting typos, there is another one
right in the diff.

Should Crative Sound Blaster not be Creative Sound Blaster? :-)


On Wed, 2013-05-15 at 19:19 +0200, Jordi Mallach wrote:
> Signed-off-by: Jordi Mallach <jordi@debian.org>
> ---
>  sb16_csp/cspctl.1 |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sb16_csp/cspctl.1 b/sb16_csp/cspctl.1
> index 71c4b52..d2f7b5d 100644
> --- a/sb16_csp/cspctl.1
> +++ b/sb16_csp/cspctl.1
> @@ -13,7 +13,7 @@ is a simple CSP microcode loader for Crative Sound Blaster 16ASP and some Sound
>  .B cspctl
>  can also be used as a post-install function to
>  .I snd\-sb16\-csp
> -module to load default codec at module installation. If CSP chip is succesfully detected and initialized, it will be installed as a hardware dependant device
> +module to load default codec at module installation. If CSP chip is successfully detected and initialized, it will be installed as a hardware dependent device
>  .I hwC0D2
>  into /dev/snd directory. Currently, following codecs can be loaded to CSP device:
>  .IP "" 4

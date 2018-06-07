From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] speaker-test: Allow sampling rates up to
	768000
Date: Thu, 7 Jun 2018 17:13:33 +0800
Message-ID: <CAOf5uwmCcpu_+A_nykXdWqn2pHsiNWtTtQXQNOKkCPLYRyswZg@mail.gmail.com>
References: <20180607091055.27404-1-julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 8618E266E76
 for <alsa-devel@alsa-project.org>; Thu,  7 Jun 2018 11:13:34 +0200 (CEST)
Received: by mail-wm0-f43.google.com with SMTP id j15-v6so17461357wme.0
 for <alsa-devel@alsa-project.org>; Thu, 07 Jun 2018 02:13:34 -0700 (PDT)
In-Reply-To: <20180607091055.27404-1-julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: Takashi Iwai <tiwai@suse.de>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

On Thu, Jun 7, 2018 at 5:10 PM, Julian Scheel <julian@jusst.de> wrote:
> There are audio devices around that support up to 768kHz playback, allow
> testing them by increasing the maximum supported sampling rate.
>
> Signed-off-by: Julian Scheel <julian@jusst.de>
> ---
>  speaker-test/speaker-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
> index 0cdecb3..773af0a 100644
> --- a/speaker-test/speaker-test.c
> +++ b/speaker-test/speaker-test.c
> @@ -1034,7 +1034,7 @@ int main(int argc, char *argv[]) {
>      case 'r':
>        rate = atoi(optarg);
>        rate = rate < 4000 ? 4000 : rate;
> -      rate = rate > 384000 ? 384000 : rate;
> +      rate = rate > 768000 ? 768000 : rate;

Working with dsd and PCM, I'm scared about the ssd or network storage needed ;).
BTW in the past I work even on no-conventional audio device, can we
just add some flag to force any frequency or
read the max rate supported by audio card?

Michael

>        break;
>      case 'c':
>        channels = atoi(optarg);
> --
> 2.17.0
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |

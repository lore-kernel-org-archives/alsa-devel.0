From: John Lindgren <john.lindgren@tds.net>
Subject: Re: [PATCH] Memory leak in namehint.c
Date: Tue, 20 Jul 2010 18:38:37 -0400
Message-ID: <4C46256D.7070201@tds.net>
References: <4C45F868.7060807@tds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BC362434C
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 00:38:42 +0200 (CEST)
Received: by qyk27 with SMTP id 27so2461713qyk.17
	for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2010 15:38:41 -0700 (PDT)
In-Reply-To: <4C45F868.7060807@tds.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Please disregard the previous patch as it has the potential for a double
free() if snd_card_get_name() fails.  Here is a corrected patch.

Signed-off-by: John Lindgren <john.lindgren@tds.net>
---

 src/control/namehint.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/control/namehint.c b/src/control/namehint.c
index 78572d8..1819292 100644
--- a/src/control/namehint.c
+++ b/src/control/namehint.c
@@ -471,6 +471,8 @@ static int get_card_name(struct hint_list *list, int card)
        char scard[16], *s;
        int err;
 
+       free(list->cardname);
+       list->cardname = NULL;
        err = snd_card_get_name(card, &list->cardname);
        if (err <= 0)
                return 0;


On 07/20/2010 03:26 PM, John Lindgren wrote:
> get_card_name() can be called more than once on the same list, so it
> must free the previous list->cardname before replacing it.
>
> Signed-off-by: John Lindgren <john.lindgren@tds.net>
> ---
>
>  src/control/namehint.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/src/control/namehint.c b/src/control/namehint.c
> index 78572d8..fc1cb27 100644
> --- a/src/control/namehint.c
> +++ b/src/control/namehint.c
> @@ -471,6 +471,8 @@ static int get_card_name(struct hint_list *list, int card)
>         char scard[16], *s;
>         int err;
>  
> +       if (list->cardname)
> +               free(list->cardname);
>         err = snd_card_get_name(card, &list->cardname);
>         if (err <= 0)
>                 return 0;
>   

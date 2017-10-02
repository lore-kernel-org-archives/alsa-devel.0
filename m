From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 01/18] sound: use ARRAY_SIZE
Date: Sun, 01 Oct 2017 21:16:19 -0700
Message-ID: <1506917779.2274.9.camel@perches.com>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
         <20171001193101.8898-2-jeremy.lefaure@lse.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171001193101.8898-2-jeremy.lefaure@lse.epita.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?J=E9r=E9my?= Lefaure <jeremy.lefaure@lse.epita.fr>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2017-10-01 at 15:30 -0400, Jérémy Lefaure wrote:
> Using the ARRAY_SIZE macro improves the readability of the code.
> 
> Found with Coccinelle with the following semantic patch:
> @r depends on (org || report)@
> type T;
> T[] E;
> position p;
> @@
> (
>  (sizeof(E)@p /sizeof(*E))
> > 
> 
>  (sizeof(E)@p /sizeof(E[...]))
> > 
> 
>  (sizeof(E)@p /sizeof(T))
> )
[]
> diff --git a/sound/oss/ad1848.c b/sound/oss/ad1848.c
[]
> @@ -797,7 +798,7 @@ static int ad1848_set_speed(int dev, int arg)
>  
>  	int i, n, selected = -1;
>  
> -	n = sizeof(speed_table) / sizeof(speed_struct);
> +	n = ARRAY_SIZE(speed_table);

These sorts of changes are OK, but for many
uses, it's more readable to use ARRAY_SIZE(foo)
in each location rather than using a temporary.

From: stan <gryt2@q.com>
Subject: Re: Alsa buffer
Date: Tue, 14 Jul 2009 12:10:10 -0700
Message-ID: <BLU0-SMTP8480B94F50876BCF7BCF31EE230@phx.gbl>
References: <c697747b0907131855m64537b16ra2d1e24189a0381f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s19.blu0.hotmail.com (blu0-omc3-s19.blu0.hotmail.com
	[65.55.116.94]) by alsa0.perex.cz (Postfix) with ESMTP id E181A24368
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jul 2009 21:09:22 +0200 (CEST)
In-Reply-To: <c697747b0907131855m64537b16ra2d1e24189a0381f@mail.gmail.com>
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

On Tue, 14 Jul 2009 08:55:58 +0700
arif setiawan <n.arif.setiawan@gmail.com> wrote:

> into file and open it in Matlab. I want to know if this is correct,
> because when I try saving alsa buffer on a from recording I still get
> noise not the voice.
> 

>     // directly save
>     FILE *fp1 = fopen("sineout1", "w");
FILE *fp1 = fopen("sineout1", "wb");
> 
>     for (int i = 0; i < periodsize; i++)
>     {
>         fprintf_s(fp1, "%d\n", data[i]);
You are printing formatted text data here, it needs to be binary.
fwrite
>     }
> 
>     fclose(fp1);
> 
>     // with bit shifting from char to short
>     FILE *fp2 = fopen("sineout2", "w");
FILE *fp2 = fopen("sineout2", "wb");
> 
>     for (int i = 0; i < num_frames; i++)
>     {
>         short newval = data[2*i+1] << 8;
>         newval += data[2*i];
> 
>         fprintf_s(fp2, "%d\n", newval);
You are printing formatted text data here, it needs to be binary.
fwrite
>     }
> 
>     fclose(fp2);
> 
>     return 0;
> }
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

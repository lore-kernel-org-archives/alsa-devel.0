From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH] ALSA: memory leak in alsaucm
Date: Tue, 3 May 2011 08:14:57 +0800
Message-ID: <20110503001457.GA27534@qtel.sh.intel.com>
References: <BANLkTi=0c-oVOfcNL79xcY5ws9trOFVR3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <BANLkTi=0c-oVOfcNL79xcY5ws9trOFVR3w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Baek Chang <baeksan@ccrma.stanford.edu>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patch@alsa-project.org" <patch@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, May 03, 2011 at 05:56:28AM +0800, Baek Chang wrote:
> First time sending a patch, please let me know if I am doing this
> incorrectly.

Generally, we don't send patches as attachment.

As you're git, you can do three more steps.

1. commit your changes using git
   git commit -a -s
   when editor is invoked, you can input your reasons why this should be
   changed.
   the option '-s' here will add the "Signed-off-by:" line for you.

2. git format-patch -1
   this command will generate the properly formated patch for you.

3. git send-email --to alsa-devel@alsa-project.org --cc
   <sound-maintainters> *.patch
   before you can use this send-email command, you need to add some
   configuration in your .gitconfig file, consult the manual to learn more.

HTH

> 
> alsaucm is leaking memory whenever execute_cset() is called.
> 
> 
> bchang@LT74002R2XXG1:~/projects/alsa-lib-git/src/ucm$ git diff
> diff --git a/src/ucm/main.c b/src/ucm/main.c
> index 86f29e3..f8ceeeb 100644
> --- a/src/ucm/main.c
> +++ b/src/ucm/main.c
> @@ -173,7 +173,8 @@ static int execute_cset(snd_ctl_t *ctl, char *cset)
>         pos = strrchr(cset, ' ');
>         if (pos == NULL) {
>                 uc_error("undefined value for cset >%s<", cset);
> -               return -EINVAL;
> +               err =  -EINVAL;
> +               goto __fail;
>         }
>         *pos = '\0';
>         err = snd_ctl_ascii_elem_id_parse(id, cset);
> @@ -196,6 +197,14 @@ static int execute_cset(snd_ctl_t *ctl, char *cset)
>         err = 0;
>        __fail:
>         *pos = ' ';
> +
> +       if (id != NULL)
> +               free(id);
> +       if (value != NULL)
> +               free(value);
> +       if (info != NULL)
> +               free(info);
> +
>         return err;
>  }
> 
> 
> 
> Thanks
> -- 
> -baeksanchang

> diff --git a/src/ucm/main.c b/src/ucm/main.c
> index 86f29e3..f8ceeeb 100644
> --- a/src/ucm/main.c
> +++ b/src/ucm/main.c
> @@ -173,7 +173,8 @@ static int execute_cset(snd_ctl_t *ctl, char *cset)
>  	pos = strrchr(cset, ' ');
>  	if (pos == NULL) {
>  		uc_error("undefined value for cset >%s<", cset);
> -		return -EINVAL;
> +		err =  -EINVAL;
> +		goto __fail;
>  	}
>  	*pos = '\0';
>  	err = snd_ctl_ascii_elem_id_parse(id, cset);
> @@ -196,6 +197,14 @@ static int execute_cset(snd_ctl_t *ctl, char *cset)
>  	err = 0;
>        __fail:
>  	*pos = ' ';
> +
> +	if (id != NULL)
> +		free(id);
> +	if (value != NULL)
> +		free(value);
> +	if (info != NULL)
> +		free(info);
> +
>  	return err;
>  }
>  

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
guanqun

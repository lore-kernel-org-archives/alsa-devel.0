From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH/alsa-utils] amixer: fix 'cset' operation to
 set several channels
Date: Mon, 06 Apr 2015 11:33:45 +0900
Message-ID: <5521F089.6000702@sakamocchi.jp>
References: <1428287450-3665-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1428287450-3665-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@alsa-project.org, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 > [PATCH/alsa-lib] amixer: fix 'cset' operation to set several channels

Oops. This patch is for alsa-utils, sorry...

On Apr 06 2015 11:30, Takashi Sakamoto wrote:
> For an enumerated element with several channels, when given comma-separated
> string values, 'cset' operation sets these values just to the first channel,
> instead of corresponding channels.
>
> This commit adds missing-increment to fix this bug.
>
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>   amixer/amixer.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/amixer/amixer.c b/amixer/amixer.c
> index 36c92eb..e9fe735 100644
> --- a/amixer/amixer.c
> +++ b/amixer/amixer.c
> @@ -1290,8 +1290,10 @@ static int sset_enum(snd_mixer_elem_t *elem, unsigned int argc, char **argv)
>   			if (snd_mixer_selem_set_enum_item(elem, item++, ival) >= 0)
>   				check_flag = 1;
>   			/* skip separators */
> -			while (*ptr == ',' || isspace(*ptr))
> +			while (*ptr == ',' || isspace(*ptr)) {
>   				ptr++;
> +				chn++;
> +			}
>   		}
>   	}
>   	return check_flag;
>

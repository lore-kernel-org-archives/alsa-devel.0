From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/3] ASoC: bt-sco: enable OF support
Date: Wed, 17 Jul 2013 19:18:37 +0400
Message-ID: <51E6B5CD.1010001@cogentembedded.com>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Barry Song <Baohua.Song@csr.com>
Cc: Rongjun Ying <Rongjun.Ying@csr.com>, alsa-devel@alsa-project.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, Workgroup.Linux@csr.com
List-Id: alsa-devel@alsa-project.org

Hello.

On 17-07-2013 10:12, Barry Song wrote:

> From: Rongjun Ying <Rongjun.Ying@csr.com>

> this makes users be able to add a bt-sco node in dts instead of
> hardcoding a platform device in mach.

> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>   sound/soc/codecs/bt-sco.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

> diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
> index a081d9f..39e7ebe 100644
> --- a/sound/soc/codecs/bt-sco.c
> +++ b/sound/soc/codecs/bt-sco.c
[...]
> @@ -58,6 +66,9 @@ static struct platform_driver bt_sco_driver = {
>   	.driver = {
>   		.name = "bt-sco",
>   		.owner = THIS_MODULE,
> +#ifdef CONFIG_OF
> +		.of_match_table = bt_sco_of_match,
> +#endif

		.of_match_table = of_match_ptr(bt_sco_of_match),

will get rid of #ifdef here.

WBR, Sergei

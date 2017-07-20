From: Richard Leitner <dev@g0hl1n.net>
Subject: Re: [PATCH v3] ASoC: sgtl5000: add avc support
Date: Thu, 20 Jul 2017 19:25:09 +0200
Message-ID: <3b154ab9-6bbd-eb53-05e6-6d08cf3cc5c0@g0hl1n.net>
References: <1497337054-4911-1-git-send-email-richard.leitner@skidata.com>
 <CAOMZO5Cx6OrYSKYcbj6DWhn=hzS51sENadWHLSYdTkjRk9qJXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay06.alfahosting-server.de (relay06.alfahosting-server.de
 [109.237.142.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 46807266CC9
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 19:25:13 +0200 (CEST)
In-Reply-To: <CAOMZO5Cx6OrYSKYcbj6DWhn=hzS51sENadWHLSYdTkjRk9qJXw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, Richard Leitner <richard.leitner@skidata.com>
Cc: Clemens Gruber <clemens.gruber@pqgruber.com>, kalle.kankare@vincit.fi, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Eric Nelson <eric@nelint.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, dev@g0hl1n.net, Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Fabio,
thanks for the testing/reporting!

On 07/20/2017 07:11 PM, Fabio Estevam wrote:
>
> Running linux-next-20170720 on a imx53-qsb I get the following issue:
>
> root@imx53qsb:~# reboot
...
> ALSA: Storing mixer settings...
> [   20.031604] Unable to handle kernel paging request at virtual
> address fffffffe
...
> [   20.242852] Backtrace:
> [   20.245318] [<c0759ae0>] (snd_soc_component_read) from [<c0759bc8>]
> (snd_soc_read+0x1c/0x30)
> [   20.253774] [<c0759bac>] (snd_soc_read) from [<c075e19c>]
> (avc_get_threshold+0x1c/0x90)
> [   20.261798] [<c075e180>] (avc_get_threshold) from [<c07349fc>]
> (snd_ctl_ioctl+0x5b8/0xb38)
...
> If I revert a729526720059ae ("ASoC: sgtl5000: add avc support") the
> problem does not happen.
>
> Could you please fix this issue?

Does this occur only on reboot or everytime the driver tries to read the 
AVC threshold (avc_get_threshold)?
Are you able to set the AVC threshold (using amixer)?

Thanks & regards,
Richard.L

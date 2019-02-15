From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [regression] snd_soc_simple_card: refcount_t:
 underflow; use-after-free.
Date: Fri, 15 Feb 2019 16:59:01 +0200
Message-ID: <CAEnQRZDRvbmxstdZLcKx9cVg2=t0X9VhFnnNpbi8sjHJZVwuwA@mail.gmail.com>
References: <f9733cec-f945-41b0-8bf9-9b5680dcb97a@gmail.com>
 <87imxl972i.wl-kuninori.morimoto.gx@renesas.com>
 <87a7ix8szo.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 248D3265523
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 14:28:59 +0100 (CET)
Received: by mail-ed1-f45.google.com with SMTP id d9so13776866edh.12
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 05:28:59 -0800 (PST)
In-Reply-To: <87a7ix8szo.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Vicente Bergas <vicencb@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 15, 2019 at 8:41 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi Vicente, again
>
> > > of_node_put+0x24/0x30
> > > __of_get_next_child+0x50/0x70
> > > of_get_next_child+0x64/0x90
> > > asoc_simple_card_probe+0xe4/0x6b0 [snd_soc_simple_card]
> > > platform_drv_probe+0x58/0xa8
> >
> > I can't reproduce this issue, but according to this back-trace,
> > I *guess* of_get_child_count() at asoc_simple_card_parse_of()
> > is the issue (= we need of_node_get(node) before it) ?
>
> I could reproduce this issue.
> Thank you for reporting.
> I will post fixup patch soon.
> Please check it.


Hi Kuninori, Vicente,

I think I'm experimenting the same issue.

Kuninori,

The patch that you've sent is on an older kernel (from December) and the code
has changed but the problem remains in another form.

I'm having a look at this. Not sure is a problem from ASoC or from OF core.

 1.246852] OF: ERROR: Bad of_node_put() on /sound-wm8524
[    1.252259] CPU: 3 PID: 26 Comm: kworker/3:0 Not tainted
5.0.0-rc6-next-20190215-00002-g6e04e67e1342-dirty #32
[    1.262261] Hardware name: NXP i.MX8MQ EVK (DT)
[    1.266807] Workqueue: events deferred_probe_work_func
[    1.271950] Call trace:
[    1.274406]  dump_backtrace+0x0/0x158
[    1.278074]  show_stack+0x14/0x20
[    1.281396]  dump_stack+0xa8/0xcc
[    1.284717]  of_node_release+0xb0/0xc8
[    1.288474]  kobject_put+0x74/0xf0
[    1.291879]  of_node_put+0x14/0x28
[    1.295286]  __of_get_next_child+0x44/0x70
[    1.299387]  of_get_next_child+0x3c/0x60
[    1.303315]  simple_for_each_link+0x1dc/0x230
[    1.307676]  simple_probe+0x80/0x540
[    1.311256]  platform_drv_probe+0x50/0xa0
[    1.315270]  really_probe+0x20c/0x2c0
[    1.318936]  driver_probe_device+0x58/0x108
[    1.323124]  __device_attach_driver+0x94/0xb8
[    1.327485]  bus_for_each_drv+0x68/0xd0
[    1.331325]  __device_attach+0xd8/0x140
[    1.335165]  device_initial_probe+0x10/0x18
[    1.339352]  bus_probe_device+0x94/0xa0
[    1.343193]  deferred_probe_work_func+0x70/0xa8
[    1.347730]  process_one_work+0x1e8/0x330
[    1.351744]  worker_thread+0x40/0x448
[    1.355411]  kthread+0x124/0x128
[    1.358643]  ret_from_fork+0x10/0x18

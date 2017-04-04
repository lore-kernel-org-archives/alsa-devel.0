From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Question about hw_param with Ctrl-Z + fg
Date: Tue, 4 Apr 2017 13:10:12 +0900
Message-ID: <9f21e14d-e8e2-178c-abc9-fd271ec7b96a@sakamocchi.jp>
References: <redmine.issue-119657.20170403030456@dm.renesas.com>
 <redmine.journal-967542.20170403100335.fbd6fae50d6ed2e5@dm.renesas.com>
 <87d1ctuhba.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id A0BBC266A4B
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 06:10:15 +0200 (CEST)
In-Reply-To: <87d1ctuhba.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>, hiroyuki.yokoyama.vx@renesas.com
Cc: Fukawa <tomoharu.fukawa.eb@renesas.com>, shiiba <naoya.shiiba.nx@renesas.com>, mitsuhiro.kimura.kc@renesas.com, sakato <ryusuke.sakato.bx@renesas.com>, hideya.tanaka.nx@renesas.com, tomohiro.komagata.aj@renesas.com, hiroki.negishi.bx@renesas.com, hien.dang.eb@renesas.com, ryo.kodama.vz@renesas.com, Kihara <takeshi.kihara.df@renesas.com>, ryo.kataoka.wt@renesas.com, honda <takamitsu.honda.pv@renesas.com>, Chris.Paterson2@renesas.com, kouei.abe.cp@renesas.com, ren.imaoka.vj@renesas.com, goda <yusuke.goda.sx@renesas.com>, takashi.minami.xb@bp.renesas.com, takahiko.gomi.yn@renesas.com, khiem.nguyen.xt@renesas.com, yuta.wakasawa.pv@renesas.com, atsushi.tamaki.ks@renesas.com, harunobu.kurokawa.dn@renesas.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Apr 4 2017 09:54, Kuninori Morimoto wrote:
> Is this aplay issue ? or kernel issue ?
> ...
> Ctrl-Z case
> 	- aplay xxx.wav
> =>	- hw_param
> 	- SNDRV_PCM_TRIGGER_START
> 	- Ctrl-Z
> 	- SNDRV_PCM_TRIGGER_STOP
> 	- fg
> =>	- ## no hw_param here
> 	- SNDRV_PCM_TRIGGER_START
> 	- Ctrl-C (stop)
> 	- SNDRV_PCM_TRIGGER_STOP

No issues.

I think it better to implement what you want in any .prepare callbacks, 
instead of the .be_hw_params_fixup callback, because in this case, PCM 
substream lapses into XRUN state in call graph from your hw IRQ handler. 
Typical applications recover from this state by calling ioctl(PREPARE), 
without any call of ioctl(HW_PARAMS).

Actually, you can see applications call ioctl(PREPARE), before you see 
call of 'struct snd_pcm_ops.trigger(START)'.


Regards

Takashi Sakamoto

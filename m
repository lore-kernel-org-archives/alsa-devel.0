From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Question about hw_param with Ctrl-Z + fg
Date: Tue, 4 Apr 2017 15:14:55 +0900
Message-ID: <5528bc36-e9f4-1cc0-9429-94545b7e1928@sakamocchi.jp>
References: <redmine.issue-119657.20170403030456@dm.renesas.com>
 <redmine.journal-967542.20170403100335.fbd6fae50d6ed2e5@dm.renesas.com>
 <87d1ctuhba.wl%kuninori.morimoto.gx@renesas.com>
 <9f21e14d-e8e2-178c-abc9-fd271ec7b96a@sakamocchi.jp>
 <878tngvhun.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 243542666E1
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 08:14:57 +0200 (CEST)
In-Reply-To: <878tngvhun.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Fukawa <tomoharu.fukawa.eb@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>, shiiba <naoya.shiiba.nx@renesas.com>, mitsuhiro.kimura.kc@renesas.com, sakato <ryusuke.sakato.bx@renesas.com>, hideya.tanaka.nx@renesas.com, tomohiro.komagata.aj@renesas.com, hiroki.negishi.bx@renesas.com, hien.dang.eb@renesas.com, ryo.kodama.vz@renesas.com, Kihara <takeshi.kihara.df@renesas.com>, ryo.kataoka.wt@renesas.com, honda <takamitsu.honda.pv@renesas.com>, hiroyuki.yokoyama.vx@renesas.com, Chris.Paterson2@renesas.com, kouei.abe.cp@renesas.com, ren.imaoka.vj@renesas.com, goda <yusuke.goda.sx@renesas.com>, takashi.minami.xb@bp.renesas.com, takahiko.gomi.yn@renesas.com, khiem.nguyen.xt@renesas.com, yuta.wakasawa.pv@renesas.com, atsushi.tamaki.ks@renesas.com, harunobu.kurokawa.dn@renesas.com
List-Id: alsa-devel@alsa-project.org

On Apr 4 2017 14:57, Kuninori Morimoto wrote:
>>> Ctrl-Z case
>>> 	- aplay xxx.wav
>>> =>	- hw_param
>>> 	- SNDRV_PCM_TRIGGER_START
>>> 	- Ctrl-Z
>>> 	- SNDRV_PCM_TRIGGER_STOP
>>> 	- fg
>>> =>	- ## no hw_param here
>>> 	- SNDRV_PCM_TRIGGER_START
>>> 	- Ctrl-C (stop)
>>> 	- SNDRV_PCM_TRIGGER_STOP
>>
>> No issues.
>>
>> I think it better to implement what you want in any .prepare
>> callbacks, instead of the .be_hw_params_fixup callback, because in
>> this case, PCM substream lapses into XRUN state in call graph from
>> your hw IRQ handler. Typical applications recover from this state by
>> calling ioctl(PREPARE), without any call of ioctl(HW_PARAMS).
>>
>> Actually, you can see applications call ioctl(PREPARE), before you see
>> call of 'struct snd_pcm_ops.trigger(START)'.
>
> Hmm...
> Above .be_hw_params_fixup is used to convert sampling rate or channel
> number or some other related things between SoC / Codec as DPCM feature.
> Thus, I can't switch to .be_hw_params_fixup to .prepare I guess.
> But Mark, am I misunderstanding ?

In 'struct snd_pcm_ops.prepare' callback, configured parameters of PCM 
substream are available via members of 'struct snd_pcm_runtime'. The 
runtime is a member of 'struct snd_pcm_substream'. It's available in any 
of .prepare callbacks in ALSA SoC part.


Regards

Takashi Sakamoto

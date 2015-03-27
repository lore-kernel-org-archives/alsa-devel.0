From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Fri, 27 Mar 2015 08:39:10 +0800
Message-ID: <CAN8cciYD1gsoyjEWgwYT89MTeYP0gJHH2a-a=zMuxn2-S8Jx8g@mail.gmail.com>
References: <1426841719-14576-1-git-send-email-yang.jie@intel.com>
 <1426841719-14576-3-git-send-email-yang.jie@intel.com>
 <s5hd2446mt2.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB90F@SHSMSX101.ccr.corp.intel.com>
 <s5hvbhv6eio.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB93C@SHSMSX101.ccr.corp.intel.com>
 <s5hr3sj6bzj.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB993@SHSMSX101.ccr.corp.intel.com>
 <s5hegoj69bs.wl-tiwai@suse.de>
 <1427108203.2968.57.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <550FFE2B.7050008@canonical.com>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDD854@SHSMSX101.ccr.corp.intel.com>
 <5513AA46.2080804@canonical.com>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDDB1D@SHSMSX101.ccr.corp.intel.com>
 <5513CBE3.2090908@canonical.com>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDDBAF@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 1077F26582D
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 01:39:12 +0100 (CET)
Received: by oifl3 with SMTP id l3so63997517oif.0
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2015 17:39:10 -0700 (PDT)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A901BDDBAF@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

l
>
>
> OK, then I am thinking we can add jack kctls creating code like below:
>
> snd_jack_new(struct snd_card *card, const char *id, int type, struct
snd_jack **jjack) {
> ...
>         Switch(type | SND_JACK_HEADSET)
>         {
>                 case SND_JACK_MICROPHONE:
>                         create "Mic Jack" kctl;
>                         break;
>                 case SND_JACK_HEADSET:
>                         if (id == "Headphone Mic Headset") {
>                                 create " Headphone Mic Jack " kctl;
>                                 create " Headset Mic Jack " kctl;
>                         } else {
>                                 create " Headphone Jack " kctl;
>                                 create " Headset Mic Jack " kctl;
>                         }
>                         break;
>                 case SND_JACK_HEADPHONE:
>                         if (id == "Headset Mic") {
>                                 create " Headphone Jack " kctl;
>                         //      create " Headset Mic Phantom Jack " kctl;
>                         } else if (id == "Headphone Mic")  {
>                                 create " Headphone Mic Jack " kctl;
>                         } else if (id == "Headset Headphone Mic")  {
>                                 create " Headphone Mic Jack " kctl;
>                         //      create " Headset Mic Phantom Jack " kctl;
>                         } else {
>                                 create " Headphone Jack " kctl;
>                         }
>                         break;
>                 default:
>                         create "Mic Jack" kctl;
>                         break;
>         }
> ...
> }

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/pci/hda/hda_jack.c

If you look at snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t
nid, const char *name, int idx) which add kctl and call snd_jack_new if it
is not phantom

It is unlikely snd_jack_new() create those kctl

For mobile phone or tablet , there is one and only one input : headset

for notebook and desktop, there are dual headphone jacks, four line out
jacks for 7.1 surround, line in,

phantom jack for spdif, surround speakers , hp and mic for those desktop
using ac97 front audio panel

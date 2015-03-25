From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Thu, 26 Mar 2015 00:13:09 +0800
Message-ID: <CAN8ccib2J7Dq0RDrzgn9uUwQAPcvya0mmxuuHc1V3LuL2Mt_mg@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
 [209.85.214.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DCF5265363
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 17:13:11 +0100 (CET)
Received: by obbgg8 with SMTP id gg8so23391291obb.1
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 09:13:10 -0700 (PDT)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A901BDD854@SHSMSX101.ccr.corp.intel.com>
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

> > Headphone or mic, one hw switch:
> [Keyon]I am fresh about this kind of hw jack, it should use different
> segment of the plug, seems we don't need check the actual connected
> status at the jack creation stage, just creating "Headphone Mic Jack"
> should works, right?
> >
> >   * "Headphone Mic Jack"
> >
>

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=5780b627e24113323427c102175296ae43dfb9d7

http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/?id=7369a53ab5f606e87a3cd1cd4eebd40226bab090

http://www.asus.com/Notebooks_Ultrabooks/Eee_PC_1015PX/specifications/

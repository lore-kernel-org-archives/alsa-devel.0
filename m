From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [Intel-gfx] [PATCH 0/4 V7] Power-well
	API	implementation for Haswell
Date: Wed, 17 Jul 2013 02:52:41 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC48901184D8BF@SHSMSX104.ccr.corp.intel.com>
References: <1369922831-727-1-git-send-email-xingchao.wang@linux.intel.com>
 <20130606153441.GI7827@phenom.ffwll.local>
 <CA+gsUGSBf5hit=fmjcrcy=fKJPNaFe02VkkM_=pYkVUwVyvG2Q@mail.gmail.com>
 <20130704082314.GA2393@wxc-intel>
 <CA+gsUGR+xOEa5b7XnTWWwRYyyVxO6hNAVv6EJXAvtKUfuabb1w@mail.gmail.com>
 <20130704131330.GD2393@wxc-intel>
 <CA+gsUGRVkeArxvFPFH0=MfZH6M6-VTpu8L4fbGkfoTRaB7oX0w@mail.gmail.com>
 <s5hd2qww6no.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F1AD265286
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 04:52:47 +0200 (CEST)
In-Reply-To: <s5hd2qww6no.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Paulo Zanoni <przanoni@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Daniel Vetter <daniel@ffwll.ch>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Wang xingchao <xingchao.wang@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "david.henningsson@canonical.com" <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi/Paulo,

> > > would you change it to "auto" and test again.
> > > Runtime power save should be enabled with "auto".
> >
> > Doesn't solve the problem. Should I open a bug report somewhere?
> > Having the power well enabled prevents some power saving features from
> > the graphics driver.
> 
> Is the HD-audio power-saving itself working?  You can check it via watching
> /sys/class/hwC*/power_{on|off}_acct files.
> 
> power_save option has to be adjusted appropriately.  Note that many DEs
> change this value dynamically per AC-cable plug/unplug depending on the
> configuration, and often it's set to 0 (= no power save) when AC-cable is
> plugged.
> 
[Wang, Xingchao] Paulo used a new Ultrabook board with charger connected, and see the default parameter "auto=on".
In such scenario, power-well is always occupied by Display audio controller. Moreover, in this board, if no external monitors connected,
It's using internal eDP and totally no audio support. Power-well usage in such case also blocks some eDP features as Paulo told me.

So I think it's not a good idea to break the rule of power policy when charger connected but it's necessary to add support in this particular case.
Takashi, do you think it's acceptable to let Display audio controller/codec suspend in such case?

Thanks
--xingchao
> 

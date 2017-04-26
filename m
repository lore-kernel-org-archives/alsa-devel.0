From: "weiyongjun (A)" <weiyongjun1@huawei.com>
Subject: RE: [PATCH -next] ASoC: Intel: Skylake: Fix to use
 list_for_each_safe() when delete items
Date: Wed, 26 Apr 2017 05:39:06 +0000
Message-ID: <6AADFAC011213A4C87B956458587ADB47C853A@SZXEMI508-MBX.china.huawei.com>
References: <20170425032817.21959-1-weiyj.lk@gmail.com>
 <20170425040035.GY6263@localhost>
 <6AADFAC011213A4C87B956458587ADB47BD834@SZXEMI508-MBX.china.huawei.com>
 <20170426053803.GE6263@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170426053803.GE6263@localhost>
Content-Language: zh-CN
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, G Kranthi <gudishax.kranthikumar@intel.com>, Hardik T Shah <hardik.t.shah@intel.com>, Jeeja KP <jeeja.kp@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul@intel.com]
> Sent: Wednesday, April 26, 2017 1:38 PM
> To: weiyongjun (A) <weiyongjun1@huawei.com>
> Cc: Wei Yongjun <weiyj.lk@gmail.com>; Liam Girdwood
> <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>; Jaroslav
> Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Pardha Saradhi K
> <pardha.saradhi.kesapragada@intel.com>; G Kranthi
> <gudishax.kranthikumar@intel.com>; Hardik T Shah
> <hardik.t.shah@intel.com>; Jeeja KP <jeeja.kp@intel.com>; alsa-
> devel@alsa-project.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH -next] ASoC: Intel: Skylake: Fix to use
> list_for_each_safe() when delete items
> 
> On Tue, Apr 25, 2017 at 07:57:57AM +0000, weiyongjun (A) wrote:
> > > >
> > > > Since we will remove items off the list using list_del() we need
> > > > to use a safe version of the list_for_each() macro aptly named
> > > > list_for_each_safe().
> > >
> > > ah yes, god catch
> > >
> > > > This is detected by Coccinelle semantic patch.
> > >
> > > It is a good practice to include the script you used, do you mind adding
> > > that in the log?
> > >
> >
> > Sure.
> 
> Sorry I meant this should be in changelog of the patch :)

OK, I will add this and send the v2 version patch later.

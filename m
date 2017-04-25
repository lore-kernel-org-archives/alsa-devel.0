From: "weiyongjun (A)" <weiyongjun1@huawei.com>
Subject: RE: [PATCH -next] ASoC: Intel: Skylake: Fix to use
 list_for_each_safe() when delete items
Date: Tue, 25 Apr 2017 07:57:57 +0000
Message-ID: <6AADFAC011213A4C87B956458587ADB47BD834@SZXEMI508-MBX.china.huawei.com>
References: <20170425032817.21959-1-weiyj.lk@gmail.com>
 <20170425040035.GY6263@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170425040035.GY6263@localhost>
Content-Language: zh-CN
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Wei Yongjun <weiyj.lk@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, G Kranthi <gudishax.kranthikumar@intel.com>, Hardik T Shah <hardik.t.shah@intel.com>, Jeeja KP <jeeja.kp@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul@intel.com]
> Sent: Tuesday, April 25, 2017 12:01 PM
> To: Wei Yongjun <weiyj.lk@gmail.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
> <broonie@kernel.org>; Jaroslav Kysela <perex@perex.cz>; Takashi Iwai
> <tiwai@suse.com>; Pardha Saradhi K
> <pardha.saradhi.kesapragada@intel.com>; G Kranthi
> <gudishax.kranthikumar@intel.com>; Hardik T Shah
> <hardik.t.shah@intel.com>; Jeeja KP <jeeja.kp@intel.com>; weiyongjun (A)
> <weiyongjun1@huawei.com>; alsa-devel@alsa-project.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH -next] ASoC: Intel: Skylake: Fix to use
> list_for_each_safe() when delete items
> 
> On Tue, Apr 25, 2017 at 03:28:17AM +0000, Wei Yongjun wrote:
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> >
> > Since we will remove items off the list using list_del() we need
> > to use a safe version of the list_for_each() macro aptly named
> > list_for_each_safe().
> 
> ah yes, god catch
> 
> > This is detected by Coccinelle semantic patch.
> 
> It is a good practice to include the script you used, do you mind adding
> that in the log?
> 

Sure. 

@@
iterator name list_for_each;
expression E;
expression pos, head;
identifier l;
@@
*  list_for_each(pos, head)
{
...
*  \(list_del\|list_del_init\|list_move\|list_move_tail\)(pos, ...);
... when != \(goto l; \| break; \| return E; \| return;\)
}

@@
expression E;
expression pos, head, ep;
identifier list;
identifier l;
@@
*  list_for_each(pos, head)
{
...
* ep = list_entry(pos, ..., list);
...
*  \(list_del\|list_del_init\|list_move\|list_move_tail\)(&ep->list, ...);
... when != \(goto l; \| break; \| return E; \| return;\)
}

@@
iterator name list_for_each_prev;
expression E;
expression pos, head;
identifier l;
@@
*  list_for_each_prev(pos, head)
{
...
*  \(list_del\|list_del_init\)(pos);
... when != \(goto l; \| break; \| return E; \| return;\)
}

@@
iterator name list_for_each_entry;
expression E;
expression pos, head;
identifier l, member;
@@

*  list_for_each_entry(pos, head, member)
{
...
*  \(list_del\|list_del_init\)(&pos->member);
... when != \(goto l; \| break; \| return E; \| return;\)
}

@@
iterator name list_for_each_entry_from;
expression E;
expression pos, head;
identifier l, member;
@@

*  list_for_each_entry_from(pos, head, member)
{
...
*  \(list_del\|list_del_init\)(&pos->member);
... when != \(goto l; \| break; \| return E; \| return;\)
}

@@
iterator name list_for_each_entry_reverse;
expression E;
expression pos, head;
identifier l, member;
@@

*  list_for_each_entry_reverse(pos, head, member)
{
...
*  \(list_del\|list_del_init\)(&pos->member);
... when != \(goto l; \| break; \| return E; \| return;\)
}

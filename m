From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH -next] ASoC: Intel: Skylake: Fix to use
 list_for_each_safe() when delete items
Date: Wed, 26 Apr 2017 11:08:03 +0530
Message-ID: <20170426053803.GE6263@localhost>
References: <20170425032817.21959-1-weiyj.lk@gmail.com>
 <20170425040035.GY6263@localhost>
 <6AADFAC011213A4C87B956458587ADB47BD834@SZXEMI508-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3073626686A
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 07:36:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6AADFAC011213A4C87B956458587ADB47BD834@SZXEMI508-MBX.china.huawei.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "weiyongjun (A)" <weiyongjun1@huawei.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wei Yongjun <weiyj.lk@gmail.com>, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, G Kranthi <gudishax.kranthikumar@intel.com>, Mark Brown <broonie@kernel.org>, Hardik T Shah <hardik.t.shah@intel.com>, Jeeja KP <jeeja.kp@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 25, 2017 at 07:57:57AM +0000, weiyongjun (A) wrote:
> > >
> > > Since we will remove items off the list using list_del() we need
> > > to use a safe version of the list_for_each() macro aptly named
> > > list_for_each_safe().
> > 
> > ah yes, god catch
> > 
> > > This is detected by Coccinelle semantic patch.
> > 
> > It is a good practice to include the script you used, do you mind adding
> > that in the log?
> > 
> 
> Sure. 

Sorry I meant this should be in changelog of the patch :)

> 
> @@
> iterator name list_for_each;
> expression E;
> expression pos, head;
> identifier l;
> @@
> *  list_for_each(pos, head)
> {
> ...
> *  \(list_del\|list_del_init\|list_move\|list_move_tail\)(pos, ...);
> ... when != \(goto l; \| break; \| return E; \| return;\)
> }
> 
> @@
> expression E;
> expression pos, head, ep;
> identifier list;
> identifier l;
> @@
> *  list_for_each(pos, head)
> {
> ...
> * ep = list_entry(pos, ..., list);
> ...
> *  \(list_del\|list_del_init\|list_move\|list_move_tail\)(&ep->list, ...);
> ... when != \(goto l; \| break; \| return E; \| return;\)
> }
> 
> @@
> iterator name list_for_each_prev;
> expression E;
> expression pos, head;
> identifier l;
> @@
> *  list_for_each_prev(pos, head)
> {
> ...
> *  \(list_del\|list_del_init\)(pos);
> ... when != \(goto l; \| break; \| return E; \| return;\)
> }
> 
> @@
> iterator name list_for_each_entry;
> expression E;
> expression pos, head;
> identifier l, member;
> @@
> 
> *  list_for_each_entry(pos, head, member)
> {
> ...
> *  \(list_del\|list_del_init\)(&pos->member);
> ... when != \(goto l; \| break; \| return E; \| return;\)
> }
> 
> @@
> iterator name list_for_each_entry_from;
> expression E;
> expression pos, head;
> identifier l, member;
> @@
> 
> *  list_for_each_entry_from(pos, head, member)
> {
> ...
> *  \(list_del\|list_del_init\)(&pos->member);
> ... when != \(goto l; \| break; \| return E; \| return;\)
> }
> 
> @@
> iterator name list_for_each_entry_reverse;
> expression E;
> expression pos, head;
> identifier l, member;
> @@
> 
> *  list_for_each_entry_reverse(pos, head, member)
> {
> ...
> *  \(list_del\|list_del_init\)(&pos->member);
> ... when != \(goto l; \| break; \| return E; \| return;\)
> }

-- 
~Vinod

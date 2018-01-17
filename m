From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: ASoC Compress FE open causing warning
Date: Wed, 17 Jan 2018 10:59:48 +0100
Message-ID: <20180117095948.GA2564@lenoch>
References: <c53a10fafc0b7bcd452b7cc908d6ff16@codeaurora.org>
 <a32a9b75fbd152f1ac8eddcde5d8dfbd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C71B2677A6
 for <alsa-devel@alsa-project.org>; Wed, 17 Jan 2018 10:59:51 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992391AbeAQJ7tpEQpI (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Wed, 17 Jan 2018 10:59:49 +0100
Content-Disposition: inline
In-Reply-To: <a32a9b75fbd152f1ac8eddcde5d8dfbd@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: b_lkasam@codeaurora.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Laxminath Kasam,

On Wed, Jan 17, 2018 at 03:08:31PM +0530, b_lkasam@codeaurora.org wrote:
> hi ALSA team,
> Please comment on below issue wrt warning seen..

Please do not top post.

> thanks
> Laxminath Kasam
> On 2018-01-10 15:00, b_lkasam@codeaurora.org wrote:
> > Hi ALSA team,
> > This is wrt soc_compr_open_fe() call result in warning in API
> > triggered from it snd_soc_runtime_activate(fe, stream)..
> > Due to lock taken is &fe->card->mutex, but expected to take
> > &fe->pcm_mutex.
> > Below line results in warning since pcm_mutex lock is not taken..
> > 
> > void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int
> > stream)
> > {
> >    ...
> > 	lockdep_assert_held(&rtd->pcm_mutex);
> > 
> > }
> > 
> > Warning seen as below ->
> > <4>[ 263.555973] [3: writer: 8681] WARNING: CPU: 3 PID: 8681 at
> > /home/min47.lee/ext-drive/j8plus-oos/android/kernel/sound/soc/soc-pcm.c:71
> > snd_soc_runtime_activate+0x11c/0x130()
> > <6>[ 263.572125] [3: writer: 8681] Modules linked in:
> > <6>[ 263.572176] [3: writer: 8681] CPU: 3 PID: 8681 Comm: writer
> > Tainted: G W 3.18.71-g9888952 #3

As this release it at the end of life with 3.18.92 being released just today
(and yours 3.18.71 comes from 13-Sep-2017) it is very unlikely anyone would
bother to look at this...

> > <6>[ 263.572253] [3: writer: 8681] Hardware name: Samsung J8-Plus LTE
> > EUR OPEN Rev01 (DT)
> > <0>[ 263.572317] [3: writer: 8681] Call trace:
> > <6>[ 263.576842] [3: writer: 8681] [<ffffffc00008aae4>]
> > dump_backtrace+0x0/0x15c
> > <6>[ 263.576904] [3: writer: 8681] [<ffffffc00008ac54>]
> > show_stack+0x14/0x1c
> > <6>[ 263.576966] [3: writer: 8681] [<ffffffc0011a1cb0>]
> > dump_stack+0x80/0xa4
> > <6>[ 263.577025] [3: writer: 8681] [<ffffffc0000a6bf0>]
> > warn_slowpath_common+0x88/0xac
> > <6>[ 263.577088] [3: writer: 8681] [<ffffffc0000a6d2c>]
> > warn_slowpath_null+0x18/0x20
> > <6>[ 263.577152] [3: writer: 8681] [<ffffffc000f0141c>]
> > snd_soc_runtime_activate+0x11c/0x130
> > <6>[ 263.577221] [3: writer: 8681] [<ffffffc000f05e74>]
> > soc_compr_open_fe+0x204/0x29c
> > <6>[ 263.577289] [3: writer: 8681] [<ffffffc000eddbac>]
> > snd_compr_open+0x170/0x1b4
> > <6>[ 263.577355] [3: writer: 8681] [<ffffffc000ebfc78>]
> > snd_open+0x13c/0x154
> > <6>[ 263.577415] [3: writer: 8681] [<ffffffc0001d72e8>]
> > chrdev_open+0x140/0x188
> > <6>[ 263.577476] [3: writer: 8681] [<ffffffc0001d0758>]
> > do_dentry_open+0x260/0x2d8
> > <6>[ 263.577545] [3: writer: 8681] [<ffffffc0001d1938>]
> > vfs_open+0x60/0x6c
> > <6>[ 263.577605] [3: writer: 8681] [<ffffffc0001e0ea8>]
> > do_last+0x804/0xb3c
> > <6>[ 263.577665] [3: writer: 8681] [<ffffffc0001e141c>]
> > path_openat+0x23c/0x5f4
> > <6>[ 263.577732] [3: writer: 8681] [<ffffffc0001e2108>]
> > do_filp_open+0x40/0xa8
> > <6>[ 263.577796] [3: writer: 8681] [<ffffffc0001d1cf4>]
> > do_sys_open+0x174/0x224
> > <6>[ 263.577866] [3: writer: 8681] [<ffffffc0002212f4>]
> > compat_SyS_openat+0xc/0x14
> > 
> > 
> > 
> > With Regards,
> > Laxminath Kasam
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

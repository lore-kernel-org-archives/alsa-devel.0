From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: ALSA trigger soft lockup since "ALSA: seq: Fix
 race at creating a queue"
Date: Sun, 5 Nov 2017 20:08:32 -0500
Message-ID: <20171106010832.GA3656@redhat.com>
References: <20171101130227.97f943b3318827b0ac5238a1@linux-foundation.org>
 <20171104023409.GB10353@redhat.com> <s5hshduzf9x.wl-tiwai@suse.de>
 <20171104203242.GA2740@redhat.com> <s5h4lq9yt8u.wl-tiwai@suse.de>
 <s5h1sldys15.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CA562670B5
 for <alsa-devel@alsa-project.org>; Mon,  6 Nov 2017 02:08:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h1sldys15.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, alsa-devel@alsa-project.org, Daniel Mentz <danielmentz@google.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 05, 2017 at 10:49:10AM +0100, Takashi Iwai wrote:
> On Sun, 05 Nov 2017 10:22:57 +0100,
> Takashi Iwai wrote:
> > =

> > On Sat, 04 Nov 2017 21:32:42 +0100,
> > Jerome Glisse wrote:
> > > =

> > > On Sat, Nov 04, 2017 at 08:14:50AM +0100, Takashi Iwai wrote:
> > > > On Sat, 04 Nov 2017 03:34:09 +0100,
> > > > Jerome Glisse wrote:
> > > > > =

> > > > > On Wed, Nov 01, 2017 at 01:02:27PM -0700, Andrew Morton wrote:
> > > > > > Begin forwarded message:
> > > > > > =

> > > > > > Date: Wed, 01 Nov 2017 12:54:16 -0700
> > > > > > From: syzbot <bot+63583aefef5457348dcfa06b87d4fd1378b26b09@syzk=
aller.appspotmail.com>
> > > > > > To: aaron.lu@intel.com, akpm@linux-foundation.org, aneesh.kumar=
@linux.vnet.ibm.com, jack@suse.cz, kirill.shutemov@linux.intel.com, linux-k=
ernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.=
org, peterz@infradead.org, rientjes@google.com, sfr@canb.auug.org.au, shli@=
fb.com, syzkaller-bugs@googlegroups.com, willy@linux.intel.com, ying.huang@=
intel.com, zi.yan@cs.rutgers.edu
> > > > > > Subject: BUG: soft lockup
> > > > > > =

> > > > > > =

> > > > > > Hello,
> > > > > > =

> > > > > > syzkaller hit the following crash on  =

> > > > > > 1d53d908b79d7870d89063062584eead4cf83448
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it/master
> > > > > > compiler: gcc (GCC) 7.1.1 20170620
> > > > > > .config is attached
> > > > > > Raw console output is attached.
> > > > > > C reproducer is attached
> > > > > > syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> > > > > > for information about syzkaller reproducers
> > > > > =

> > > > > Sorry to be the bringer of bad news but after:
> > > > > 4842e98f26dd80be3623c4714a244ba52ea096a8
> > > > > and
> > > > > 7e1d90f60a0d501c8503e636942ca704a454d910
> > > > > =

> > > > > The attached syzkaller repro trigger a softlockup in workqueue. I=
 am unfamiliar
> > > > > with that code so some familiar in that domain is more likely to =
find a proper
> > > > > solution.
> > > > > =

> > > > > Note with
> > > > > git revert 7e1d90f60a0d501c8503e636942ca704a454d910
> > > > > git revert 4842e98f26dd80be3623c4714a244ba52ea096a8
> > > > > fix the issue
> > > > =

> > > > Could you give the stack trace?
> > > =

> > > Stack trace doesn't say anything it is different every single time.
> > > It was first reported against mm as stack was showing some mm code
> > > but that was coincidence. Stack will show what ever is running at
> > > the time the workqueue soft lockup kick in. The only constant is the
> > > watchdog stack trace but that does not tell you anything:
> > > =

> > > RIP: 0033:0x4012c8
> > > RSP: 002b:00007ffc12d93e10 EFLAGS: 00010286
> > > RAX: ffffffffffffffff RBX: ffffffffffffffff RCX: 0000000000439779
> > > RDX: 0000000000000000 RSI: 000000002076e000 RDI: ffffffffffffffff
> > > RBP: 00327265636e6575 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000286 R12: 7165732f7665642f
> > > R13: 646e732f7665642f R14: 0030656c69662f2e R15: 0000000000000000
> > > Code: 60 39 d1 fc e9 8d fd ff ff be 08 00 00 00 4c 89 ff e8 2e 39 d1 =
fc e9  =

> > > 1c fd ff ff 90 90 90 90 90 90 90 90 90 b9 00 02 00 00 31 c0 <f3> 48 a=
b c3  =

> > > 0f 1f 44 00 00 31 c0 b9 40 00 00 00 66 0f 1f 84 00
> > > Kernel panic - not syncing: softlockup: hung tasks
> > > CPU: 3 PID: 2995 Comm: syzkaller355698 Tainted: G             L  =

> > > 4.13.0-rc7-next-20170901+ #13
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/=
01/2011
> > > Call Trace:
> > >   <IRQ>
> > >   __dump_stack lib/dump_stack.c:16 [inline]
> > >   dump_stack+0x194/0x257 lib/dump_stack.c:52
> > >   panic+0x1e4/0x417 kernel/panic.c:181
> > >   watchdog_timer_fn+0x401/0x410 kernel/watchdog.c:433
> > >   __run_hrtimer kernel/time/hrtimer.c:1213 [inline]
> > >   __hrtimer_run_queues+0x349/0xe10 kernel/time/hrtimer.c:1277
> > >   hrtimer_interrupt+0x1d4/0x5f0 kernel/time/hrtimer.c:1311
> > >   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1021 [inline]
> > >   smp_apic_timer_interrupt+0x156/0x710 arch/x86/kernel/apic/apic.c:10=
46
> > >   apic_timer_interrupt+0x9d/0xb0 arch/x86/entry/entry_64.S:577
> > > =

> > > =

> > > If you want i can collect a bunch but i haven't seen anything usefull=
 in
> > > any of them
> > =

> > OK, thanks for information.
> > =

> > So this looks like simply a consequence of too many concurrently
> > opened / processed ALSA timer instances.  Below is the patch to plug
> > it, setting the upper limit for avoiding the system resource hog.
> =

> Scratch that, it may lead to an unbalanced count.
> Below is the fixed version.
> =

> =

> Takashi
> =

> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH v2] ALSA: timer: Limit max instances per timer
> =

> Currently we allow unlimited number of timer instances, and it may
> bring the system hogging way too much CPU when too many timer
> instances are opened and processed concurrently.  This may end up with
> a soft-lockup report as triggered by syzkaller, especially when
> hrtimer backend is deployed.
> =

> Since such insane number of instances aren't demanded by the normal
> use case of ALSA sequencer and it merely  opens a risk only for abuse,
> this patch introduces the upper limit for the number of instances per
> timer backend.  As default, it's set to 1000, but for the fine-grained
> timer like hrtimer, it's set to 100.
> =

> Reported-by: syzbot
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Tested-by: J=E9r=F4me Glisse <jglisse@redhat.com>

> ---
>  include/sound/timer.h |  2 ++
>  sound/core/hrtimer.c  |  1 +
>  sound/core/timer.c    | 67 +++++++++++++++++++++++++++++++++++++++++----=
------
>  3 files changed, 57 insertions(+), 13 deletions(-)
> =

> diff --git a/include/sound/timer.h b/include/sound/timer.h
> index c4d76ff056c6..7ae226ab6990 100644
> --- a/include/sound/timer.h
> +++ b/include/sound/timer.h
> @@ -90,6 +90,8 @@ struct snd_timer {
>  	struct list_head ack_list_head;
>  	struct list_head sack_list_head; /* slow ack list head */
>  	struct tasklet_struct task_queue;
> +	int max_instances;	/* upper limit of timer instances */
> +	int num_instances;	/* current number of timer instances */
>  };
>  =

>  struct snd_timer_instance {
> diff --git a/sound/core/hrtimer.c b/sound/core/hrtimer.c
> index 5603e49f7bf7..18cb6f476bf4 100644
> --- a/sound/core/hrtimer.c
> +++ b/sound/core/hrtimer.c
> @@ -159,6 +159,7 @@ static int __init snd_hrtimer_init(void)
>  	timer->hw =3D hrtimer_hw;
>  	timer->hw.resolution =3D resolution;
>  	timer->hw.ticks =3D NANO_SEC / resolution;
> +	timer->max_instances =3D 100; /* lower the limit */
>  =

>  	err =3D snd_timer_global_register(timer);
>  	if (err < 0) {
> diff --git a/sound/core/timer.c b/sound/core/timer.c
> index 09acaf2b2e57..ee09dace8bb1 100644
> --- a/sound/core/timer.c
> +++ b/sound/core/timer.c
> @@ -180,7 +180,7 @@ static void snd_timer_request(struct snd_timer_id *ti=
d)
>   *
>   * call this with register_mutex down.
>   */
> -static void snd_timer_check_slave(struct snd_timer_instance *slave)
> +static int snd_timer_check_slave(struct snd_timer_instance *slave)
>  {
>  	struct snd_timer *timer;
>  	struct snd_timer_instance *master;
> @@ -190,16 +190,21 @@ static void snd_timer_check_slave(struct snd_timer_=
instance *slave)
>  		list_for_each_entry(master, &timer->open_list_head, open_list) {
>  			if (slave->slave_class =3D=3D master->slave_class &&
>  			    slave->slave_id =3D=3D master->slave_id) {
> +				if (master->timer->num_instances >=3D
> +				    master->timer->max_instances)
> +					return -EBUSY;
>  				list_move_tail(&slave->open_list,
>  					       &master->slave_list_head);
> +				master->timer->num_instances++;
>  				spin_lock_irq(&slave_active_lock);
>  				slave->master =3D master;
>  				slave->timer =3D master->timer;
>  				spin_unlock_irq(&slave_active_lock);
> -				return;
> +				return 0;
>  			}
>  		}
>  	}
> +	return 0;
>  }
>  =

>  /*
> @@ -208,7 +213,7 @@ static void snd_timer_check_slave(struct snd_timer_in=
stance *slave)
>   *
>   * call this with register_mutex down.
>   */
> -static void snd_timer_check_master(struct snd_timer_instance *master)
> +static int snd_timer_check_master(struct snd_timer_instance *master)
>  {
>  	struct snd_timer_instance *slave, *tmp;
>  =

> @@ -216,7 +221,11 @@ static void snd_timer_check_master(struct snd_timer_=
instance *master)
>  	list_for_each_entry_safe(slave, tmp, &snd_timer_slave_list, open_list) {
>  		if (slave->slave_class =3D=3D master->slave_class &&
>  		    slave->slave_id =3D=3D master->slave_id) {
> +			if (master->timer->num_instances >=3D
> +			    master->timer->max_instances)
> +				return -EBUSY;
>  			list_move_tail(&slave->open_list, &master->slave_list_head);
> +			master->timer->num_instances++;
>  			spin_lock_irq(&slave_active_lock);
>  			spin_lock(&master->timer->lock);
>  			slave->master =3D master;
> @@ -228,8 +237,11 @@ static void snd_timer_check_master(struct snd_timer_=
instance *master)
>  			spin_unlock_irq(&slave_active_lock);
>  		}
>  	}
> +	return 0;
>  }
>  =

> +static int snd_timer_close_locked(struct snd_timer_instance *timeri);
> +
>  /*
>   * open a timer instance
>   * when opening a master, the slave id must be here given.
> @@ -240,6 +252,7 @@ int snd_timer_open(struct snd_timer_instance **ti,
>  {
>  	struct snd_timer *timer;
>  	struct snd_timer_instance *timeri =3D NULL;
> +	int err;
>  =

>  	if (tid->dev_class =3D=3D SNDRV_TIMER_CLASS_SLAVE) {
>  		/* open a slave instance */
> @@ -259,10 +272,14 @@ int snd_timer_open(struct snd_timer_instance **ti,
>  		timeri->slave_id =3D tid->device;
>  		timeri->flags |=3D SNDRV_TIMER_IFLG_SLAVE;
>  		list_add_tail(&timeri->open_list, &snd_timer_slave_list);
> -		snd_timer_check_slave(timeri);
> +		err =3D snd_timer_check_slave(timeri);
> +		if (err < 0) {
> +			snd_timer_close_locked(timeri);
> +			timeri =3D NULL;
> +		}
>  		mutex_unlock(&register_mutex);
>  		*ti =3D timeri;
> -		return 0;
> +		return err;
>  	}
>  =

>  	/* open a master instance */
> @@ -288,6 +305,10 @@ int snd_timer_open(struct snd_timer_instance **ti,
>  			return -EBUSY;
>  		}
>  	}
> +	if (timer->num_instances >=3D timer->max_instances) {
> +		mutex_unlock(&register_mutex);
> +		return -EBUSY;
> +	}
>  	timeri =3D snd_timer_instance_new(owner, timer);
>  	if (!timeri) {
>  		mutex_unlock(&register_mutex);
> @@ -314,25 +335,27 @@ int snd_timer_open(struct snd_timer_instance **ti,
>  	}
>  =

>  	list_add_tail(&timeri->open_list, &timer->open_list_head);
> -	snd_timer_check_master(timeri);
> +	timer->num_instances++;
> +	err =3D snd_timer_check_master(timeri);
> +	if (err < 0) {
> +		snd_timer_close_locked(timeri);
> +		timeri =3D NULL;
> +	}
>  	mutex_unlock(&register_mutex);
>  	*ti =3D timeri;
> -	return 0;
> +	return err;
>  }
>  EXPORT_SYMBOL(snd_timer_open);
>  =

>  /*
>   * close a timer instance
> + * call this with register_mutex down.
>   */
> -int snd_timer_close(struct snd_timer_instance *timeri)
> +static int snd_timer_close_locked(struct snd_timer_instance *timeri)
>  {
>  	struct snd_timer *timer =3D NULL;
>  	struct snd_timer_instance *slave, *tmp;
>  =

> -	if (snd_BUG_ON(!timeri))
> -		return -ENXIO;
> -
> -	mutex_lock(&register_mutex);
>  	list_del(&timeri->open_list);
>  =

>  	/* force to stop the timer */
> @@ -340,6 +363,7 @@ int snd_timer_close(struct snd_timer_instance *timeri)
>  =

>  	timer =3D timeri->timer;
>  	if (timer) {
> +		timer->num_instances--;
>  		/* wait, until the active callback is finished */
>  		spin_lock_irq(&timer->lock);
>  		while (timeri->flags & SNDRV_TIMER_IFLG_CALLBACK) {
> @@ -355,6 +379,7 @@ int snd_timer_close(struct snd_timer_instance *timeri)
>  		list_for_each_entry_safe(slave, tmp, &timeri->slave_list_head,
>  					 open_list) {
>  			list_move_tail(&slave->open_list, &snd_timer_slave_list);
> +			timer->num_instances--;
>  			slave->master =3D NULL;
>  			slave->timer =3D NULL;
>  			list_del_init(&slave->ack_list);
> @@ -382,9 +407,24 @@ int snd_timer_close(struct snd_timer_instance *timer=
i)
>  		module_put(timer->module);
>  	}
>  =

> -	mutex_unlock(&register_mutex);
>  	return 0;
>  }
> +
> +/*
> + * close a timer instance
> + */
> +int snd_timer_close(struct snd_timer_instance *timeri)
> +{
> +	int err;
> +
> +	if (snd_BUG_ON(!timeri))
> +		return -ENXIO;
> +
> +	mutex_lock(&register_mutex);
> +	err =3D snd_timer_close_locked(timeri);
> +	mutex_unlock(&register_mutex);
> +	return err;
> +}
>  EXPORT_SYMBOL(snd_timer_close);
>  =

>  unsigned long snd_timer_resolution(struct snd_timer_instance *timeri)
> @@ -856,6 +896,7 @@ int snd_timer_new(struct snd_card *card, char *id, st=
ruct snd_timer_id *tid,
>  	spin_lock_init(&timer->lock);
>  	tasklet_init(&timer->task_queue, snd_timer_tasklet,
>  		     (unsigned long)timer);
> +	timer->max_instances =3D 1000; /* default limit per timer */
>  	if (card !=3D NULL) {
>  		timer->module =3D card->module;
>  		err =3D snd_device_new(card, SNDRV_DEV_TIMER, timer, &ops);
> -- =

> 2.15.0
> =

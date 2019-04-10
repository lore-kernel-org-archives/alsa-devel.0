From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [sound:topic/misc-core-fixes 16/17] sound/core/timer.c:348
 snd_timer_open() warn: inconsistent returns 'mutex:&register_mutex'.
Date: Wed, 10 Apr 2019 08:49:50 +0300
Message-ID: <20190410054950.GO6070@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kbuild-bounces@lists.01.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.01.org/mailman/options/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/kbuild/>
List-Post: <mailto:kbuild@lists.01.org>
List-Help: <mailto:kbuild-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=subscribe>
Errors-To: kbuild-bounces@lists.01.org
Sender: "kbuild" <kbuild-bounces@lists.01.org>
To: kbuild@01.org, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/misc-core-fixes
head:   58e224117e101df0a90fa69ed8f32d6e1881c642
commit: 3d2ebce824f281b246de1f513f8863d95540df50 [16/17] ALSA: timer: Simplify error path in snd_timer_open()

New smatch warnings:
sound/core/timer.c:348 snd_timer_open() warn: inconsistent returns 'mutex:&register_mutex'.
  Locked on:   line 309
  Unlocked on: line 348

Old smatch warnings:
sound/core/timer.c:1226 snd_timer_proc_read() error: we previously assumed 'timer->card' could be null (see line 1219)

# https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=3d2ebce824f281b246de1f513f8863d95540df50
git remote add sound https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
git remote update sound
git checkout 3d2ebce824f281b246de1f513f8863d95540df50
vim +348 sound/core/timer.c

53d2f744 Takashi Iwai    2005-11-17  250  int snd_timer_open(struct snd_timer_instance **ti,
53d2f744 Takashi Iwai    2005-11-17  251  		   char *owner, struct snd_timer_id *tid,
^1da177e Linus Torvalds  2005-04-16  252  		   unsigned int slave_id)
^1da177e Linus Torvalds  2005-04-16  253  {
53d2f744 Takashi Iwai    2005-11-17  254  	struct snd_timer *timer;
53d2f744 Takashi Iwai    2005-11-17  255  	struct snd_timer_instance *timeri = NULL;
9b7d869e Takashi Iwai    2017-11-05  256  	int err;
^1da177e Linus Torvalds  2005-04-16  257  
3d2ebce8 Takashi Iwai    2019-03-28  258  	mutex_lock(&register_mutex);
^1da177e Linus Torvalds  2005-04-16  259  	if (tid->dev_class == SNDRV_TIMER_CLASS_SLAVE) {
^1da177e Linus Torvalds  2005-04-16  260  		/* open a slave instance */
^1da177e Linus Torvalds  2005-04-16  261  		if (tid->dev_sclass <= SNDRV_TIMER_SCLASS_NONE ||
^1da177e Linus Torvalds  2005-04-16  262  		    tid->dev_sclass > SNDRV_TIMER_SCLASS_OSS_SEQUENCER) {
cf74dcf3 Takashi Iwai    2014-02-04  263  			pr_debug("ALSA: timer: invalid slave class %i\n",
cf74dcf3 Takashi Iwai    2014-02-04  264  				 tid->dev_sclass);
3d2ebce8 Takashi Iwai    2019-03-28  265  			err = -EINVAL;
3d2ebce8 Takashi Iwai    2019-03-28  266  			goto unlock;
^1da177e Linus Torvalds  2005-04-16  267  		}
^1da177e Linus Torvalds  2005-04-16  268  		timeri = snd_timer_instance_new(owner, NULL);
2fd43d11 Clemens Ladisch 2005-10-12  269  		if (!timeri) {
3d2ebce8 Takashi Iwai    2019-03-28  270  			err = -ENOMEM;
3d2ebce8 Takashi Iwai    2019-03-28  271  			goto unlock;
2fd43d11 Clemens Ladisch 2005-10-12  272  		}
^1da177e Linus Torvalds  2005-04-16  273  		timeri->slave_class = tid->dev_sclass;
^1da177e Linus Torvalds  2005-04-16  274  		timeri->slave_id = tid->device;
^1da177e Linus Torvalds  2005-04-16  275  		timeri->flags |= SNDRV_TIMER_IFLG_SLAVE;
^1da177e Linus Torvalds  2005-04-16  276  		list_add_tail(&timeri->open_list, &snd_timer_slave_list);
9b7d869e Takashi Iwai    2017-11-05  277  		err = snd_timer_check_slave(timeri);
9b7d869e Takashi Iwai    2017-11-05  278  		if (err < 0) {
9b7d869e Takashi Iwai    2017-11-05  279  			snd_timer_close_locked(timeri);
9b7d869e Takashi Iwai    2017-11-05  280  			timeri = NULL;
9b7d869e Takashi Iwai    2017-11-05  281  		}
3d2ebce8 Takashi Iwai    2019-03-28  282  		goto unlock;
^1da177e Linus Torvalds  2005-04-16  283  	}
^1da177e Linus Torvalds  2005-04-16  284  
^1da177e Linus Torvalds  2005-04-16  285  	/* open a master instance */
^1da177e Linus Torvalds  2005-04-16  286  	timer = snd_timer_find(tid);
ee2da997 Johannes Berg   2008-07-09  287  #ifdef CONFIG_MODULES
ee2da997 Johannes Berg   2008-07-09  288  	if (!timer) {
1a60d4c5 Ingo Molnar     2006-01-16  289  		mutex_unlock(&register_mutex);
^1da177e Linus Torvalds  2005-04-16  290  		snd_timer_request(tid);
1a60d4c5 Ingo Molnar     2006-01-16  291  		mutex_lock(&register_mutex);
^1da177e Linus Torvalds  2005-04-16  292  		timer = snd_timer_find(tid);
^1da177e Linus Torvalds  2005-04-16  293  	}
^1da177e Linus Torvalds  2005-04-16  294  #endif
2fd43d11 Clemens Ladisch 2005-10-12  295  	if (!timer) {
3d2ebce8 Takashi Iwai    2019-03-28  296  		err = -ENODEV;
3d2ebce8 Takashi Iwai    2019-03-28  297  		goto unlock;
2fd43d11 Clemens Ladisch 2005-10-12  298  	}
^1da177e Linus Torvalds  2005-04-16  299  	if (!list_empty(&timer->open_list_head)) {
2fd43d11 Clemens Ladisch 2005-10-12  300  		timeri = list_entry(timer->open_list_head.next,
53d2f744 Takashi Iwai    2005-11-17  301  				    struct snd_timer_instance, open_list);
^1da177e Linus Torvalds  2005-04-16  302  		if (timeri->flags & SNDRV_TIMER_IFLG_EXCLUSIVE) {
3d2ebce8 Takashi Iwai    2019-03-28  303  			err = -EBUSY;
3d2ebce8 Takashi Iwai    2019-03-28  304  			timeri = NULL;
3d2ebce8 Takashi Iwai    2019-03-28  305  			goto unlock;
^1da177e Linus Torvalds  2005-04-16  306  		}
^1da177e Linus Torvalds  2005-04-16  307  	}
9b7d869e Takashi Iwai    2017-11-05  308  	if (timer->num_instances >= timer->max_instances) {
9b7d869e Takashi Iwai    2017-11-05  309  		return -EBUSY;
                                                        ^^^^^^^^^^^^^^
delete the stray return

3d2ebce8 Takashi Iwai    2019-03-28  310  		goto unlock;
                                                        ^^^^^^^^^^^

9b7d869e Takashi Iwai    2017-11-05  311  	}
^1da177e Linus Torvalds  2005-04-16  312  	timeri = snd_timer_instance_new(owner, timer);
2fd43d11 Clemens Ladisch 2005-10-12  313  	if (!timeri) {
3d2ebce8 Takashi Iwai    2019-03-28  314  		err = -ENOMEM;
3d2ebce8 Takashi Iwai    2019-03-28  315  		goto unlock;
2fd43d11 Clemens Ladisch 2005-10-12  316  	}
230323da Takashi Iwai    2016-01-21  317  	/* take a card refcount for safe disconnection */
230323da Takashi Iwai    2016-01-21  318  	if (timer->card)
230323da Takashi Iwai    2016-01-21  319  		get_device(&timer->card->card_dev);
^1da177e Linus Torvalds  2005-04-16  320  	timeri->slave_class = tid->dev_sclass;
^1da177e Linus Torvalds  2005-04-16  321  	timeri->slave_id = slave_id;
8ddc0563 Vegard Nossum   2016-08-29  322  
8ddc0563 Vegard Nossum   2016-08-29  323  	if (list_empty(&timer->open_list_head) && timer->hw.open) {
3d2ebce8 Takashi Iwai    2019-03-28  324  		err = timer->hw.open(timer);
8ddc0563 Vegard Nossum   2016-08-29  325  		if (err) {
8ddc0563 Vegard Nossum   2016-08-29  326  			kfree(timeri->owner);
8ddc0563 Vegard Nossum   2016-08-29  327  			kfree(timeri);
3d2ebce8 Takashi Iwai    2019-03-28  328  			timeri = NULL;
8ddc0563 Vegard Nossum   2016-08-29  329  
8ddc0563 Vegard Nossum   2016-08-29  330  			if (timer->card)
8ddc0563 Vegard Nossum   2016-08-29  331  				put_device(&timer->card->card_dev);
8ddc0563 Vegard Nossum   2016-08-29  332  			module_put(timer->module);
3d2ebce8 Takashi Iwai    2019-03-28  333  			goto unlock;
8ddc0563 Vegard Nossum   2016-08-29  334  		}
8ddc0563 Vegard Nossum   2016-08-29  335  	}
8ddc0563 Vegard Nossum   2016-08-29  336  
^1da177e Linus Torvalds  2005-04-16  337  	list_add_tail(&timeri->open_list, &timer->open_list_head);
9b7d869e Takashi Iwai    2017-11-05  338  	timer->num_instances++;
9b7d869e Takashi Iwai    2017-11-05  339  	err = snd_timer_check_master(timeri);
9b7d869e Takashi Iwai    2017-11-05  340  	if (err < 0) {
9b7d869e Takashi Iwai    2017-11-05  341  		snd_timer_close_locked(timeri);
9b7d869e Takashi Iwai    2017-11-05  342  		timeri = NULL;
9b7d869e Takashi Iwai    2017-11-05  343  	}
3d2ebce8 Takashi Iwai    2019-03-28  344  
3d2ebce8 Takashi Iwai    2019-03-28  345   unlock:
1a60d4c5 Ingo Molnar     2006-01-16  346  	mutex_unlock(&register_mutex);
^1da177e Linus Torvalds  2005-04-16  347  	*ti = timeri;
9b7d869e Takashi Iwai    2017-11-05 @348  	return err;
^1da177e Linus Torvalds  2005-04-16  349  }
98856392 Takashi Iwai    2017-06-16  350  EXPORT_SYMBOL(snd_timer_open);
^1da177e Linus Torvalds  2005-04-16  351  

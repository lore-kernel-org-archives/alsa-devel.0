From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/4] ALSA: dice: postpone card registration
Date: Wed, 23 Dec 2015 13:21:34 +0900
Message-ID: <567A214E.201@sakamocchi.jp>
References: <1450791943-14624-1-git-send-email-o-takashi@sakamocchi.jp>
 <1450791943-14624-3-git-send-email-o-takashi@sakamocchi.jp>
 <s5hlh8meg24.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id A7A862616B9
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 05:21:39 +0100 (CET)
In-Reply-To: <s5hlh8meg24.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Dec 22 2015 23:03, Takashi Iwai wrote:
> On Tue, 22 Dec 2015 14:45:41 +0100,
> Takashi Sakamoto wrote:
>>
>> Some models based on ASIC for Dice II series (STD, CP) change their
>> hardware configurations after appearing on IEEE 1394 bus. This is due to
>> interactions of boot loader (RedBoot), firmwares (eCos) and vendor's
>> configurations. This causes current ALSA dice driver to get wrong
>> information about the hardware's capability because its probe function
>> runs just after detecting unit of the model.
>>
>> As long as I investigated, it takes a bit time (less than 1 second) to load
>> the firmware after bootstrap. Just after loaded, the driver can get
>> information about the unit. Then the hardware is initialized according to
>> vendor's configurations. After, the got information becomes wrong.
>> Between bootstrap, firmware loading and post configuration, some bus resets
>> are observed.
>>
>> This commit offloads most processing of probe function into workqueue and
>> schedules the workqueue after successive bus resets. This has an effect to
>> get correct hardware information and avoid involvement to bus reset storm.
>>
>> For code simplicity, this change effects all of Dice-based models, i.e.
>> Dice II, Dice Jr., Dice Mini and Dice III. Due to the same reason, sound
>> card instance is kept till card free function even if some errors are
>> detected in the workqueue.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
>>  sound/firewire/dice/dice.c | 105 +++++++++++++++++++++++++++++++++------------
>>  sound/firewire/dice/dice.h |   3 ++
>>  2 files changed, 80 insertions(+), 28 deletions(-)
>>
>> diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
>> index 26271cc..afec02f 100644
>> --- a/sound/firewire/dice/dice.c
>> +++ b/sound/firewire/dice/dice.c
>> @@ -18,6 +18,8 @@ MODULE_LICENSE("GPL v2");
>>  #define WEISS_CATEGORY_ID	0x00
>>  #define LOUD_CATEGORY_ID	0x10
>>  
>> +#define PROBE_DELAY_MS		(2 * MSEC_PER_SEC)
>> +
>>  static int check_dice_category(struct fw_unit *unit)
>>  {
>>  	struct fw_device *device = fw_parent_device(unit);
>> @@ -185,17 +187,68 @@ static void dice_card_free(struct snd_card *card)
>>  {
>>  	struct snd_dice *dice = card->private_data;
>>  
>> +	/* The workqueue for registration uses the memory block. */
>> +	cancel_work_sync(&dice->dwork.work);
>> +
>>  	snd_dice_stream_destroy_duplex(dice);
>> +
>>  	snd_dice_transaction_destroy(dice);
>> +
>>  	fw_unit_put(dice->unit);
>>  
>>  	mutex_destroy(&dice->mutex);
>>  }
>>  
>> +static void do_registration(struct work_struct *work)
>> +{
>> +	struct snd_dice *dice = container_of(work, struct snd_dice, dwork.work);
>> +	int err;
>> +
>> +	mutex_lock(&dice->mutex);
>> +
>> +	if (dice->card->shutdown || dice->probed)
>> +		goto end;
>> +
>> +	err = snd_dice_transaction_init(dice);
>> +	if (err < 0)
>> +		goto end;
>> +
>> +	err = dice_read_params(dice);
>> +	if (err < 0)
>> +		goto end;
>> +
>> +	dice_card_strings(dice);
>> +
>> +	err = snd_dice_create_pcm(dice);
>> +	if (err < 0)
>> +		goto end;
>> +
>> +	err = snd_dice_create_midi(dice);
>> +	if (err < 0)
>> +		goto end;
>> +
>> +	err = snd_card_register(dice->card);
>> +	if (err < 0)
>> +		goto end;
>> +
>> +	dice->probed = true;
>> +end:
>> +	mutex_unlock(&dice->mutex);
>> +
>> +	/*
>> +	 * It's a difficult work to manage a race condition between workqueue,
>> +	 * unit event handlers and processes. The memory block for this card
>> +	 * is released as the same way that usual sound cards are going to be
>> +	 * released.
>> +	 */
>> +}
>> +
>>  static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
>>  {
>> +	struct fw_card *fw_card = fw_parent_device(unit)->card;
>>  	struct snd_card *card;
>>  	struct snd_dice *dice;
>> +	unsigned long delay;
>>  	int err;
>>  
>>  	err = check_dice_category(unit);
>> @@ -205,29 +258,20 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
>>  	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
>>  			   sizeof(*dice), &card);
>>  	if (err < 0)
>> -		goto end;
>> +		return err;
>>  
>>  	dice = card->private_data;
>>  	dice->card = card;
>>  	dice->unit = fw_unit_get(unit);
>>  	card->private_free = dice_card_free;
>> +	dev_set_drvdata(&unit->device, dice);
>>  
>>  	spin_lock_init(&dice->lock);
>>  	mutex_init(&dice->mutex);
>>  	init_completion(&dice->clock_accepted);
>>  	init_waitqueue_head(&dice->hwdep_wait);
>>  
>> -	err = snd_dice_transaction_init(dice);
>> -	if (err < 0)
>> -		goto error;
>> -
>> -	err = dice_read_params(dice);
>> -	if (err < 0)
>> -		goto error;
>> -
>> -	dice_card_strings(dice);
>> -
>> -	err = snd_dice_create_pcm(dice);
>> +	err = snd_dice_stream_init_duplex(dice);
>>  	if (err < 0)
>>  		goto error;
>>  
>> @@ -237,23 +281,13 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
>>  
>>  	snd_dice_create_proc(dice);
>>  
>> -	err = snd_dice_create_midi(dice);
>> -	if (err < 0)
>> -		goto error;
>> -
>> -	err = snd_dice_stream_init_duplex(dice);
>> -	if (err < 0)
>> -		goto error;
>> -
>> -	err = snd_card_register(card);
>> -	if (err < 0) {
>> -		snd_dice_stream_destroy_duplex(dice);
>> -		goto error;
>> -	}
>> +	/* Register this sound card later. */
>> +	INIT_DEFERRABLE_WORK(&dice->dwork, do_registration);
>> +	delay = msecs_to_jiffies(PROBE_DELAY_MS) +
>> +				fw_card->reset_jiffies - get_jiffies_64();
>> +	schedule_delayed_work(&dice->dwork, delay);
> 
> Missing negative jiffies check?

Indeed. I forgot a case that users execute rmmod/insmod by theirselves
long after bus reset. In this case, the delay is assigned to minus
value, while it's unsigned type so it can have large number.

I'd like to add this function as a solution for this issue.

static inline void schedule_registration(struct snd_dice *dice)
{
  struct fw_card *fw_card = fw_parent_device(dice->unit)->card;
  u64 delay;

  delay = fw_card->reset_jiffies + msecs_to_jiffies(PROBE_DELAY_MS);
  if (time_after64(delay, get_jiffies_64()))
      delay -= get_jiffies_64();
  else
    delay = 0;

  schedule_delayed_work(&dice->dwork, delay);
}

>>  
>> -	dev_set_drvdata(&unit->device, dice);
>> -end:
>> -	return err;
>> +	return 0;
>>  error:
>>  	snd_card_free(card);
>>  	return err;
>> @@ -263,13 +297,28 @@ static void dice_remove(struct fw_unit *unit)
>>  {
>>  	struct snd_dice *dice = dev_get_drvdata(&unit->device);
>>  
>> +	/* For a race condition of struct snd_card.shutdown. */
>> +	mutex_lock(&dice->mutex);
>> +
>>  	/* No need to wait for releasing card object in this context. */
>>  	snd_card_free_when_closed(dice->card);
>> +
>> +	mutex_unlock(&dice->mutex);
>>  }
>>  
>>  static void dice_bus_reset(struct fw_unit *unit)
>>  {
>>  	struct snd_dice *dice = dev_get_drvdata(&unit->device);
>> +	struct fw_card *fw_card = fw_parent_device(unit)->card;
>> +	unsigned long delay;
>> +
>> +	/* Postpone a workqueue for deferred registration. */
>> +	if (!dice->probed) {
>> +		delay = msecs_to_jiffies(PROBE_DELAY_MS) -
>> +				(get_jiffies_64() - fw_card->reset_jiffies);
>> +		mod_delayed_work(dice->dwork.wq, &dice->dwork, delay);
>> +		return;
> 
> No protection for race here?

Both of state transition of workqueue and the flag of 'dice->probed'
work fine to manage the race condition.

This workqueue is kept each instance of IEEE 1394 unit driver, thus the
same work can not run concurrently for the same unit. When already
scheduled, the work is expectedly postponed by mod_delayed_work(). When
the work is running, mod_delayed_work() schedules next work, but the
flag of 'dice->probed' has an effect to return immediately in the next
work. When workqueue has already finished, the flag of 'dice->probed'
avoid rescheduling of the work.


Thank you

Takashi Sakamoto

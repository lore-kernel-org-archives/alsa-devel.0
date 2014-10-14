From: Arthur Marsh <arthur.marsh@internode.on.net>
Subject: Re: lock-up when loading desktop
Date: Tue, 14 Oct 2014 13:56:36 +1030
Message-ID: <543C97EC.4040000@internode.on.net>
References: <543B2438.1050002@internode.on.net>	<s5ha950zeyi.wl-tiwai@suse.de>	<543BB942.5060602@internode.on.net>	<s5h7g04ywgg.wl-tiwai@suse.de>	<543BCDE9.7010308@internode.on.net>	<s5h38asyrld.wl-tiwai@suse.de>	<543C153A.4060607@internode.on.net>
 <s5hk343y9ew.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail05.adl6.internode.on.net (ipmail05.adl6.internode.on.net
 [150.101.137.143])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E9DF26041C
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 05:26:43 +0200 (CEST)
In-Reply-To: <s5hk343y9ew.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Takashi Iwai wrote, on 14/10/14 07:27:

>> # git reset --hard HEAD~
>> HEAD is now at 77c688a Merge branch 'for-linus' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
>> am64:/usr/src/linux# git revert 7af142f752116e86adbe2073f2922d8265a77709
>> [master 927ab0d] Revert "ALSA: pcm: Uninline snd_pcm_stream_lock() and
>> _unlock()"
>>    Committer: root <root@am64.localdomain>
>> Your name and email address were configured automatically based
>> on your username and hostname. Please check that they are accurate.
>> You can suppress this message by setting them explicitly:
>>
>>       git config --global user.name "Your Name"
>>       git config --global user.email you@example.com
>>
>> After doing this, you may fix the identity used for this commit with:
>>
>>       git commit --amend --reset-author
>>
>>    2 files changed, 73 insertions(+), 72 deletions(-)
>> am64:/usr/src/linux# git revert 257f8cce5d40b811d229ed71602882baa0012808
>> [master e59721c] Revert "ALSA: pcm: Allow nonatomic trigger operations"
>>    Committer: root <root@am64.localdomain>
>> Your name and email address were configured automatically based
>> on your username and hostname. Please check that they are accurate.
>> You can suppress this message by setting them explicitly:
>>
>>       git config --global user.name "Your Name"
>>       git config --global user.email you@example.com
>>
>> After doing this, you may fix the identity used for this commit with:
>>
>>       git commit --amend --reset-author
>>
>>    3 files changed, 19 insertions(+), 116 deletions(-)
>> am64:/usr/src/linux# git diff v3.17.. sound/core/pcm_native.c
>> am64:/usr/src/linux# git reset --hard HEAD~
>> HEAD is now at 927ab0d Revert "ALSA: pcm: Uninline snd_pcm_stream_lock()
>> and _unlock()"
>> am64:/usr/src/linux# git reset --hard v3.17
>> Checking out files: 100% (6352/6352), done.
>> HEAD is now at bfe01a5 Linux 3.17
>> am64:/usr/src/linux# git checkout -b sound-test
>> Switched to a new branch 'sound-test'
>> am64:/usr/src/linux# git merge fd1a2a90d08b0052fa52bd36cebd0592c9e537c2
>> Updating bfe01a5..fd1a2a9
>> Fast-forward
>> [big list of files]
>>
>> /usr/src/linux# patch -p1 <../sound.patch
>> patching file sound/core/pcm_native.c
>
> Wait... which patch is this?

This one:

---
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 85fe1a216225..9c7cbd1b839e 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2275,6 +2275,9 @@ static int snd_pcm_open(struct file *file, struct 
snd_pcm *pcm, int stream)
  	int err;
  	wait_queue_t wait;

+	if (WARN_ON(pcm->nonatomic))
+		return -EINVAL;
+
  	if (pcm == NULL) {
  		err = -ENODEV;
  		goto __error1;



>  Could you test without this (but with
> the patch below)?

OK.

> I looked at the relevant code now, and this indeed seems like a
> deadlock.  But it's nothing new, the code is a decade old.  I wonder
> why it appears out of sudden.  Maybe the change of the spin lock path
> triggers.
>
> The patch below is the fix, just removing the superfluous spinlock.
>
>> I can supply a dmesg output of the machine with the test kernel before
>> attempting anything that might cause a lock-up if it's of use to you.
>>
>> PS, how do I get my git repositary out of "sound-test" branch and return
>> to Linus' git head?
>
> Just do "git checkout master"

Thanks!

>
>
> Takashi
>
> ---
> diff --git a/sound/pci/emu10k1/emu10k1_callback.c b/sound/pci/emu10k1/emu10k1_callback.c
> index 3f3ef38d9b6e..874cd76c7b7f 100644
> --- a/sound/pci/emu10k1/emu10k1_callback.c
> +++ b/sound/pci/emu10k1/emu10k1_callback.c
> @@ -85,6 +85,8 @@ snd_emu10k1_ops_setup(struct snd_emux *emux)
>    * get more voice for pcm
>    *
>    * terminate most inactive voice and give it as a pcm voice.
> + *
> + * voice_lock is already held.
>    */
>   int
>   snd_emu10k1_synth_get_voice(struct snd_emu10k1 *hw)
> @@ -92,12 +94,10 @@ snd_emu10k1_synth_get_voice(struct snd_emu10k1 *hw)
>   	struct snd_emux *emu;
>   	struct snd_emux_voice *vp;
>   	struct best_voice best[V_END];
> -	unsigned long flags;
>   	int i;
>
>   	emu = hw->synth;
>
> -	spin_lock_irqsave(&emu->voice_lock, flags);
>   	lookup_voices(emu, hw, best, 1); /* no OFF voices */
>   	for (i = 0; i < V_END; i++) {
>   		if (best[i].voice >= 0) {
> @@ -113,11 +113,9 @@ snd_emu10k1_synth_get_voice(struct snd_emu10k1 *hw)
>   			vp->emu->num_voices--;
>   			vp->ch = -1;
>   			vp->state = SNDRV_EMUX_ST_OFF;
> -			spin_unlock_irqrestore(&emu->voice_lock, flags);
>   			return ch;
>   		}
>   	}
> -	spin_unlock_irqrestore(&emu->voice_lock, flags);
>
>   	/* not found */
>   	return -ENOMEM;
>

I'll apply the above patch only first and report the results.

Thanks again,

Arthur.

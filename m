From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Controlling the Tascam FW-1884
Date: Fri, 2 Nov 2018 21:05:35 +0900
Message-ID: <d3bdd2c0-1737-cf75-2d7d-53639127ab00@sakamocchi.jp>
References: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
 <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
 <985b1f6dc5b0af2aae049e0b6fcf976ab400d34d.camel@suse.com>
 <55afba82-ad24-fe70-b784-d28a38e291c9@sakamocchi.jp>
 <7a0f35eea26ce475bc3f6953db97f83205ad0a58.camel@suse.com>
 <fc278639-12da-02b8-685d-681e06b044e4@sakamocchi.jp>
 <10a99ea9c672ac6d0c9d5536e9d85a15f5a32d95.camel@suse.com>
 <47f66c7d-4337-52da-72da-cdb3f0638dc4@sakamocchi.jp>
 <d63527a1ab830c50c621664946ad9eafdb37d578.camel@suse.com>
 <f4537970-775e-6480-acc4-6b5dd050d597@sakamocchi.jp>
 <fed5ab3a-c39a-4de9-6802-c064a33140eb@sakamocchi.jp>
 <246b8baaa3c415a0accdb76d3b524dec5e0429f9.camel@suse.com>
 <97e54edf-1e47-d422-e438-a2c859083fd3@sakamocchi.jp>
 <58ef33b1fffec178217044e0f0d5f2b6aecfc31d.camel@suse.com>
 <4a971bd3716ddf43662b637904209f5230ccbf02.camel@suse.com>
 <daf2b08b-dfdf-b4a3-8820-0a5f3ab78fc4@sakamocchi.jp>
 <bd6c69dbb0cb7347f9023728a598e65f0b297323.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 59C9D2675BA
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2018 13:05:40 +0100 (CET)
Received: by mail-pg1-f194.google.com with SMTP id w7so892162pgp.13
 for <alsa-devel@alsa-project.org>; Fri, 02 Nov 2018 05:05:40 -0700 (PDT)
In-Reply-To: <bd6c69dbb0cb7347f9023728a598e65f0b297323.camel@suse.com>
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
To: Scott Bahling <sbahling@suse.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Scott,

On 2018/11/02 18:26, Scott Bahling wrote:
>> Thanks for your PR[1] and it works well. But here I suggest that
>> we can judge the frequency to call SNDRV_FIREWIRE_IOCTL_TASCAM_STATUS
>> ioctl is surely less than the frequency on packet processing. If we
>> attempt to keep low CPU usage in the packet processing, current
>> implementation can be kept as is. Instead, a patch for handler of the
>> ioctl is worth for commit.
> 
> Makes perfect sense.
> 
>> For example, This patch will fix the issue.
>>
>> ```
>> $ git diff
>> diff --git a/sound/firewire/tascam/tascam-hwdep.c
>> b/sound/firewire/tascam/tascam-hwdep.c
>> index ad164ad..dff7dc4 100644
>> --- a/sound/firewire/tascam/tascam-hwdep.c
>> +++ b/sound/firewire/tascam/tascam-hwdep.c
>> @@ -189,10 +189,23 @@ static int hwdep_unlock(struct snd_tscm *tscm)
>>
>>    static int tscm_hwdep_status(struct snd_tscm *tscm, void __user
>> *arg)
>>    {
>> -       if (copy_to_user(arg, tscm->status, sizeof(tscm->status)))
>> -               return -EFAULT;
>> +       struct snd_firewire_tascam_status *status;
>> +       int i;
>> +       int err = 0;
>>
>> -       return 0;
>> +       status = kmalloc(sizeof(*status), GFP_KERNEL);
>> +       if (!status)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < SNDRV_FIREWIRE_TASCAM_STATUS_COUNT; ++i)
>> +               status->data[i] = be32_to_cpu(tscm->status[i]);
>> +
>> +       if (copy_to_user(arg, status, sizeof(*status)))
>> +               err = -EFAULT;
>> +
>> +       kfree(status);
>> +
>> +       return err;
>>    }
>> ```
>>
>> I'd like you to test with this patch, before granting your PR.
> 
> I have tested and the patch above works as expected.

Thanks for your check. I pushed the above patch into my remote branch.

Well, soon, merge window for v4.20 (or v5.0) kernel will be closed, then
we start working for next v4.21 (or v5.1) kernel. I have a plan to
include changes required for the status and control message in this
development period (not prepare yet) and the changes are the same in
the remote branch. I'll add you to C.C list when posting patches for it.

If you require more functionality, please inform it to me in this
development period.


Thanks

Takashi Sakamoto

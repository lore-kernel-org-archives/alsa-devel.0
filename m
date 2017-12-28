From: b_lkasam@codeaurora.org
Subject: Re: ALSA: Soc_compress open file node allows more than
 once
Date: Thu, 28 Dec 2017 12:05:07 +0530
Message-ID: <d2c31d97538d192197dd8e26e94d653c@codeaurora.org>
References: <f469eb3a04f49f7b5603572546852685@codeaurora.org>
 <s5hmv3d3yfn.wl-tiwai@suse.de> <20171127055019.GP3187@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BC1726717C
 for <alsa-devel@alsa-project.org>; Thu, 28 Dec 2017 07:35:09 +0100 (CET)
In-Reply-To: <20171127055019.GP3187@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lkasam@qti.qualcomm.com, mangeshk@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org

On 2017-11-27 11:20, Vinod Koul wrote:
> On Thu, Nov 23, 2017 at 02:41:00PM +0100, Takashi Iwai wrote:
>> On Thu, 23 Nov 2017 14:18:30 +0100,
>> b_lkasam@codeaurora.org wrote:
>> >
>> > Hi ALSA team,
>> > This is regarding compress offload framework file operations wrt open
>> > system call.
>> >
>> > For open call to this driver currently allows for same node more than
>> > once.
>> >
>> > This may result in memleak issues or data corruption if same node in
>> > use by multiple instances.
>> 
>> This only depends on the driver side implementation.  There is no
>> restriction in the core side, as the multiple open is possible
>> depending on the hardware design and the driver implementation.
> 
> sounds right to me, also is the leak on core side or your driver?
> 
Sorry for delay in getting back.. Yes, leak was in driver not on core 
side.
Thanks everyone for inputs...We have fixed it in our driver.
>> 
>> > can we have restriction to avoid open of same node using some refcount?
>> >
>> > we can either have refcount under compr->private_data and cross check
>> > in below function before proceeding.
>> > static int snd_compr_open(struct inode *inode, struct file *f)
>> >
>> > Please suggest accordingly.
>> 
>> I'd suggest just to add an exclusive open check in the driver side.
>> The open/close callbacks are protected via a mutex, so it can be a
>> simple bool flag check.
>> 
>> If the exclusive access is regarded as a common pattern, we can add
>> some flag to snd_compr later and check it in the core, instead, too.

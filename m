From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] ASoC: rl6347a: Use dev_err_once for I2C
 communication error prints
Date: Fri, 7 Oct 2016 10:47:12 +0300
Message-ID: <48e5d022-c7c1-93b9-8b52-7890efe944a5@linux.intel.com>
References: <20161005140536.12166-1-jarkko.nikula@linux.intel.com>
 <20161006162624.bvnn2s7u7s2uex6j@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 15D2026576D
 for <alsa-devel@alsa-project.org>; Fri,  7 Oct 2016 09:47:16 +0200 (CEST)
In-Reply-To: <20161006162624.bvnn2s7u7s2uex6j@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/06/2016 07:26 PM, Mark Brown wrote:
> On Wed, Oct 05, 2016 at 05:05:36PM +0300, Jarkko Nikula wrote:
>
>> It's difficult to guess from bunch of "ret=-121" errors what driver and
>> device actually caused them. Since struct i2c_client has the dev pointer
>> use that for dev_err_once() in order to see the device and not spam the
>> log needlessly.
>
> dev_err() is obviously an improvement (as would a better message be) but
> dev_err_once() seems like a big jump that we don't normally do for our
> I/O errors - transient errors do happen from time to time (especially
> when people get their power up sequences wrong) and it can be useful to
> know if something is just dead, failed gradually over time or just had a
> single transient error.  It's also helpful since a lot of the errors
> that do occur result in long timeouts so it's not always clear that
> we're grinding through lots of I/Os if we don't say anything.  Am I
> missing something about this case?
>
You are right. This looks like it is either due HW issue or pincontrol 
misconfiguration after resume and device starts making interrupt storm 
and acknowledging them fails before I2C is resumed. I switch it to 
dev_err().

-- 
Jarkko

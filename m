From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 15/27] ALSA: hda - Use
 timecounter_initialize interface
Date: Tue, 2 Jan 2018 13:53:01 -0600
Message-ID: <9f09abee-68b8-4515-131f-0f3e210503b0@linux.intel.com>
References: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
 <1513323522-15021-16-git-send-email-sagar.a.kamble@intel.com>
 <s5hh8ssgsaw.wl-tiwai@suse.de> <20171215165125.avkz25eek56i5md4@localhost>
 <s5h4lorx6ha.wl-tiwai@suse.de>
 <b0d5ff40-fbfe-e5b3-2844-7d930484e87f@intel.com>
 <20171228164944.crphv46zegvwautk@localhost>
 <1a9a1507-7ca3-459b-c2ce-02fc2afad2ff@intel.com>
 <3c5734a2-8f97-4a8b-26d4-42852cc86352@linux.intel.com>
 <20180102182146.vbfnihz73lhgf6lc@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E455267556
 for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2018 20:53:03 +0100 (CET)
In-Reply-To: <20180102182146.vbfnihz73lhgf6lc@localhost>
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
To: Richard Cochran <richardcochran@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Sagar Arun Kamble <sagar.a.kamble@intel.com>
List-Id: alsa-devel@alsa-project.org

On 1/2/18 12:21 PM, Richard Cochran wrote:
> On Tue, Jan 02, 2018 at 11:15:45AM -0600, Pierre-Louis Bossart wrote:
>> I wrote the code for HDaudio and I remember wasting time trying to figure
>> out the gory details of the cycle counter stuff when all I wanted was a
>> conversion from a 24MHz counter to ns values using a 125/3 operation in the
>> right order - as explained in the comments
> 
> Would using clocks_calc_mult_shift() work for you?

In theory yes, but I'd need to re-check what the results would be.
I remember applying the 1/3 factor separately to avoid wrap-around after 
4 hours [1], but I can't remember the details on the analysis. I can't 
figure out what the 'maxsec' argument should be either.

[1] 
http://elixir.free-electrons.com/linux/latest/source/sound/hda/hdac_stream.c#L486

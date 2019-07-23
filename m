From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RESEND PATCH v2 0/7] ASoC: Intel: Skylake: Driver
 fundaments overhaul
Date: Tue, 23 Jul 2019 13:07:31 -0500
Message-ID: <cac0d84e-61d3-5379-cbce-10f8d637310d@linux.intel.com>
References: <20190723145854.8527-1-cezary.rojewski@intel.com>
 <20190723154449.GJ5365@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12D60F8011C
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 20:07:32 +0200 (CEST)
In-Reply-To: <20190723154449.GJ5365@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>, Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 7/23/19 10:44 AM, Mark Brown wrote:
> On Tue, Jul 23, 2019 at 04:58:47PM +0200, Cezary Rojewski wrote:
>> Skylake driver is divided into two modules:
>> - snd_soc_skl
>> - snd_soc_skl_ipc
> 
> Pierre?

Sorry I was traveling and while I saw this series I never found the time 
to review it.

I have really mixed feelings here and would like to make sure we are all 
aligned on how we deal with the Skylake driver.

On one side I see that Cezary's team has done a genuine effort to 
clean-up the code, show their technical skills, provide and listen to 
review feedback, and improve the quality of upstream code. It wouldn't 
be fair to shoot down well-intended developers who are making an honest 
effort after years of embarrassing contributions. Intel and the Linux 
community also have a shared interest in making sure newer kernel 
versions improve quality and conversely that existing solutions can be 
upgraded to improve security while also improving audio.

On the other hand, I still see an opaque design (no obvious 
core/platform split, mind-boggling use of topology with closed tools, 
IPC that I still don't get), limited information on testing. I don't 
think anyone challenges the fact that this driver is what it is, and not 
the foundation for future upstream work. And there are about 100 
additional clean-up/updates patches to be submitted for this driver, 
which I don't personally have the time to look into since I am already 
fully-booked on SoundWire work.

Overall my recommendations would be to:
- give Cezary's team the benefit of the doubt for their Skylake reworks, 
and add him as mandatory reviewer for the skylake parts. That doesn't 
mean merging blindly but recognizing that no one else at Intel has a 
better understanding of this code.
- add CI support w/ Skylake devices so that we can have a better feel 
for compilation/testing support. we've talked about having upstream 
automatic build/hardware tests, maybe now is the time to do something 
about it.
- draw the line at "no new features" after e.g. 5.5 and "no new 
platforms when SOF provides a solution". SOF was expected to reach 
feature parity by the end of 2019 so it's not a random date I just made up.
- I am even tempted to recommend de-featuring HDaudio codec support in 
the Skylake driver since we already know of a broken probe that was 
found on Linus' laptop and a slew of changes applied to SOF/legacy that 
are missing in this driver.

Comments and feedback welcome.

-Pierre

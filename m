From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v3] ASoC: Replace snd_soc_acpi_check_hid with
 acpi_dev_present
Date: Tue, 14 Nov 2017 13:54:59 -0600
Message-ID: <877c2ab8-757d-1bda-217a-c125d031cafe@linux.intel.com>
References: <0100015fa737dec2-4d7283d5-bba0-4270-9f92-8f258d2835dd-000000@email.amazonses.com>
 <20618d9a-4bd3-1653-b749-6db0c2162ac3@linux.intel.com>
 <0100015fbbf26a1b-15f2d4e5-7c3d-4c15-83f9-1b719ae9a74c-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0100015fbbf26a1b-15f2d4e5-7c3d-4c15-83f9-1b719ae9a74c-000000@email.amazonses.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Cline <jeremy@jcline.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 11/14/2017 01:12 PM, Jeremy Cline wrote:
> On Mon, Nov 13, 2017 at 01:43:57PM -0600, Pierre-Louis Bossart wrote:
>> On 11/10/2017 12:36 PM, Jeremy Cline wrote:
>>> Replace snd_soc_acpi_check_hid() with the generic acpi_dev_present()
>>> and remove the now unused snd_soc_acpi_check_hid function. This should
>>> have no functional change.
>> The code looks ok, but I'd like to first add the fix for the quirk handling
>> regression which appeared in 4.13 and is still there in 4.14. Current fix is
>> at https://bugzilla.kernel.org/attachment.cgi?id=258581
>>
>> Can we wait a couple of days on this one to avoid mixing bug fixes and
>> renames? this would also make the stable branch fix easier to handle.
> That makes perfect sense to me. I'm pretty new to all this, should I just
> keep an eye on things and rebase this once that patch lands?
if it's easier I can submit both the fix and your change in the same 
series (keeping you as the author of course)
>
> Thanks,
> Jeremy
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

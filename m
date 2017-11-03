From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: How to handle jack detection through gpios
Date: Fri, 3 Nov 2017 19:43:46 +0100
Message-ID: <0d313367-eb11-f84b-6195-728b4270fab5@redhat.com>
References: <d8e782f1-acd9-09c4-9693-729a6ac07aa3@redhat.com>
 <20171103112452.g7d7wbxhjhtbzmec@sirena.org.uk>
 <27d3a7cc-d67d-28e0-c615-f6e9a56f9de1@redhat.com>
 <20171103174027.iu556xlqmp2owtmd@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F0CD266CFB
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 19:43:49 +0100 (CET)
In-Reply-To: <20171103174027.iu556xlqmp2owtmd@sirena.co.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, sfumato1977@gmail.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 03-11-17 18:40, Mark Brown wrote:
> On Fri, Nov 03, 2017 at 01:09:37PM +0100, Hans de Goede wrote:
>> On 03-11-17 12:24, Mark Brown wrote:
> 
>>> You can make a GPIO input device but obviously can't have anything
>>> reporting through the sound card interface without a sound card.
> 
>> Ok, so I could make the driver generate evdev events
>> of type EV_SW with code SW_HEADPHONE_INSERT. Does userspace
>> do anything useful with this like automatically switching
>> between headphones and speakers as a headphone-jack which
>> is part of the sound card would do ?
> 
> Depends on your userspace, you can also do an extcon which Android
> listens to IIRC.
> 
>> If not, then is there a way to get a list of registered
>> soundcards from a driver, then pick one of the cards
>> based on some heuristics and then do the snd_soc_card_jack_new,
>> etc. on the picked card?
> 
>> I assume that the approach from:
>> https://github.com/me176c-dev/kernel_asus_me176c/commit/498116d7e7b4718fa0655c4879e59a163b1dd85b
> 
>> Where the struct snd_soc_card byt_rt5640_card is made
>> non-static and exported is not acceptable ?
> 
> Why not have the sound card claim the GPIO and provide the jack?

Yes that would be ideal, but on some devices the ACPI resources
table describing the gpio is not part of the acpi_companion of
the codec, but rather of another ACPI device all together.

It might be best to see if we can somehow search through the list
of ACPI devices from the codec driver and get through the GPIO
that way. I guess we will need a utility function for this to
share between codec drivers, since the same AMCR0F28 ACPI device
is used in DSTDs together with different codecs.

Regards,

Hans

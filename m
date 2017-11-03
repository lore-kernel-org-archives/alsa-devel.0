From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: How to handle jack detection through gpios
Date: Fri, 3 Nov 2017 13:09:37 +0100
Message-ID: <27d3a7cc-d67d-28e0-c615-f6e9a56f9de1@redhat.com>
References: <d8e782f1-acd9-09c4-9693-729a6ac07aa3@redhat.com>
 <20171103112452.g7d7wbxhjhtbzmec@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id E63DF266A0C
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 13:09:41 +0100 (CET)
In-Reply-To: <20171103112452.g7d7wbxhjhtbzmec@sirena.org.uk>
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

On 03-11-17 12:24, Mark Brown wrote:
> On Fri, Nov 03, 2017 at 09:41:29AM +0100, Hans de Goede wrote:
> 
>> So I was wondering if there is a way to have a headphone
>> switch without tying it to a card, while userspace will
>> still know what to do ?
> 
> You can make a GPIO input device but obviously can't have anything
> reporting through the sound card interface without a sound card.

Ok, so I could make the driver generate evdev events
of type EV_SW with code SW_HEADPHONE_INSERT. Does userspace
do anything useful with this like automatically switching
between headphones and speakers as a headphone-jack which
is part of the sound card would do ?

If not, then is there a way to get a list of registered
soundcards from a driver, then pick one of the cards
based on some heuristics and then do the snd_soc_card_jack_new,
etc. on the picked card?

I assume that the approach from:
https://github.com/me176c-dev/kernel_asus_me176c/commit/498116d7e7b4718fa0655c4879e59a163b1dd85b

Where the struct snd_soc_card byt_rt5640_card is made
non-static and exported is not acceptable ?

Regards,

Hans

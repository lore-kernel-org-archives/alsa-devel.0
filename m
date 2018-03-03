From: Hans de Goede <j.w.r.degoede@gmail.com>
Subject: Re: [PATCH v2 06/32] ASoC: rt5651: Configure
 jack-detect source through a device-property
Date: Sat, 3 Mar 2018 22:20:22 +0100
Message-ID: <1f1dc2eb-b4d7-d9ce-960d-54fa7120bc6f@gmail.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
 <20180225104713.4745-7-hdegoede@redhat.com>
 <20180301193046.GJ12864@sirena.org.uk>
 <032d0e59-0d64-7df1-4fca-1709430b754c@redhat.com>
 <2ac828b2-04e1-4b5f-f4db-a543ad5e3535@redhat.com>
 <20180302121801.GE6255@sirena.org.uk>
 <bbe1b540-201a-bf6e-9008-0f8d5d4a2a9d@redhat.com>
 <20180302174111.GA3482@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A6EB266E78
 for <alsa-devel@alsa-project.org>; Sat,  3 Mar 2018 22:20:25 +0100 (CET)
Received: by mail-wm0-f52.google.com with SMTP id h21so9155097wmd.1
 for <alsa-devel@alsa-project.org>; Sat, 03 Mar 2018 13:20:25 -0800 (PST)
In-Reply-To: <20180302174111.GA3482@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 02-03-18 18:41, Mark Brown wrote:
> On Fri, Mar 02, 2018 at 01:58:53PM +0100, Hans de Goede wrote:
>> On 02-03-18 13:18, Mark Brown wrote:
> 
>>> What makes you claim that?  Any board with jack detection wired up will
>>> call that function.  Not all boards have that configured of course but
>>> there's absolutely nothing Intel specific about that interface.
> 
>> Right I'm not claiming the interface is Intel specific, what I'm trying
>> to say is that the need for some code outside of the codec driver
>> to create the jack means that adding jack-support to DT platforms
>> cannot be done through just adding DT properties (once this patch
>> is merged), it will still require platform code changes.
> 
> On DT the situation with generic drivers is much better than it is on
> ACPI so we're actually able to create jacks purely from DT with both the
> simple and graph cards.  This was what drove the creation of the generic
> jack operation rather than device specific function calls, Bard realized
> that the device specific calls were all very similar and adding the call
> allowed the generic cards to work with jacks.
> 
>>> No, that's really not a good idea.  Any jacks in the system are part of
>>> the system specific wiring, they're not something that's intrinsic to
>>> the CODEC.  Even with fairly basic setups you've got options like having
>>> a headset jack or separate microphone and headphone jacks.
> 
>> OK, so if doing the jack creation in the machine-driver / platform
>> code is by design and you want to keep things that way, then I
>> assume that what needs changing for v3 of this patch is:
> 
>> 1) Split the patch in separate codec + machine-drv patches
>> 2) Add comments to make the ordering requirements clear to
>> both the codec- and machine-driver.
> 
>> Correct?
> 
> Yes, I think so.

Actually I've come up with a nicer way to deal with the ordering issues
around setting the device-properties from the machine-driver.

If we attach the properties in the machine-driver *before* calling
snd_soc_register_card() and check them from the codec/component driver's
probe function (rather then from the i2c_driver.probe function), then
there is no need for a codec private apply_properties() function to
get the ordering right, since the codec/component driver's probe
function is called from snd_soc_register_card().

This still needs some comments in both the codec and machine driver
to make sure that future changes don't cause issues, but it gets rid
of the ugly apply_properties() function call from the machine-driver.

I'm currently preparing a v3 with this change + other requested changes.
I need to re-run a bunch of tests before posting, so I hope to post the
v3 series tomorrow.

Regards,

Hans

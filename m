From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Silencing plops / click sounds on start / stop of
 playing audio when snd_hda_intel.power_save=1
Date: Wed, 17 Jan 2018 10:01:46 +0100
Message-ID: <6d2c90ec-fb80-5d87-be5f-8086e0705a1b@redhat.com>
References: <522e1590-6f1c-6c7d-4c8a-96c5dcbf6051@redhat.com>
 <ec7801cb-0673-8a5e-e379-d1a441197f65@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 565E2266B67
 for <alsa-devel@alsa-project.org>; Wed, 17 Jan 2018 10:01:48 +0100 (CET)
Received: by mail-wm0-f48.google.com with SMTP id g1so13532650wmg.2
 for <alsa-devel@alsa-project.org>; Wed, 17 Jan 2018 01:01:48 -0800 (PST)
In-Reply-To: <ec7801cb-0673-8a5e-e379-d1a441197f65@perex.cz>
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
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
Cc: jeremy@jcline.org, pulseaudio-discuss@lists.freedesktop.org, Benjamin Berg <bberg@redhat.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 15-12-17 14:49, Jaroslav Kysela wrote:
> Dne 15.12.2017 v 13:35 Hans de Goede napsal(a):
>> Hi All,
>>
>> For Fedora 28 we plan to ship the kernel with snd_hda_intel.power_save
>> defaulting to 1:
>>
>> https://fedoraproject.org/wiki/Changes/ImprovedLaptopBatteryLife
>>
>> We've had an update for F27 in updates-testing for a while which made
>> the same change for F27, but we've received several bug reports
>> about plops / click sounds on start / stop of playing audio:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1525104
>>
>> I know others have probably already tried fixing this, but I'm
>> wondering if there are any ideas how to fix this / things to try?
>>
>> Ideas of my own:
>>
>> 1) Mute the speakers / headphone output in the mixer before
>> activating power-saving. Question how hard would it be to
>> make this happen?
>>
>> 2) Put a delay between various steps involved in turning
>> things off / on.
> 
> Hi,
> 
> I am a bit skeptic about those proposals. I think that the drivers
> should do this job, because some hardware variants have different
> requirements for the proper power-off/on sequence.

Ok, this were just some quick ideas.

> The problem appears like an improper voltage change and the HDA driver
> has already a lot of code which is trying to eliminate these pops (but
> as you can see, it is not sufficient).
> 
> Honestly, I don't know if it's good to keep this "hidden" to users or
> enable the power save feature by default and let users to report this,
> so we can look into this problem more when the affected hardware is
> identified.

I'm trying to have power_save=1 as default for the upcoming Fedora
28, because the power-savings of this are quite significant.

So I agree with you that we should enable the feature by default and
get users to file bugs (and make sure there is 1 bug per model,
not a lot of me too comments) for machines where there still are
issues.

But getting these issues fixed is going to take time, so I think we
will also need a blacklist (with a comment pointing to the machine
specific bug per entry) to at least temporarily disable the
snd_hda_intel powersaving feature on affected machines.

My proposal is to use a new /lib/udev/hwdb.d/60-snd_hda_intel.hwdb
file for this blacklist (I believe it is better to keep this out
of the kernel), combined with a udev rule modifying the power_save
setting based on hwdb blacklist entries.

The udev rule will need some way to modify the power_save option,
AFAIK modifying module parameters from udev is not really easily
doable, unless we invoke a shell as helper to do an actual echo
which seems ugly (please correct me if I'm wrong).

My proposal for the udev role problem is to add a power_save sysfs
attribute to the snd_hda_intel PCI device (or maybe to the alsa
card sound class dev?), so e.g. have a
/sys/bus/pci/devices/0000\:00\:1f.3/power_save file. This sysfs
attribute will be a 2-way mirror of the module option, so that
tools like TLP and power-top which write the module-option will
keep working. This does mean that in the theoretical case of having
2 intel_hda devices changing the option on one will also change
it on the other.

I plan to start working on implementing this sometime next week,
or the week after that, depending on how my current project goes.
In the mean time any feedback on my proposal how to handle this
would be much appreciated.

Regards,

Hans

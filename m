From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: How to handle jack detection through gpios
Date: Fri, 3 Nov 2017 07:41:06 -0500
Message-ID: <4ae2c6dc-d3ee-2563-ee84-a8f26948d8f8@linux.intel.com>
References: <d8e782f1-acd9-09c4-9693-729a6ac07aa3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B1B326752C
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 13:41:07 +0100 (CET)
In-Reply-To: <d8e782f1-acd9-09c4-9693-729a6ac07aa3@redhat.com>
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
To: Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, sfumato1977@gmail.com, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On 11/3/17 3:41 AM, Hans de Goede wrote:
> Hi All,
> 
> Umberto Izzo (in the Cc) mailed me to see if I could help
> with implementing headphone detection through GPIOS as I've
> been doing all kinds of Bay / Cherry Trail related work
> recently.
> 
> Umberto found this commit:
> 
> https://github.com/me176c-dev/kernel_asus_me176c/commit/498116d7e7b4718fa0655c4879e59a163b1dd85b 
> 
> 
> Which looks interesting, but is specific to the RT5640
> driver. Looking at my own test devices I found a device
> with an ES8316 using a gpio for headphone detection.
> 
> What Umberto and my device have in common is that
> the GPIO to use is listed in the ACPI tables
> under an AMCR0F28 device and that is also what the
> above commit binds too.

This is not a generic solution, these sort of ACPI entries are only 
present in devices designed for Android, in Windows the STA_ method 
typically reports 0 (not present) - the ASL code is usually shared 
between Windows and Android devices but there are variables controlling 
what the run-time behavior is, mostly to avoid the yellow bang the 
windows device manager if there is a device without a driver.

Also you have two quirks for each of jack detection / button press, some 
platforms rely on codec-based detection and some of gpios directly 
connected to the SOC. We tried to port some of the code from Android a 
while ago but i haven't had time to maintain or even clean it. See
https://github.com/plbossart/sound/pull/1


> 
> So I was wondering if there is a way to have a headphone
> switch without tying it to a card, while userspace will
> still know what to do ?
> 
> ###
> 
> Another (non audio) problem is that the AMCR0F28 ACPI
> device seems to be present in the DSTD for almost all
> Bay / Cherry Trail devices, but its _STA method always
> returns 0 even on devices where we do need to use gpios
> for headphone-detection.
> 
> I'm thinking about solving this by adding the AMCR0F28
> device to the list of always present ACPI devices, so that
> the kernel ignores _STA and creates a platform device for
> it. And then in the platform driver for the AMCR0F28
> platform device use a DMI whitelist, this is not the
> prettiest solution but it is the best I can come up with
> atm. As said not really audio related,
> 
> Regards,
> 
> Hans
> 
> 

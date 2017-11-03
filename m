From: Hans de Goede <hdegoede@redhat.com>
Subject: How to handle jack detection through gpios
Date: Fri, 3 Nov 2017 09:41:29 +0100
Message-ID: <d8e782f1-acd9-09c4-9693-729a6ac07aa3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C6F3266A0C
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 09:41:34 +0100 (CET)
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
To: Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, sfumato1977@gmail.com, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi All,

Umberto Izzo (in the Cc) mailed me to see if I could help
with implementing headphone detection through GPIOS as I've
been doing all kinds of Bay / Cherry Trail related work
recently.

Umberto found this commit:

https://github.com/me176c-dev/kernel_asus_me176c/commit/498116d7e7b4718fa0655c4879e59a163b1dd85b

Which looks interesting, but is specific to the RT5640
driver. Looking at my own test devices I found a device
with an ES8316 using a gpio for headphone detection.

What Umberto and my device have in common is that
the GPIO to use is listed in the ACPI tables
under an AMCR0F28 device and that is also what the
above commit binds too.

So I was wondering if there is a way to have a headphone
switch without tying it to a card, while userspace will
still know what to do ?

###

Another (non audio) problem is that the AMCR0F28 ACPI
device seems to be present in the DSTD for almost all
Bay / Cherry Trail devices, but its _STA method always
returns 0 even on devices where we do need to use gpios
for headphone-detection.

I'm thinking about solving this by adding the AMCR0F28
device to the list of always present ACPI devices, so that
the kernel ignores _STA and creates a platform device for
it. And then in the platform driver for the AMCR0F28
platform device use a DMI whitelist, this is not the
prettiest solution but it is the best I can come up with
atm. As said not really audio related,

Regards,

Hans

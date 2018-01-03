From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/6] ASoC: rt5645: change micbias widget
	type to supply.
Date: Wed, 3 Jan 2018 12:32:51 +0100
Message-ID: <e3e481ba-f47b-5272-57c0-5f90eb1f4432@redhat.com>
References: <20180102185314.17189-1-hdegoede@redhat.com>
 <20180102185314.17189-2-hdegoede@redhat.com>
 <20180103105053.GA5603@sirena.org.uk>
 <f2b24e22-6e4c-cd9d-e6c1-e9546d98b8c4@redhat.com>
 <20180103112844.GB5603@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id B8CAD2668F0
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 12:32:53 +0100 (CET)
Received: by mail-wm0-f49.google.com with SMTP id f206so2136927wmf.5
 for <alsa-devel@alsa-project.org>; Wed, 03 Jan 2018 03:32:53 -0800 (PST)
In-Reply-To: <20180103112844.GB5603@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 03-01-18 12:28, Mark Brown wrote:
> On Wed, Jan 03, 2018 at 12:01:38PM +0100, Hans de Goede wrote:
> 
>> Right, we have existing machines with a rt5645 and an internal
>> analog mic, but those have been broken sofar (I can confirm
>> this for Cherry Trail based devices, I assume it applies
>> elsewhere) because without the next patch in this series we
>> were never actually enabling micbias. So this change should be
>> fine as analog mic support has been broken sofar anyways AFAIK.
> 
> Are you sure this also applies to non-x86 platforms?

I believe so, yes.

Bard, you've a rt5645 test board which does not use a x86 processor,
right? Can you confirm that the analog microphone input there does
not work with current kernels and needs your
"ASoC: rt5645: add micbias power control select." patch to work?

> This analysis
> needs to be in the changelog.

Ok I will send a v2 with the changelog ammended any comments for
the rest of the series?

Regards,

Hans

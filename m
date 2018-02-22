From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 03/11] ASoC: rt5651: Fix bias_level
 confusion / overcurrent detection deps
Date: Thu, 22 Feb 2018 12:04:03 +0100
Message-ID: <8cd8236f-d20c-ea43-227b-58eea769460c@redhat.com>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180220221511.22861-3-hdegoede@redhat.com>
 <20180221114045.GB8334@sirena.org.uk>
 <361a97ba-4af8-8a99-f092-4c63c5570348@redhat.com>
 <20180222105205.GB5905@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D20D2676AD
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 12:04:05 +0100 (CET)
Received: by mail-wm0-f41.google.com with SMTP id q83so3126512wme.5
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 03:04:05 -0800 (PST)
In-Reply-To: <20180222105205.GB5905@sirena.org.uk>
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
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 22-02-18 11:52, Mark Brown wrote:
> On Wed, Feb 21, 2018 at 08:43:47PM +0100, Hans de Goede wrote:
>> On 21-02-18 12:40, Mark Brown wrote:
> 
>>> This is now only enabling the LDO and bias when the jack is inserted -
>>> is that enough?
> 
>> Yes, we only need to do OVCD on an insertion event to differ between
>> headset vs headphones.
> 
> Is there not a fault protection aspect to this?  The naming and the
> separate control makes this seem like it's got some wider purpose.

That is a good question, my patch series ends up always enabling this
because my testing has shown that it works better (*) when enabled
before the supplies feeding it are enabled, and there is no harm
in leaving it enabled while the supplies are disabled.

This will automatically also give us the fault protection when micbias1
is on because we're actually recording from the mic, rather then that
it is forced on for a short while for the headset vs headphones detection.

So after this series we are good wrt its function for fault protection
too. Note that the datasheet is not clear on if it is really necessary
for this, but I think it makes sense to have this enabled at all times.

Regards,

Hans

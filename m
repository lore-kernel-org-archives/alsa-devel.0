From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/4] conf/ucm: bytcr-rt5651: Enable Stereo?
 ADC MIXL ADC? switches when enabling inputs
Date: Tue, 1 Jan 2019 12:28:52 +0100
Message-ID: <0f5dadc4-dd5e-e9a2-1ff8-ea6bfdd1b8b7@redhat.com>
References: <20181224150504.20845-1-hdegoede@redhat.com>
 <s5h1s5wkc6e.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 5252F267783
 for <alsa-devel@alsa-project.org>; Tue,  1 Jan 2019 12:28:54 +0100 (CET)
Received: by mail-ed1-f65.google.com with SMTP id b14so24041636edt.6
 for <alsa-devel@alsa-project.org>; Tue, 01 Jan 2019 03:28:54 -0800 (PST)
In-Reply-To: <s5h1s5wkc6e.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 01-01-19 09:35, Takashi Iwai wrote:
> On Mon, 24 Dec 2018 16:05:01 +0100,
> Hans de Goede wrote:
>>
>> Explicitly enable the right 'Stereo? ADC MIXL ADC?' when selecting an input,
>> rather then just enabling them all in ucm/codecs/rt5651/EnableSeq.conf .
>>
>> This is a preparation patch for adding digital mic support.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Is this patchset safe to apply now without change in kernel side?
> Just to be sure.

Yes this is safe to apply / use with current (unpatched) kernels.

Regards,

Hans

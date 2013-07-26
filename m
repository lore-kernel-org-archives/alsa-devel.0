From: Felipe Tonello <eu@felipetonello.com>
Subject: Re: [PATCH 1/4] ALSA: Added jack detection kcontrol
	support
Date: Fri, 26 Jul 2013 12:04:17 -0700
Message-ID: <CAGrhNMznQrbCxMs=0pVRDL9ott8kBX15yT9EyyS8zpzq03Fwuw@mail.gmail.com>
References: <1374863133-6745-1-git-send-email-eu@felipetonello.com>
 <1374863133-6745-2-git-send-email-eu@felipetonello.com>
 <20130726184644.GV9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
 [74.125.82.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 13AB2265843
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 21:04:18 +0200 (CEST)
Received: by mail-we0-f176.google.com with SMTP id q56so2206843wes.35
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 12:04:17 -0700 (PDT)
In-Reply-To: <20130726184644.GV9858@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Wang Xingchao <xingchao.wang@linux.intel.com>, linux-kernel@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Fri, Jul 26, 2013 at 11:46 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 26, 2013 at 11:25:30AM -0700, Felipe F. Tonello wrote:
>
>> -     snprintf(kctl->id.name, sizeof(kctl->id.name), "%s Jack", name);
>> +
>> +     strlcpy(kctl->id.name, name, sizeof(kctl->id.name));
>
> This looks like it'd break existing users unless they are updated to
> remove the "Jack" from their calls?

Yes, that's why I appended the " Jack" in snd_jack_new().

>
>>   * @type:  a bitmask of enum snd_jack_type values that can be detected by
>>   *         this jack
>> + * @idx:   index of this control item
>>   * @jjack: Used to provide the allocated jack object to the caller.
>
> "The index of the ALSA control created to represent the jack.

Ok.

Felipe Tonello

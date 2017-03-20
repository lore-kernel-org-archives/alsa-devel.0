From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: pulseaudio fails to start with kernel 4.11,
 caused by new snd_hdmi_lpe_audio module)
Date: Mon, 20 Mar 2017 16:09:22 -0700
Message-ID: <6754b5cd-f6d0-e2e3-0f01-992946ec1b92@linux.intel.com>
References: <2549c113-f06b-f22e-d36e-f59fc2969bcb@redhat.com>
 <s5h8to0w4fs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id F0A03266F51
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 00:09:25 +0100 (CET)
In-Reply-To: <s5h8to0w4fs.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 3/20/17 4:52 AM, Takashi Iwai wrote:
> On Mon, 20 Mar 2017 12:42:58 +0100,
> Hans de Goede wrote:
>>
>> Hi,
>>
>> Lately I've been working on fixing various issues people
>> are having with baytrail / cherrytrail devices. One thing
>> I noticed when moving my testing / development to 4.11 is
>> that pulseaudio does not work (it aborts while starting)
>> this seemed to be caused by the new snd_hdmi_lpe_audio
>> module. If I blacklist that all is fine. Any idea what
>> is causing this ?
>
> I noticed it once, too, but I had no time to check further.
> More interestingly, PA works fine when LPE audio is the single driver
> (i.e. blacklist Intel SST instead), too.  So it's more likely a bug in
> PA.
>
> What happens when you modprobe LPE audio driver after starting the
> session?  If it kills PA, we can debug more easily :)

I've seen this as well, I could get either one of the two but not both, 
could this be due to the fact that one set of mixers is configured with 
UCM and the other driver isn't configured by UCM?

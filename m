From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: channel names
Date: Fri, 08 Feb 2013 14:39:16 +0100
Message-ID: <51150004.7000203@drcomp.erfurt.thur.de>
References: <51141B43.7070108@drcomp.erfurt.thur.de>
 <s5hbobv8fga.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B1072615E5
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2013 14:39:18 +0100 (CET)
In-Reply-To: <s5hbobv8fga.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/08/2013 07:52 AM, Takashi Iwai wrote:

>> Am I missing something or doesn't ALSA support channel names?
>>
>> When dealing with multichannel interfaces, it's pretty inconvenient to
>> remember whether channel 193 is on MADI 3, AES-EBU or phones.
>>
>> We can address this on the jackd level, however, since OSX allows audio
>> drivers to name their channels, I wonder how to do the same with ALSA?
> It's possible to give some information via the new channel map API,

I'm afraid the channel map may not work for pro-audio interfaces. While
consumer devices will surely benefit from a label like

   SNDRV_CHMAP_RRC,        /* rear right center */

professional-grade cards simply don't have such channel names.

Instead, "our" channels have names like

   ADAT 7
   Line 12
   Bus 14L

or however else the vendor decided to call (and physically label) them.

That said, we'd probably end up with plenty of new definitions, and we'd
still need the reverse translation from the enum to a string in
userspace.

(NB: Things are so much easier with FFADO, where devices provide a
name vector of strings that's then exposed to jackd.)

How about struct snd_pcm_channel_info?

struct snd_pcm_channel_info {
        unsigned int channel;
        __kernel_off_t offset;          /* mmap offset */
        unsigned int first;             /* offset to first sample in bits */
        unsigned int step;              /* samples distance in bits */
};


This looks like the natural place for a new struct member

        char name[64];


Maybe there are better places for such an extension, I'm not an ALSA-API
expert.


Do we already agree that verbose strings are useful? At least the Win
and OSX audio guys think so. ;)


Cheers

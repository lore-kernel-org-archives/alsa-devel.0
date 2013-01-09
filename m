From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH 1/1] ALSA: hdspm - Fix wordclock status on
	AES32
Date: Wed, 09 Jan 2013 16:45:27 +0100
Message-ID: <50ED9097.3020004@drcomp.erfurt.thur.de>
References: <1355495521-1445-1-git-send-email-andre.schramm@iosono-sound.com>
 <1357738818-29526-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <s5hwqvmz8ib.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 88F1A26168C
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2013 16:45:28 +0100 (CET)
In-Reply-To: <s5hwqvmz8ib.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Andre Schramm <andre.schramm@iosono-sound.com>
List-Id: alsa-devel@alsa-project.org

On 01/09/2013 04:22 PM, Takashi Iwai wrote:

>> +	wcLock = status & HDSPM_AES32_wcLock;
>> +	wcSync = wcLock && (status & HDSPM_AES32_wcSync);
>> +
>>  	snd_iprintf(buffer, "Word: %s  Frequency: %d\n",
>> -		    (status & HDSPM_AES32_wcLock) ? "Sync   " : "No Lock",
>> +		    (wcLock) ? (wcSync ? "Sync   " : "Lock") : "No Lock",
> 
> I guess you wanted to align the string size by extra spaces after
> "Sync", but forgot after "Lock"?

Wow, good catch. Though it's purely cosmetic, feel free to add the
missing three spaces to please the viewer's eye. ;)

Cheers

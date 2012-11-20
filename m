From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: 100.0% power usage of Device Audio codec (HDA) on
 wake
Date: Tue, 20 Nov 2012 09:56:19 +0100
Message-ID: <50AB45B3.6060904@canonical.com>
References: <af012f839bb665744d02fa1031764767@sourcepole.ch>
 <s5hmwyhh6vg.wl%tiwai@suse.de>
 <c342c478aca9a752935a88b5b5e0d329@sourcepole.ch>
 <s5h1ufsa4aq.wl%tiwai@suse.de>
 <33f3a5d64a489d40499192a0659dd76c@sourcepole.ch>
 <50AB3A39.1090604@canonical.com> <s5hpq38ptc8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 882CF265293
 for <Alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 09:56:22 +0100 (CET)
In-Reply-To: <s5hpq38ptc8.wl%tiwai@suse.de>
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
Cc: Alsa-devel@alsa-project.org, Tomas Pospisek <tpo2@sourcepole.ch>
List-Id: alsa-devel@alsa-project.org

On 11/20/2012 09:32 AM, Takashi Iwai wrote:
> At Tue, 20 Nov 2012 09:07:21 +0100,
> David Henningsson wrote:
>>
>> It does put another question - from where does powertop get its values,
>> and do we have to do anything on our side to make sure / aid them being
>> correct?
>
> powertop checks /sys/class/sound/hwC*D*/power_{off|on}_acct files.
> They contain the time (in ms) how long the codec is in the power-save
> mode.

Thanks. But I have also recently seen a computer where powertop showed a 
Watt number, essentially saying that the codec consumed 1.4 Watts or so 
(I don't remember the exact number). Have you seen that too?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

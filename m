From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: HD-Audio: How to reduce driver initializaton time
 if multiple codecs present on the bus?
Date: Fri, 29 Nov 2013 15:31:59 +0800
Message-ID: <529842EF.8070800@canonical.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F80141EEE6@SHSMSX101.ccr.corp.intel.com>	<52983498.606@canonical.com>
 <s5hmwkng17c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B290426030E
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 08:32:07 +0100 (CET)
In-Reply-To: <s5hmwkng17c.wl%tiwai@suse.de>
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
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2013-11-29 14:40, Takashi Iwai skrev:
> At Fri, 29 Nov 2013 14:30:48 +0800,
> David Henningsson wrote:
>> 2013-11-28 22:57, Lin, Mengdong skrev:
>>> Hi Takashi,
>>>
>>> We're trying to reduce the HD-A driver initialization time when more than one codecs are connected to the bus, but are blocked.
>>> Would you please share some advices on this?
>>>
>>> Usually, there is one HD-A controller connecting to two codecs: one on-board codec and one integrated display codec.
>>> During initialization, the codecs are created and configured in a serial way.
>>>
>>> Creating a codec may cost 6~20ms, and then building controls make cost about 15~30ms.
>> Sorry for interrupting, but I just wonder - I assume you have a maximum
>> of 4 CPUs. Can't the other 3 CPUs be used to load other non-audio
>> hardware in parallel instead? It sounds you're going to run into lock
>> contention instead if you try to modify the same card from two threads
>> simultaneously.
> IIRC, PCI device probes are done sequentially because asynchronous
> probe caused too many troubles.  And if it's a module, it's anyway
> more strictly serialized.

Okay. It just seems to me that from a bird's eye view that parallelizing 
module loading and pci probing would give us much bigger benefits than 
trying to parallellize internally in the snd-hda-intel driver.

Btw, using a deferred azx_probe_continue (like we do if there's a 
firmware file), would one get more parallelization with other drivers? 
If so we could consider making that the default.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

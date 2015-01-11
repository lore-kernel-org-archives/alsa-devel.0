From: David Flater <vger@flaterco.com>
Subject: Re: [PATCHv2 1/2] ALSA: fix emu8000 DRAM sizing for AWE64 Value
Date: Sun, 11 Jan 2015 12:10:06 -0500
Message-ID: <54B2AE6E.3080909@flaterco.com>
References: <54B0775C.1080705@flaterco.com> <s5h7fwt4mji.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h7fwt4mji.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Alsa Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 01/11/2015 05:52 AM, Takashi Iwai wrote:
> At Fri, 09 Jan 2015 19:50:36 -0500,
> David Flater wrote:
>> CT4380 is commonly said to come with 1 MiB of DRAM, but Creative's AWE
>> Control app agreed that mine has only 512 KiB.  It has the same memory chip
>> as the CT4520.
> 
> And you couldn't actually use the 1MB, right?

Confirmed with indirect evidence.  Since the address space wraps around, the mode of failure (assuming that the load isn't blocked by checking against a correctly detected size) is silent corruption of the loaded sound font.

Testing with a random sound font larger than 512 KiB but smaller than 1 MiB:
Fender2.sf2, 545994 B

On CT4390, the following test gives me a credible guitar in the left channel (and nothing else):
asfxload -i -M Fender2.sf2
DRAM memory left = 3565 kB
aplaymidi -p 17:0 E1M1.mid

On CT4380 with DRAM size hard-coded to 1 MiB, asfxload catches no failure but aplaymidi produces a glitchy mixture of guitar and morse code beeping:
asfxload -i -M Fender2.sf2
DRAM memory left = 493 kB
aplaymidi -p 17:0 E1M1.mid

DWF

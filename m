From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [alsa-devel] [PATCH 1/6] hda_intel: Add Lynx Point HD Audio Controller
 DeviceIDs
Date: Tue, 07 Feb 2012 05:51:02 +0100
Message-ID: <4F30ADB6.1000109@canonical.com>
References: <201201231624.31275.seth.heasley@intel.com> <4F1E7DC0.5060208@canonical.com> <s5h7h0h2znx.wl%tiwai@suse.de> <DEC3922D1904474A8862C7BFF516EA9A37FB3863@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DEC3922D1904474A8862C7BFF516EA9A37FB3863@ORSMSX101.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Heasley, Seth" <seth.heasley@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "perex@perex.cz" <perex@perex.cz>, "Ralston, James D" <james.d.ralston@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 02/07/2012 01:13 AM, Heasley, Seth wrote:
>>>> This patch adds the HD Audio DeviceIDs for the Intel Lynx Point PCH.
>>>
>>> Thanks. As we asked for oak trail: can you confirm you prefer DMA
>>> Position buffers for detecting current playback/recording position,
>> over
>>> using the LPIB register?
>>
>> Yes, thanks for the notice.
>>
>> I guess this won't need it since it's the successor of PPT.
>> But it's always good to check it for the new hardware, indeed.
>
> I'm also in favor of not rocking the boat, but I'm curious what changing this would entail, and what would be the advantage or rationale for making the change?

Reading the LPIB register, and reading the DMA position buffer, are two 
different methods of reading the current playback (or recording) 
position, i e which sample is currently being played back.

The problem is that some chipsets prefer one method over the other, i e, 
only one of the methods work reliably. And if the other method only 
breaks occasionally, this can be quite difficult to detect and track 
down - we will have users complaining about their audio sometimes either 
sounding distorted, maybe not working at all, or just once in a while 
glitches. All of these symptoms can have many causes, so deducing that 
to a broken playback position is time consuming. That's why I think it's 
worth the extra question, to get it right from the start.

So...thanks in advance for looking it up for us? :-)

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

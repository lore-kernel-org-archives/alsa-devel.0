From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [alsa-devel] Moving sound/* to drivers/ ?
Date: Thu, 22 May 2008 00:08:03 +0200
Message-ID: <48349D43.8020003@keyaccess.nl>
References: <s5hzlqjz74d.wl%tiwai@suse.de> <alpine.LFD.1.10.0805211431370.3081@woody.linux-foundation.org> <48349AF2.30009@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S937483AbYEUWFn@vger.kernel.org>
In-Reply-To: <48349AF2.30009@keyaccess.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 21-05-08 23:58, Rene Herman wrote:

> On 21-05-08 23:44, Linus Torvalds wrote:
> 
>> So I would personally certainly not mind somebody doing a
>>     git mv sound drivers/sound
>>     .. edit makefiles and Kconfig files appropriately ..
>>     git commit -a
>>
>> and it wouldn't be a problem for git (ie the repository wouldn't grow 
>> or anything like that).
> 
> I'd personally like the net/ structure more. So subsystem code under 
> sound/ and drivers moved to drivers/sound/.

Suggestion for sound/drivers: drivers/sound/generic :-)

Rene.

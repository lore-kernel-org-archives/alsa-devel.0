From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 0/3] Kill the rest snd_print*() usages
Date: Mon, 03 Nov 2014 09:01:11 +0100
Message-ID: <54573647.7030500@canonical.com>
References: <1414514715-569-1-git-send-email-tiwai@suse.de>
 <20141031124536.GA32600@sudip-PC> <s5h38a4w3h0.wl-tiwai@suse.de>
 <20141101131540.GA21362@sudip-PC> <s5hioiyuiyj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 31AFE260473
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 09:01:13 +0100 (CET)
In-Reply-To: <s5hioiyuiyj.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2014-11-02 09:04, Takashi Iwai wrote:
> At Sat, 1 Nov 2014 18:45:40 +0530,
> Sudip Mukherjee wrote:
>>
>> On Fri, Oct 31, 2014 at 06:31:23PM +0100, Takashi Iwai wrote:
>>> At Fri, 31 Oct 2014 18:15:36 +0530,
>>> Sudip Mukherjee wrote:
>>>>
>>>> On Tue, Oct 28, 2014 at 05:45:12PM +0100, Takashi Iwai wrote:
>>>>> Hi,
>>>>>
>>>>> it's a small series to get rid of snd_print*() usages in a few
>>>>> PCI sound drivers.  There remain still a few, I know, but this is
>>>>> just a matter of cleanup, so let them be there...
>>>>
>>>> hi,
>>>> still there is approx. 723 usages of snd_printk (including snd_printk in comments),
>>>> and including 46 in PCI.
>>>> shall i do the cleanups for you ?
>>>
>>> Only you have really free time and gut :)
>>> The problem is rather inconsistencies, i.e. if the same module has a
>>> mix of dev_*() and snd_printk() (or snd_printd()), they should be
>>> replaced as well.  If not mixed, we can leave as is for now.
>>>
>> i am having one doubt. I saw in your patch you have replaced snd_printdd with dev_dbg
>> and snd_printd with dev_info.
>> but when i am checking the macro of snd_printd or snd_printdd , i see that they are also
>> printing the file and line along with the message. snd_printddd is also doing the same thing.
>> then while replacing them with dev_*, the file and line are not required ?
>
> Pretty depends on the situation.  When the printed text is unique, the
> file and the line are mostly superfluous.  If there are multiple
> similar messages, they have to be modified somehow to be easily
> identifiable.

Also, for dev_dbg, I don't think we should add file and line information 
- it is already added with CONFIG_DYNAMIC_DEBUG (if enabled). Adding it 
one more time seems superfluous.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

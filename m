From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] ALSA: usb - fix race in creation of
 M-Audio Fast track pro driver
Date: Mon, 07 Jan 2013 14:06:34 +0100
Message-ID: <50EAC85A.4020905@canonical.com>
References: <1357315338-2843-1-git-send-email-david.henningsson@canonical.com>
 <50E73968.4070703@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CAC72650E5
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2013 14:06:36 +0100 (CET)
In-Reply-To: <50E73968.4070703@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, 1095315@bugs.launchpad.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/04/2013 09:19 PM, Clemens Ladisch wrote:
> David Henningsson wrote:
>> this patch resolves the issue for him. It also leaves a message
>> in the log:
>> "snd-usb-audio: probe of 1-1.1:1.1 failed with error -5"
>
> I'd guess this is for an interface not claimed by the driver but
> without an explicit QUIRK_IGNORE_INTERFACE entry.

My patch causes this error because the quirk fails with an error, which 
is later on turned into a -EIO. Any quirk_ignore_interface entry will 
therefore be ignored. Using the quirk_ignore_interface entry *instead 
of* my patch seems like an interesting option, but...

Looking at the code again, it seems like we have a more generic race 
problem, unless I'm missing something:

  - the same ALSA sound card can contain more than one USB interface.
  - snd_card_register is called whenever a USB interface finishes probing.
  - snd_card_register fires off uevents, causing stuff to happen such as 
volume restore (alsactl) and PulseAudio starts probing the device
  - so when userspace starts accessing the device, the device is not 
fully functional, because not all USB interfaces have yet been probed
  - as a result, volumes might not get restored (if all mixer controls 
do not belong to the first interface), and PulseAudio thinks the device 
is not capable of all the stuff it actually can do (if all pcm streams 
do not belong to the first interface).

I guess this is probably not a problem normally because the kernel is 
faster than userspace, but it is revealed here because switching 
configurations takes longer time than probing another interface.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

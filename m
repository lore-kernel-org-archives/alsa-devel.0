From: Daniel Mack <zonque@gmail.com>
Subject: Re: Regression in sound/usb/
Date: Wed, 11 Jul 2012 17:28:17 +0200
Message-ID: <4FFD9B91.1010402@gmail.com>
References: <CADYPuQ75GAxGyZgiUwygvnQMmDcL9+NMHNo432kg1RYC7vbfQA@mail.gmail.com>
	<4FF18FCF.6020306@gmail.com>
	<CADYPuQ5RFJAaFDpT+4XM-JDWzDO5czVAU3A++_HVHjhN=VBhvQ@mail.gmail.com>
	<s5hvci55l68.wl%tiwai@suse.de>
	<CADYPuQ4Uj8pq9nZOJemY9kZtSrG-WfG4s90b+a00_KteJXU_Sg@mail.gmail.com>
	<s5hr4st5jx1.wl%tiwai@suse.de>
	<CADYPuQ6DT4=NW2tzCLrKYnUHQ6p5qONZjY8PeKq-Z4HAk68tpw@mail.gmail.com>
	<s5hk3yl5ibt.wl%tiwai@suse.de> <s5hhatmjmna.wl%tiwai@suse.de>
	<CADYPuQ7yWpnPSvoVQDV+EyJfC39MDxhP9r5Jiqk_Jh8g65Xd4g@mail.gmail.com>
	<s5h8vey43ve.wl%tiwai@suse.de> <4FFC9B4F.6060600@gmail.com>
	<CADYPuQ6XRSAxKvctCr3FrJ71smk-xOEMF_5VAv-6F5gdM7dwuQ@mail.gmail.com>
	<4FFD39ED.9050706@gmail.com> <4FFD9B29.1020403@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id D13232447C
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2012 17:30:30 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so929291bkc.38
	for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2012 08:28:22 -0700 (PDT)
In-Reply-To: <4FFD9B29.1020403@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Philipp Dreimann <philipp@dreimann.net>
List-Id: alsa-devel@alsa-project.org

On 11.07.2012 17:26, Joseph Salisbury wrote:
> On 07/11/2012 04:31 AM, Daniel Mack wrote:
>> On 11.07.2012 09:30, Philipp Dreimann wrote:
>>> On 10 July 2012 23:14, Daniel Mack <zonque@gmail.com> wrote:
>>>> On 05.07.2012 17:36, Takashi Iwai wrote:
>>>>> At Thu, 5 Jul 2012 17:32:30 +0200,
>>>>> Philipp Dreimann wrote:
>>>>>>
>>>>>> On 5 July 2012 16:41, Takashi Iwai <tiwai@suse.de> wrote:
>>>>>>>> Try the patch below.  If it still doesn't work, give the kernel
>>>>>>>> message again and lsusb -v output, too.
>>>>>>>
>>>>>>> Did it make any difference?
>>>>>>
>>>>>> No, it unfortunately did not.
>>>>>>
>>>>>> lsusb is attached and the parts of the kernel log are in the mail:
>>>>>>
>>>>>> [   41.243211] usb 2-1.2: new high-speed USB device number 3 using ehci_hcd
>>>>>> [   41.605666] uvcvideo: Found UVC 1.00 device <unnamed> (046d:0821)
>>>>>> [   42.002275] input: UVC Camera (046d:0821) as
>>>>>> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.2/input/input12
>>>>>> [   42.085880] usbcore: registered new interface driver snd-usb-audio
>>>>>>
>>>>>> [   52.790139] uvcvideo: Failed to query (GET_DEF) UVC control 2 on
>>>>>> unit 2: -71 (exp. 2).
>>>>>> [   52.794363] uvcvideo: Failed to query (GET_DEF) UVC control 2 on
>>>>>> unit 2: -71 (exp. 2).
>>>>>> [   52.798375] uvcvideo: Failed to query (GET_DEF) UVC control 3 on
>>>>>> unit 2: -71 (exp. 2).
>>>>>> [   52.802499] uvcvideo: Failed to query (GET_DEF) UVC control 7 on
>>>>>> unit 2: -71 (exp. 2).
>>>>>> [   52.806617] uvcvideo: Failed to query (GET_DEF) UVC control 11 on
>>>>>> unit 2: -71 (exp. 1).
>>>>>> [   52.810734] uvcvideo: Failed to query (GET_DEF) UVC control 4 on
>>>>>> unit 2: -71 (exp. 2).
>>>>>> [   52.814855] uvcvideo: Failed to query (GET_DEF) UVC control 5 on
>>>>>> unit 2: -71 (exp. 1).
>>>>>> [   52.818976] uvcvideo: Failed to query (GET_CUR) UVC control 11 on
>>>>>> unit 2: -71 (exp. 1).
>>>>>> [   52.823096] uvcvideo: Failed to query (GET_DEF) UVC control 8 on
>>>>>> unit 2: -71 (exp. 2).
>>>>>> [   52.827215] uvcvideo: Failed to query (GET_DEF) UVC control 1 on
>>>>>> unit 2: -71 (exp. 2).
>>>>>> [   52.831331] uvcvideo: Failed to set UVC probe control : -71 (exp. 26).
>>>>>> [   52.835459] uvcvideo: Failed to set UVC probe control : -71 (exp. 26).
>>>>>> The last line repeats a few times, then the Failed to query block
>>>>>> repeats again, and so on. But only if I try to use the webcam.
>>>>>>
>>>>>> [   82.363599] 3:1:3: cannot set freq 32000 to ep 0x86
>>>>>> Is showing up without using the webcam.
>>>>>
>>>>> Hm, it looks better than before (it was '3:-1:3' or such), but there
>>>>> is still something strange there.
>>>>
>>>> Sorry for the long delay on this. I finally found some time to look into
>>>> this and it seems that I got the calls to usb_set_interface wrong.
>>>> Attached is a patch to fix this - could everybody who is affect please
>>>> give that a quick try? More explanation is in the commit log.
>>>
>>> The camera is now working for a short time:
>>> [   56.421399] usb 2-1.2: new high-speed USB device number 4 using ehci_hcd
>>> [   57.224234] uvcvideo: Found UVC 1.00 device <unnamed> (046d:0821)
>>> [   57.237221] input: UVC Camera (046d:0821) as
>>> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.2/input/input15
>>> Camera and microphone are working. Some time later we're back to the old issue:
>>
>> Ok, I see. Drop this, I'm working on a new one. I will find some time
>> later today to look into this. Thanks for your patience!
>>
>>
>> Daniel
> 
> I just sent an email to Philipp that I've been unable to reproduce the
> failure on my hardware.  However, a user testing your patch has also run
> into the same failure as Philipp:
> 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1018020/comments/38
> 
> That users webcam will work up to 15 minutes, than fail.

I'll pick up an USB hw analyzer later today and then try with a Logitech
camera. Will keep you posted.

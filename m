From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [RFC 2/3 v3]update web addresses in stagging
Date: Sat, 25 Sep 2010 14:30:49 -0700
Message-ID: <4C9E6A09.10007@gmail.com>
References: <1285373337-10945-1-git-send-email-justinmattock@gmail.com>
	<1285373337-10945-2-git-send-email-justinmattock@gmail.com>
	<20100925003406.GA30029@kroah.com> <4C9D47AC.6000002@gmail.com>
	<20100925204736.GD25677@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B60C41037E3
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Sep 2010 23:30:42 +0200 (CEST)
Received: by pzk5 with SMTP id 5so1255354pzk.38
	for <alsa-devel@alsa-project.org>; Sat, 25 Sep 2010 14:30:41 -0700 (PDT)
In-Reply-To: <20100925204736.GD25677@one-eyed-alien.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Greg KH <greg@kroah.com>, trivial@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.
List-Id: alsa-devel@alsa-project.org

On 09/25/2010 01:47 PM, Matthew Dharm wrote:
> On Fri, Sep 24, 2010 at 05:51:56PM -0700, Justin P. Mattock wrote:
>> On 09/24/2010 05:34 PM, Greg KH wrote:
>>> On Fri, Sep 24, 2010 at 05:08:56PM -0700, Justin P. Mattock wrote:
>>>> The below patch, is a simple fix to a broken web address not using a
>>>> period in it's
>>>> name. I'll leave this up to you guys if you want to use it...
>>>>
>>>>   Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
>>>
>>> I'll queue it up, thanks.
>>>
>>> Oh, it's "staging", not "stagging" as you have up there in the Subject:
>>> :)
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>
>> shoot... and I actually changed it from staging to stagging thinking
>> that was correct..(duh)..
>>
>> Anyways alright.. I'll exclude this one if the other sets get finalized.
>
> One random suggestion:  Perhaps you should include a date here?  i.e. "URL
> blah blah blah (as of Sept 2010)"
>
> That way, people have some idea how much they can trust that URL without
> having to dig into the kernel history to see when it was last changed.
>
> Matt
>


well.. as it stand right now doing grep -Re "http" in all the 
directories(minus COPYING/MAINTAINERS) gave me a little over 2000
addresses to check(not so bad, only a few days worth of checking(finding 
the broken address is time consuming)).. so I could go back and do this 
for all of them except the webarchive addresses that are broken(maybe 
put a tag on them saying use_webarchive or something).
then there is the question of how much more bloated will the kernel get 
with such a thing(I'm guessing not much, but then again you never know).

Justin P. Mattock

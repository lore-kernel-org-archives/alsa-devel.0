From: Daniel Mack <zonque@gmail.com>
Subject: Re: USB hardware that supports implicit feedback?
Date: Sun, 18 Nov 2012 18:10:29 +0800
Message-ID: <50A8B415.5010008@gmail.com>
References: <p06240805cccafc72f23b@[192.168.1.36]>
 <alpine.LNX.2.00.1211152158440.2632@xoschi>
 <p06240809cccb09820207@[192.168.1.8]> <50A57933.9070607@gmail.com>
 <p06240807cccb56d116e2@[192.168.1.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FC602615AA
 for <alsa-devel@alsa-project.org>; Sun, 18 Nov 2012 11:11:41 +0100 (CET)
Received: by mail-pa0-f51.google.com with SMTP id fb11so519424pad.38
 for <alsa-devel@alsa-project.org>; Sun, 18 Nov 2012 02:11:40 -0800 (PST)
In-Reply-To: <p06240807cccb56d116e2@[192.168.1.12]>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Griscom <griscom@suitable.com>
Cc: Eldad Zack <eldad@fogrefinery.com>, Alsa Developer <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 16.11.2012 10:39, Daniel Griscom wrote:
> At 7:22 AM +0800 11/16/12, Daniel Mack wrote:
>> Hi Daniel,
>> Hi Elad,
>>
>> On 16.11.2012 05:32, Daniel Griscom wrote:
>>>  At 10:02 PM +0100 11/15/12, Eldad Zack wrote:
>>>>  Hi Daniel,
>>>>
>>>>  On Thu, 15 Nov 2012, Daniel Griscom wrote:
>>>>>   I'm having trouble getting implicit feedback working with my custom
>>>>>   capture/playback USB audio class device, even with the latest kernel. I
>>>>>   presume it's a problem with my device's configuration, but 
>>>>> can't figure out
>>>>>   exactly what the problem is (after a whole lotta investigation).
>>>>
>>>>  What exactly doesn't work?
>>>
>>>  The audio output stream (from the computer to my device) runs at a
>>>  few frames per second higher or lower rate than that of the input
>>>  stream (from my device to the computer). The actual difference seems
>>>  to be stable on a specific machine, but varies greatly between
>>>  machines (I've seen differences from +7fps to -2fps; I presume this
>>>  is due to differences in CPU clock frequencies).
>>
>> So you're saying that this is what you experience after you added code
>> to make the driver use the implicit feedback mechanism? Over which time
>> did you measure this and how exactly? Because frankly, I doubt that -
>> the data rate is purely derived from the number of incoming samples.
> 
> This has been the case for a while; we started work with ALSA 1.0.23, 
> but upgrading to kernel 3.6.6 (with included ALSA code) didn't change 
> anything. We have yet to do any patching of ALSA for this matter.

Well, afaik, ALSA 1.0.23 is what ships with a kernel <= 3.4, and the
code for implicit feedback went in for 3.5.

>> Does your device demand the same number of *bytes* or samples/channel to
>> be sent?
> 
> I'll have to check that.

Let me rephrase the question: does the number of input and output
channels match? Eldad had a patch in his series that should make it work
for both scenarios.

>> The code I wrote for implicit feedback is used by the M-Audio FTU
>> devices,
> 
> So, with an FTU the implicit feedback code works?

Yes, it does for many others.

> What version of 
> kernel/ALSA should I use - the latest?

Yes, always use the latests from git, especially for such relatively new
features.


Daniel

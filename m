From: Jamey Drennan <jamey.drennan@gmail.com>
Subject: Re: VOIP xrun problem
Date: Tue, 23 Oct 2012 15:03:09 -0400
Message-ID: <CAJqUV39FnjsUnBnuAeZ1ROUiEi2kPGLUzX2qs_gg=dFek4pAtA@mail.gmail.com>
References: <CAJqUV39Mg8+Cd_ogFGL1vjagwpmBYCC+avWkQaBtPpQz0zZkTg@mail.gmail.com>
 <5085B04E.8040507@faberman.de>
 <CAJqUV39RZ6SB4OQmn5oF61P2=NNxvs9yzPzAtY8fqP7Y1yVjgA@mail.gmail.com>
 <50863AB0.9040004@ladisch.de>
 <CAJqUV3_pp0upB_fV_TzK7PTJYQTatU=uGbgWG8cC899RBHXxqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C8702265163
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2012 21:03:10 +0200 (CEST)
Received: by mail-vb0-f51.google.com with SMTP id fn1so4323617vbb.38
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2012 12:03:10 -0700 (PDT)
In-Reply-To: <CAJqUV3_pp0upB_fV_TzK7PTJYQTatU=uGbgWG8cC899RBHXxqw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 23, 2012 at 11:00 AM, Jamey Drennan <jamey.drennan@gmail.com>wrote:

> On Tue, Oct 23, 2012 at 2:35 AM, Clemens Ladisch <clemens@ladisch.de>wrote:
>
>> (quoting fixed; please don't top-post)
>> Jamey Drennan wrote:
>> > On Mon, Oct 22, 2012 at 4:45 PM, Florian Faber <faber@faberman.de>
>> wrote:
>> >> How do you synchronize the streams? You will either have to synchronize
>> >> the media clocks or do some sort of SRC.
>> >
>> > Maybe I don't quite understand your question but I use RTP (oRTP
>> library)
>> > to manage the sending/receiving of the audio streams.
>>
>> So the RTP stream is synchronized to the sender's clock.
>> How do you handle the differences between the stream's clock and
>> the playback device's clock?
>>
>>
>> Regards,
>> Clemens
>>
>
> The client and server negotiate the connection parameters including packet
> interval, size, audio format, and rate.  The rtp library ensures that the
> packets arrive on time and accounts for initial time differences.  Maybe
> the timestamps of the stream packets aren't enough to keep the two clocks
> synchronized(or a frame is the same regardless if the two devices are set
> up the same)?  In testing, the two clocks are one and the same since I am
> running the client and server on the same device.


> So the problem shows up even when testing?

Yes the problem is occurring in testing as well.
An interesting fix of sorts that I just found is, if I adjust my playback
function to play slightly less than a whole packet, the playback function
gets called twice and the underrun goes away.  This makes sense in a way
because now I'm essentially giving the ring buffer twice the amount of data
than it was getting before.  The odd thing is there are no noticeable sound
artifacts like echoing or fuzz as I would expect.
I agree that is definitely a timing/clock issue and I appreciate the help.

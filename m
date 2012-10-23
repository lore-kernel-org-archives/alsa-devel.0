From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: VOIP xrun problem
Date: Tue, 23 Oct 2012 08:35:28 +0200
Message-ID: <50863AB0.9040004@ladisch.de>
References: <CAJqUV39Mg8+Cd_ogFGL1vjagwpmBYCC+avWkQaBtPpQz0zZkTg@mail.gmail.com>
 <5085B04E.8040507@faberman.de>
 <CAJqUV39RZ6SB4OQmn5oF61P2=NNxvs9yzPzAtY8fqP7Y1yVjgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 68A9B261714
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2012 08:35:32 +0200 (CEST)
In-Reply-To: <CAJqUV39RZ6SB4OQmn5oF61P2=NNxvs9yzPzAtY8fqP7Y1yVjgA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jamey Drennan <jamey.drennan@gmail.com>
Cc: Florian Faber <faber@faberman.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

(quoting fixed; please don't top-post)
Jamey Drennan wrote:
> On Mon, Oct 22, 2012 at 4:45 PM, Florian Faber <faber@faberman.de> wrote:
>> How do you synchronize the streams? You will either have to synchronize
>> the media clocks or do some sort of SRC.
>
> Maybe I don't quite understand your question but I use RTP (oRTP library)
> to manage the sending/receiving of the audio streams.

So the RTP stream is synchronized to the sender's clock.
How do you handle the differences between the stream's clock and
the playback device's clock?


Regards,
Clemens

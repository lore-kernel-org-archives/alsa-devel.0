From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: sending a sequencer event to a delayed queue
Date: Wed, 14 Mar 2012 22:36:26 +0100
Message-ID: <4F610F5A.6060504@ladisch.de>
References: <alpine.DEB.2.00.1203101859280.16157@anubis.informatik.uni-halle.de>
	<4F5BBECF.8020506@ladisch.de>
	<4F5CC7AB.3030300@henning-thielemann.de>
	<4F5D0DC5.7090908@ladisch.de>
	<alpine.DEB.2.00.1203112200370.12766@anubis.informatik.uni-halle.de>
	<4F5DB1FA.9030802@ladisch.de>
	<alpine.DEB.2.00.1203142046430.26232@anubis.informatik.uni-halle.de>
	<alpine.DEB.2.00.1203142118210.26232@anubis.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A264A10458D
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 22:37:12 +0100 (CET)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EDF8220C56
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 17:37:10 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1203142118210.26232@anubis.informatik.uni-halle.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Henning Thielemann <alsa@henning-thielemann.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Henning Thielemann wrote:
> On Wed, 14 Mar 2012, Henning Thielemann wrote:
>> output note-on event with timestamp 1s
>> output note-off event with timestamp 2s
>> control_queue SND_SEQ_EVENT_SETPOS_TIME 3s
>> drain
>>
>> Nothing happens.

To get events to be dispatched, you need a timer tick, i.e., you
have to make the timer run again.

>> I continue the queue after increasing the time:
>>
>> output note-on event with timestamp 1s
>> output note-off event with timestamp 2s
>> control_queue SND_SEQ_EVENT_SETPOS_TIME 3s
>> control_queue SND_SEQ_EVENT_CONTINUE
>> drain
>>
>> Now the note events are scheduled at 1s and 2s as if the SETPOS_TIME control was ignored.
>
> Queue time is some microseconds larger than 0.
>
>
> That is, SETPOS_TIME seems to successfully alter the time, but then CONTINUE seems to reset the time. Is this a bug or a feature?

CONTINUE behaves like START if the timer hasn't run yet.


Regards,
Clemens

From: Henning Thielemann <alsa@henning-thielemann.de>
Subject: Re: how to handle buffer underrun in a softsynth
Date: Tue, 29 Nov 2011 09:39:08 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1111290913010.27304@anubis.informatik.uni-halle.de>
References: <alpine.DEB.2.00.1111281636560.13399@anubis.informatik.uni-halle.de>
	<4ED3EC1C.70100@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_gpjBKlhU52Y3TtKG9F0GSg)"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgate5.urz.uni-halle.de (mailgate5.urz.uni-halle.de
	[141.48.3.10]) by alsa0.perex.cz (Postfix) with ESMTP id CE47B103835
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 09:39:10 +0100 (CET)
Received: from mserv3.urz.uni-halle.de ([141.48.3.161])
	by mlucom18.urz.uni-halle.de with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.77) id 1RVJDa-0002Nb-3R for <alsa-devel@alsa-project.org>
	; Tue, 29 Nov 2011 09:39:10 +0100
Received: from hermes.informatik.uni-halle.de ([141.48.9.46])
	by mail.uni-halle.de
	(Sun Java(tm) System Messaging Server 6.3-15.01 (built Mar 21 2011;
	32bit)) with ESMTP id <0LVE004WNYP8RM50@mail.uni-halle.de> for
	alsa-devel@alsa-project.org; Tue, 29 Nov 2011 09:39:08 +0100 (CET)
Received: from anubis.informatik.uni-halle.de
	(anubis.informatik.uni-halle.de [141.48.165.107])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)	by hermes.informatik.uni-halle.de
	(Postfix)
	with ESMTPS id 3BD2A4E3256E	for <alsa-devel@alsa-project.org>; Tue,
	29 Nov 2011 09:39:08 +0100 (CET)
In-reply-to: <4ED3EC1C.70100@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_gpjBKlhU52Y3TtKG9F0GSg)
Content-type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-transfer-encoding: QUOTED-PRINTABLE


On Mon, 28 Nov 2011, Clemens Ladisch wrote:

> Henning Thielemann wrote:
>> I have written a software synthesizer in Haskell that fetches MIDI=
 events
>> from ALSA sequencer and plays the rendered signal via ALSA pcm. Ho=
wever it
>> cannot cope correctly with buffer underruns.
>> ...
>>   Now when I detect a buffer underrun on writing a block to an ALS=
A pcm
>> sink, I like to know the time gap in order to adjust the timestamp=
s of the
>> incoming MIDI events.
>
> The sample clock is usually not synchronized with any other clock, =
so
> you won't be able to get a very exact measurement.

That's something I worry about, too. However I must somehow map times=
tamps=20
of ALSA sequencer events to sample counts in order to let notes start=
=20
within a sample block. JACK claims to synchronize everything and it r=
uns=20
on top of ALSA - how does it manage synchronization between MIDI and =
PCM?


> However, there is a different way to approach this problem: just di=
sable
> underruns.  :)  Set the stop_threshold to the same value as the bou=
ndary,
> and ALSA will no longer stop the device when an underrun happens.=
=B9  This
> means that you'll have to write some data more quickly than normall=
y to
> catch up=B2, but the overall timing of the samples will not be affe=
cted.

Ok, I am still uncertain whether this solves my problem. I think abou=
t how=20
I can decrease processor load if I detect a buffer underrun. My idea =
was=20
the following: Say, I have a blocksize of 10ms and got some events A,=
 B,=20
C, ... from the ALSA sequencer:

  1ms: A, 7ms: B, 13ms: C, 19ms: D, 25ms: E, 31ms: F

Now, when I encounter a buffer underrun, I want instead to render=
=20
according to:

  1ms: A, 7ms: B, 10ms: C, 10ms: D, 15ms: E, 21ms: F

and play a 10ms pause at timestamp 10ms. That is I do not want to dro=
p=20
events (this might introduce inconsistencies) but I could save render=
ing a=20
block and this way catch up with the emission of sample blocks.
  How can I detect a buffer underrun when I disabled underrun detecti=
on?



Regards,
Henning


--Boundary_(ID_gpjBKlhU52Y3TtKG9F0GSg)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary_(ID_gpjBKlhU52Y3TtKG9F0GSg)--

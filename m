From: Tobias Schneider <tobsnyder@gmx.de>
Subject: Re: Alsa-devel Digest, Vol 40, Issue 58
Date: Sun, 13 Jun 2010 12:47:49 +0200
Message-ID: <20100613104829.137E1243B1@alsa0.perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 137E1243B1
	for <alsa-devel@alsa-project.org>;
	Sun, 13 Jun 2010 12:48:29 +0200 (CEST)
content-class: 
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



----- Urspr=FCngliche Nachricht -----
Von: alsa-devel-request@alsa-project.org
Gesendet: Sonntag, 13. Juni 2010 12:00
An: alsa-devel@alsa-project.org
Betreff: Alsa-devel Digest, Vol 40, Issue 58

Send Alsa-devel mailing list submissions to
	alsa-devel@alsa-project.org

To subscribe or unsubscribe via the World Wide Web, visit
	http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
or, via email, send a message with subject or body 'help' to
	alsa-devel-request@alsa-project.org

You can reach the person managing the list at
	alsa-devel-owner@alsa-project.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Alsa-devel digest..."


Today's Topics:

   1. Re: ALSA's jack reporting framework map to Android framework
      (Mark Brown)
   2. Re: [PATCH] ASoC: Remove unused header (Mark Brown)
   3. Re: Timing Info (Paul Dugas)


----------------------------------------------------------------------

Message: 1
Date: Sat, 12 Jun 2010 18:05:52 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] ALSA's jack reporting framework map to
	Android framework
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,	Mike
	Lockwood <lockwood@android.com>
Message-ID: <20100612170552.GA3110@sirena.org.uk>
Content-Type: text/plain; charset=3Dus-ascii

On Sat, Jun 12, 2010 at 09:28:34AM +0530, Harsha, Priya wrote:

Please fix your MUA to word wrap your messages, it makes them more
legible and easier to reply to.

> The ALSA's jack reporting framework reports jacks at
> /dev/input/eventx. But the Android framework expects the jack reporting
> to be done in /sys/.../switch/h2w.

That ... is simply 'class' - the Android kernel includes a new sysfs
class for switches, CCing in Mike Lockwood who wrote it in case he's got
any input from the Android side.

> Any suggestions as to how  the ALSA's jack reporting framework to
> Android framework? Are there any audio  drivers that have mapped this?

The obvious thing to do here seems to be to update the Android framework
to be able to use the standard kernel interfaces.  I obviously can't
speak for Google but it seems like the sort of patch they'd be willing
to accept, especially if you retain the ability to use the non-standard
extensions that are currently being used.

I guess an alternative would be to have the Android kernels add an
adaptor in the input subsystem (for various reasons not all jack sense
goes through ALSA) so that input subsystem switches get represented via
the Android switch ABI, though that would increase the amount of out of
tree code that needs to be carried and so seems like the wrong direction
to be heading.


------------------------------

Message: 2
Date: Sat, 12 Jun 2010 18:07:15 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Remove unused header
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>, Herb Peyerl
	<hpeyerl@beer.org>,	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Message-ID: <20100612170715.GB3110@sirena.org.uk>
Content-Type: text/plain; charset=3Dus-ascii

On Fri, Jun 11, 2010 at 10:50:40AM +0100, Liam Girdwood wrote:
> On Thu, 2010-06-10 at 17:54 -0600, Grant Likely wrote:
> > The header contains an extern that isn't used by anything.  Remove.

> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Applied, thanks.


------------------------------

Message: 3
Date: Sat, 12 Jun 2010 17:59:27 -0400
From: Paul Dugas <paul@dugasenterprises.com>
Subject: Re: [alsa-devel] Timing Info
To: alsa-devel@alsa-project.org
Message-ID:
	<AANLkTik3ycq3POxHRG_bc0jO-KByZVvirVJ-X9-bySY_@mail.gmail.com>
Content-Type: text/plain; charset=3DUTF-8

On Fri, Jun 11, 2010 at 6:00 PM, Paul Dugas <paul@dugasenterprises.com> wro=
te:
> I'm using snd_pcm_readi() to collect samples and am wondering if/how I
> can get accurate timestamps for them. ?Seems like the snd_pcm_status()
> gives me this info but I'm unclear on the specifics. ?Can someone
> point me toward the correct field in the status structure that I
> should be using and what sample that timestamp corresponds to?
>
> Does snd_pcm_status_get_tstamp() get me the timestamp for the first
> frame returned by the next snd_pcm_readi() call?

I know now get_tstamp() isn't what I'm looking for after reading some
prior postings and other web sites.  Can't seem to find a discussion
of timing in the ALSA docs themselves.  Maybe I'm being dense.

Looks like some processing of the trigger timestamp is what I need but
I'm not following the logic of "triggers" in the simple use of
snd_pcm_readi() that I've got.  Before the first readi() call, the
trigger time is 0.  The second time, it's pretty close to the wall
time for the first call.  Perhaps that's the timestamp of the first
sample of the first period I read and I need to add the period_time
each time?  Seems like that'd accrue error when recording over longer
periods of time (which my application does).

What's the "timestamp mode".  Does it generate a timestamp each
period?  How would I access that timestamp?

Thanks in advance for any assistance,

Paul


------------------------------

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


End of Alsa-devel Digest, Vol 40, Issue 58
******************************************

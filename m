From: "John L. Utz III" <john.utz@dmx.com>
Subject: Re: Where is simple mixer control "Surround" defined
 for ac97 or via82xx? I cant find it anywhere in ac97....
Date: Fri, 10 Aug 2007 11:48:17 -0700
Message-ID: <20070810114817.4f580733@jutz-fc6.na.corp.dmxmusic.com>
References: <20070808150429.45d1abef@jutz-fc6.na.corp.dmxmusic.com>
	<1186731226.23948.1204693671@webmail.messagingengine.com>
	<20070810105626.2e8a7166@jutz-fc6.na.corp.dmxmusic.com>
	<75b66ecd0708101104k46b978e5ra46594d65f02a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id C1D7324374
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 20:43:30 +0200 (CEST)
In-Reply-To: <75b66ecd0708101104k46b978e5ra46594d65f02a3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Lee;

tnx for the absolutely reasonable question!

On Fri, 10 Aug 2007 14:04:10 -0400
"Lee Revell" <rlrevell@joe-job.com> wrote:

> On 8/10/07, John L. Utz III <john.utz@dmx.com> wrote:
> > It does, i think that i'll try to use snd_ac97_rename_vol_ctl() in
> > patch_vt1618() to make Surround the Rear control.
> >
> > Hopefully, i'll have a usable patch to submit for vt1618 next week,
> > woohoo!
> 
> Why do you want to rename Surround to Rear?  It would cause people's
> mixer settings to be lost.

As of right now, i actually don't! :-)

I did up until about 15 minutes ago tho!

It wasn't my intent to change it generally, i only wanted to change it
for the 1618.

Peoples mixer settings wouldn't be lost, because the VIA1618 is
currently near unusable under ALSA.

Thus i receive regular pings from random linux loving 1618 owning
netizens along the lines of:

 'where's that patch john?'
 'how soon will it be done?' 

:-)

So, the reason for me to want to change it was to make it just like
the CMI8738-MC6 Rear Output Softvol that i have created.

That turns out to be a stupid idea, because CMI8738-MC6 is the thing
that's not in sync with the current thought on how multichannel audio
is laid out. :-)

So i will rename that CMI8738 softvol to be Surround Playback Volume
instead of Rear Playback Volume and send in a patch shortly.

The reason for all this brain-churn is that i have to make our
product work with both the CMI8738-MC6 and the VT1618.

Because the CMI8738-MC6 is what we have on zillions of existing product
in the field and the VT1618 is what's currently available.

Keeping up with audio chipset EOL's while maintaining 100% product
compatibility with 7 year old product that is *still* in the field is
why i have a job :-)

> Lee
> 

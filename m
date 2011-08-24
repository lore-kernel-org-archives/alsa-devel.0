From: Daniel Mack <zonque@gmail.com>
Subject: Re: M-Audio FTU remaining mixer controls and external
 clocking support.
Date: Wed, 24 Aug 2011 20:23:21 +0200
Message-ID: <CACTFLAMJ3N6R7ya+B+i4H_fLbeFir8+nuD40JViWfg5oDAr3aw@mail.gmail.com>
References: <CAE-xCyMB3vRYkCRwy2gskn=+V5vm9ghnnL4qG_G4MFwnhUtYXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id 097A82435E
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 20:23:22 +0200 (CEST)
Received: by pzk1 with SMTP id 1so1215176pzk.2
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2011 11:23:21 -0700 (PDT)
In-Reply-To: <CAE-xCyMB3vRYkCRwy2gskn=+V5vm9ghnnL4qG_G4MFwnhUtYXA@mail.gmail.com>
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
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, Grant Diffey <gdiffey@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 20, 2011 at 10:52 AM, Aur=E9lien Leblond <blablack@gmail.com> w=
rote:
>>Yes, sorry for this taking longer than expected. I've been working on
>>this for a while and will continue doing so next week. I just got too
>>much things to do in parallel these days. I'll get back to you once I
>>can show patches for testing.
>
> That's a great news, I'm ready any time for testing!

So, I've been working on this more or less full-time for a couple of
days now and so it's time for an update. Also, I would like to have
some oppinions before I continue.

I thought a lot about how this can be solved and what I come up with
now is a rather intrusive patch that re-writes the entire streaming
logic of the driver.

First tests show that this approach works quite well, and I actually
also like the new implementation better than the old one. Let me try
and explain the idea.

First off, I moved a bunch of code between the files to have a clearer
picture about which logic resides where. So in particular

- stream.c does the substream setup
- pcm.c cares for everything that is related to pcm (no more
cross-linking between pcm.c and urb.c)
- urb.c was replaced by endpoint.c which holds the logic about
everything that is related to an endpoint

So this last point is actually the major news here. The idea is to
have an entity that knows about an endpoint, which can either carry
audio data or sync data. It knows about its urbs and tracks them, and
is responsible for killing them again eventually. It can have links
(function pointers) to talk to an pcm stream to either let the pcm
logic fill in audio material to urbs (playback case) or lets it parse
audio material from urbs (capture case). It also implements a
refcounting, so an endpoint that is already in use as implicit data
feedback source can be re-used as record source for pcm streams
easily. The first user will start the stream, and only the last one
will tear it down.

So this is the cleanest de-coupling I actually think of right now, but
others might disagree. Hence, I would like to hear some oppinions
about this massive patch. I have a split version of it, but the major
part too intrusive to be split up nicely (at least without added tons
of API-compat code for the transition).

I tested this with an "usual" USB device that features a sync endpoint
as well as with the FTU.

For the FTU, we seem to have another problem which is that the two
endpoints are put into two different interfaces. That causes the code
to call usb_set_interface() once the record stream is opened, and in
case the playback stream is already active, it will stop streaming due
to usb_submit_urb() returning -ENOENT. It's probably easy to fix - any
ideas?

I put the patch online here:

  https://gist.github.com/1168715


Daniel

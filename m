From: "Jack O'Quin" <joq@io.com>
Subject: Re: Driver(s) for IEEE 1394 based break out boxes
Date: 13 Jul 2004 12:26:09 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87u0wbzumm.fsf@sulphur.joq.us>
References: <20040712191930.GA20382@vis.ethz.ch>
	<s5hr7rfamgt.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sulphur.joq.us (mail.joq.us [67.65.12.105])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6614522A
	for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2004 19:26:06 +0200 (MEST)
In-Reply-To: <s5hr7rfamgt.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel Wagner <wagi@vis.ethz.ch>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> At Mon, 12 Jul 2004 21:19:30 +0200,
> Daniel Wagner wrote:
> > 
> > On the on hand, there exists already the IEEE 1394 stack with IEC
> > 61883 support in user-land.  I don't know if the libiec61883 is already
> > ready to use but still it exists.  As I understand the general idea
> > behind libraw1394 and libiec61883 is to do as much as possible in
> > users-pace.  Any application which wants to take advantage of IEEE 1394
> > based sound cards has to use those libraries.  I guess it means for
> > jack to have a new backend in order to use those cards.  But most
> > application wont be aware of this interface, I suppose.

Takashi Iwai <tiwai@suse.de> writes:
> IIRC, JACK has already a driver for IEC61883.
> Don't know whether it really works, though.

Bob Ham wrote an experimental IEC61883 driver which has been part of
JACK CVS for quite a while.  I doubt it's getting much use.

I don't know if it works either, having no hardware to test it.

> > The question is which way to go?  Get the break out boxes working with
> > the existing libraries or write an ALSA driver which implements those
> > parts again?  Personaly, I think ALSA might be the better idea but it
> > does not make use of the already written code.  Maybe there exists a
> > better way...
> 
> The user-space driver can be implemented on alsa-lib as a plugin.
> For example, you can find ALSA <-> JACK transparent layer.

An ALSA solution would be great, either user- or kernel-space.
-- 
  joq


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

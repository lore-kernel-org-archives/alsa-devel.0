From: michael@cadilhac.name (=?iso-8859-1?Q?Micha=EBl?= Cadilhac)
Subject: Re: Getting pcm_usb_stream plugin to know its
	limits.	[Kind of SOLVED]
Date: Wed, 10 Feb 2010 17:56:26 -0500
Message-ID: <yvzghbpor97p.fsf@cadilhac.name>
References: <87ljgkuzdl.fsf@cadilhac.name> <87eimbvkxg.fsf@cadilhac.name>
	<87aawzviyd.fsf_-_@cadilhac.name> <87y6kdz0yo.fsf@cadilhac.name>
	<yvzgiqb8fq1k.fsf@cadilhac.name> <s5hockz646u.wl%tiwai@suse.de>
	<87636gw6pl.fsf@cadilhac.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mercure.iro.umontreal.ca (mercure.iro.umontreal.ca
	[132.204.24.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EF0A10382B
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 23:56:53 +0100 (CET)
In-Reply-To: <87636gw6pl.fsf@cadilhac.name> (=?iso-8859-1?Q?=22Micha=EBl?=
	Cadilhac"'s message of "Tue, 02 Feb 2010 00:24:22 -0500")
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

michael@cadilhac.name (Micha=EBl Cadilhac) writes:

> Takashi Iwai <tiwai@suse.de> writes:
>
>> At Mon, 11 Jan 2010 13:35:19 -0500,
>> Micha=EBl Cadilhac wrote:
>>> =

>>> michael@cadilhac.name (Micha=EBl Cadilhac) writes:
>>> =

>>> > michael@cadilhac.name (Micha=EBl Cadilhac) writes:
>>> >
>>> >> So, my final saying is the following patch.  It fixes the segfault on
>>> >> stopping a non-started usb_stream, plus it adds the ability to set a
>>> >> period size and sound rate.  The latter offers a workaround for the
>>> >> second issue I came with (that the default values for period bytes, =
and
>>> >> hence period size, were too high for us122l to work).
>>> >
>>> > Any comment on that patch would be greatly appreciated.  I'm just
>>> > wondering if it's safe for me to give it to some people.
>>> =

>>> Anyone?  Note that this also fixes a real bug, so it might be of
>>> interest to include it in the trunk.
>>
>> Through a quick glance, the patch looks OK to me.
>> Could you give a proper subject and changelog to merge your patch
>> to git tree?
>
> Hi there Takashi, and sorry for the delay.  Here are the patch,
> subdivised in two distinct logical changes.  I hope the format is what
> you asked for.

Pinging.  IIUC, I forgot to include "subject" lines.  The first one
should be "usb_stream: Check for NULL-ness before dereferencing", and the
second one "usb_stream: Allow user-set period-size and rate.".

-- =

Micha=EBl `Micha' Cadilhac (LITQ, U. de Montr=E9al) -- http://michael.cadil=
hac.name
	|| Perhaps we should start making protest releases
	||  before doing a fall release.
	||         -- David Kastrup

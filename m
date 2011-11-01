From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: Re: [PATCH 0/5] RFC for snd-usb: rework usb endpoint
	logic
Date: Tue, 1 Nov 2011 08:50:39 +0000
Message-ID: <CAE-xCyPKy2JTXPPDLsn99YWa1D5XUtjzUX2PxjQ8VvH-h=7Fpw@mail.gmail.com>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
	<4EAE96BC.6060605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B02B2413A
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 09:50:39 +0100 (CET)
Received: by vcbfl13 with SMTP id fl13so6004007vcb.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Nov 2011 01:50:39 -0700 (PDT)
In-Reply-To: <4EAE96BC.6060605@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

Brilliant!

I have a question though, related to how you guys in Alsa work and
what processes you follow.

Are you looking for testers already?

Or more for some kind of approval first from some other Alsa gurus to
get the code accepted?

Aur=E9lien

On Mon, Oct 31, 2011 at 12:38 PM, Daniel Mack <zonque@gmail.com> wrote:
> On 10/31/2011 01:10 PM, Daniel Mack wrote:
>>
>> I didn't sign-off the patches on purpose, as I would really like to
>> get them reviewed before they go in. Can people have a look and state
>> whether the whole idea is at all sane?
>
> To briefly state the idea as such: the new implementation defines a model
> (snd_usb_endpoint) that handles everything that is related to an USB
> endpoint and its streaming. There are functions to activate and deactivate
> an endpoint (which call usb_set_interface()), and to start and stop its
> URBs. It also has function pointers to be called when data was received or
> is about to be sent, and pointer to a sync slave (another snd_usb_endpoin=
t)
> that is informed when data has been received. A snd_usb_endpoint knows ab=
out
> its state and implements a refcounting, so only the first user will actua=
lly
> start the URBs and only the last one to stop it will tear them down again.
>
> With this sort of abstraction, the actual streaming is decoupled from the
> pcm handling, which makes the "implicit feedback" mechanisms easy to
> implement. All the code that actually handles the payload of a stream's
> packets is now implemented in pcm.c, which is were it belongs to.
>
> But I'm sure there are some unresolved corner cases which need attention.
>
>
> Daniel
>

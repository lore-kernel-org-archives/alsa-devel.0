From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Query devices in a non-blocking fashion
Date: Mon, 08 Dec 2003 18:43:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprzvh60rmq1sf88@mail.broadpark.no>
References: <oprztqwoi4q1sf88@mail.broadpark.no> <200312071919.hB7JJTNk004757@oud.linuxaudiosystems.com> <20031208161936.310df2cb.pochini@shiny.it> <oprzvc5mu3q1sf88@mail.broadpark.no> <Pine.LNX.4.58.0312081745340.20863@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0312081745340.20863@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 8 Dec 2003 17:57:03 +0100 (CET), Jaroslav Kysela <perex@suse.cz>=20
wrote:

> On Mon, 8 Dec 2003, Arve Knudsen wrote:
>
>> Wether its done via the control or pcm interface, it'd be good to have=
 a
>> loose coupling between configuration and streams, so one could could=20
>> access
>> configuration space without locking a stream don't you think? I mean,
>> with ASIO, from what I can see there is no problem obtaining info abou=
t
>> devices in the system even if they might be in use. Shouldn't we at=20
>> least
>> aim for the same flexibility with ALSA?
>
> I was thinking about this issue whole day and it seems to me that you=20
> need
> only a list of available devices (including used ones). Ok, it can be=20
> done
> now using the control interface for hw devices, but we missing a way fo=
r
> the abstract names. Yes, there is a gap in our API and we can fix it.
Only device names? Like I said, I would like to be able to describe any
device in the system (I already obtain the names of all hw devices,
available or not). I don't see any real reason why this shouldn't be
doable. This is handled smoothly with other driver models from what I can
see? What do you mean by abstract names by the way, software devices?

> The second question is, if we want to give you more information about
> devices than an unique name (and perhaps description). My feeling is th=
at
> you're aware what you have in your computer (and I hope, we will develo=
p
> configuration tools which makes the configuration of alsa-lib devices=20
> more
> comfortable in future).
I don't think we should assume the user knows which devices are in the
computer, and leave it at that. In my opinion the application should be
simply able to obtain and present information in a generic manner, if
the user wants to specify parameters explicitly, hey why not. Why should
this information not be made available (so it can be presented
graphically for instance)? By the way, I'm not asking for more than what
is already available in ALSA-lib (except I want it readable without
locking a stream)?? I think Paul's idea of separating configuration from
opening of a stream sounds appealing by the way, although I lack the
insight to really comment on this.

> Also, alsa-lib's flexibility allows us to accept
> almost any stream with the global - system wide - optimizations on our
> side. We don't want to let probing from the application side. This way
> is not very good. The application should choose (or maybe an user of
> this application should choose) the best communication (stream=20
> parameters)
> used for the HAL layer (in our case alsa-lib).
I'm not sure if I totally understand what you mean, most streams are
constrained when it comes to configuration (unless its a software device
which accepts anything). We're not trying to automagically configure ALSA
devices, but simply infer such info as reasonable default samplerate etc.
(and the number of min/max channels of course). Like ive written this
plugin for a mediaplayer which allows the user to choose between individu=
al
output stereo pairs of available devices, and stores this among=20
preferences.
This is made difficult by possibly not being able to query devices, unles=
s
I wish to block during the initialization phase.

Regards

Arve Knudsen


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

From: "Aldrin Martoq" <amartoq@dcc.uchile.cl>
Subject: Re: ALSA C++ API updated for 1.0.16
Date: Fri, 29 Feb 2008 02:57:41 -0300
Message-ID: <17eedd8a0802282157s71029c22md53b4ecbe621b39@mail.gmail.com>
References: <47C30EDE.8000400@trn.iki.fi> <47C3E387.20800@ladisch.de>
	<47C44559.6090404@trn.iki.fi> <47C54E75.7050705@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B50E246BB
	for <alsa-devel@alsa-project.org>; Fri, 29 Feb 2008 06:57:43 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 25so4836772wfa.23
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2008 21:57:42 -0800 (PST)
In-Reply-To: <47C54E75.7050705@ladisch.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic@trn.iki.fi>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 27, 2008 at 8:50 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Lasse K=E4rkk=E4inen wrote:
>  > > > error(std::string const& function, int err): std::runtime_error("A=
LSA " + function + " failed: " + std::string(snd_strerror(err))), err(err) =
{}
>  > > I'm not sure that including the function name and all parameters as =
they
>  > > appear in the source file in the error message is a good idea; I
>  > > wouldn't want to impose this policy on all applications using this
>  > > header.
>  > It is just an exception thrown, the program may catch it and display
>  > another error message. The original ALSA error code is also included
>  > within it.
>  I'm just objecting to the fact that the function name and ALSA's error
>  string are combined into a string that cannot easily be parsed later.

Many of those strings are not meant to be parsed, they are for human
review (developer/user).


>  > In practice the function name seems to be quite essential for debuggin=
g,
>  > as EPIPE or some other of the standard error codes will tell little or
>  > nothing.
>  Agreed.

I would prefer that the method from the C++ API should appear instead
of the internal C API function. The C++ developer is calling the
constructor of alsa::pcm, not snd_pcm_open().

>  > For completeness, I think that it might be desirable to also store the
>  > function name separately (like the code is stored), but can anyone see
>  > any actual use for this?
>  I'd like to have only the snd_strerror() result as the message.  In this
>  case, the function name has to be stored separately if it is needed.

I've found the snd_strerror() messages are quite unusable, at least
for the alsaseq api... they return something like 'file not found'
which seems more related to the internal implementation rather that an
actual alsa-related error...

>  > > > pcm(char const* device =3D "default", snd_pcm_stream_t stream =3D =
SND_PCM_STREAM_PLAYBACK, int mode =3D 0) {
>  > > This looks too much like a default constructor.  I think neither dev=
ice
>  > > nor stream should have a default value.
>  > Well, it is a default constructor. One design goal was to make this
>  > wrapper as easy to use as possible, and choosing sensible defaults for
>  > that is helpful.
>  While playback will be used more often, I think the difference between
>  playback and capture is so big that we cannot make one of them the
>  default.

Me too.

[...]

>  > > > ALSA_HPP_CLASS& set_##name(...) { ...; return *this; }\
>  > > Is there a reason why you return the object itself?  Usually, return=
ing
>  > > an object implies that that object is a _different_ object with the
>  > > setting applied, which would mean that the original object was _not_
>  > > changed, but that isn't true here.
>  > This is for function call chaining. It is a common idiom used by the
>  > standard library and others.
>  The STL streams use this to allow using the convert-to-bool operator to
>  check the error status of the stream (because most errors aren't
>  reported by exceptions).  That this also allows chaining is just a side
>  effect.

I found this feature quite useful.

>  > > > hw_config(snd_pcm_t* pcm): pcm(pcm) {
>  > > >   try { current(); } catch (std::runtime_error&) { any(); }
>  > > I don't like using exceptions when there's nothing wrong.  Besides,
>  > > getting the current parameters may fail due to other errors (like de=
vice
>  > > unplugged).
>  > It seems like a sensible fallback, anyway. The other option would be to
>  > load any() settings always and have the user call current(), if he wan=
ts
>  > those instead. Would you find this preferable?
>  My preference would be that the user has to indicate whether he wants
>  to read the current setting or to begin choosing new settings.  It is
>  not possible for this constructor to guess what the user wants.

>From a OO perspective, I would expect that a *_config object be
created from an existing pcm object. Something like:

alsa::pcm pcm;

pcm.get_config().set(FOO).set(BAR);


If there is something that doesn't apply to a pcm instance, the C++
API could provide an instance of a pcm_any object and call that
instead:

alsa::pcm_any.get_config().set(FOO).set(BAR);


[...]


HTH,


-- =

Aldrin Martoq

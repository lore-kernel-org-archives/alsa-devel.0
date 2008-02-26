From: =?UTF-8?B?TGFzc2UgS8Okcmtrw6RpbmVu?= <tronic@trn.iki.fi>
Subject: Re: ALSA C++ API updated for 1.0.16
Date: Tue, 26 Feb 2008 18:59:05 +0200
Message-ID: <47C44559.6090404@trn.iki.fi>
References: <47C30EDE.8000400@trn.iki.fi> <47C3E387.20800@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pne-smtpout3-sn1.fre.skanova.net
	(pne-smtpout3-sn1.fre.skanova.net [81.228.11.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E41C103874
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 18:03:06 +0100 (CET)
In-Reply-To: <47C3E387.20800@ladisch.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you for your input, which is quite valuable.

>> error(std::string const& function, int err): std::runtime_error("ALSA " + function + " failed: " + std::string(snd_strerror(err))), err(err) {}
> 
> I'm not sure that including the function name and all parameters as they
> appear in the source file in the error message is a good idea; I
> wouldn't want to impose this policy on all applications using this
> header.

It is just an exception thrown, the program may catch it and display
another error message. The original ALSA error code is also included
within it.

E.g.

try {
    // Some code that causes error
} catch (alsa::error& e) {
    std::cerr << "ALSA error: " << snd_strerror(e.code()) << std::endl;
}

Prints only the error, not the function that caused it, while

try {
    // ...
} catch (std::exception& e) {
    std::cerr << e.what() << std::endl;
}

would print the formatted message, containing the function name, too.

In practice the function name seems to be quite essential for debugging,
as EPIPE or some other of the standard error codes will tell little or
nothing.

For completeness, I think that it might be desirable to also store the
function name separately (like the code is stored), but can anyone see
any actual use for this?

>> pcm(char const* device = "default", snd_pcm_stream_t stream = SND_PCM_STREAM_PLAYBACK, int mode = 0) {
> 
> This looks too much like a default constructor.  I think neither device
> nor stream should have a default value.

Well, it is a default constructor. One design goal was to make this
wrapper as easy to use as possible, and choosing sensible defaults for
that is helpful.

If you are expecting alsa::pcm pcmobject; to produce an object that is
not constructed, we are talking of two-stage construction, which is
considered harmful by many C++ coders nowadays. A constructor should
always construct the object fully and throw an exception (and thus
prevent the object being created) if that is not possible. Design &
Evolution of C++, by Bjarne Stroustrup, and other books discuss this
matter thoroughly. (surprisingly enough, fstreams of the standard
library still allow two-stage construction)

Thus, I see the expected behavior of creating pcmobject that way as
being to actually construct a new PCM, with the default parameters
(where "default" and playback are the most common choices; and also far
better than people hardcoding their applications to use "plughw:0" or
whatever happens to work for them).

>> ALSA_HPP_CLASS& set_##name(...) { ...; return *this; }\
> 
> Is there a reason why you return the object itself?  Usually, returning
> an object implies that that object is a _different_ object with the
> setting applied, which would mean that the original object was _not_
> changed, but that isn't true here.

This is for function call chaining. It is a common idiom used by the
standard library and others. In this particular case, it is the very
thing that allows syntax like

alsa::hw_config(alsa_pcm)  // Temporary object
  .set(SND_PCM_ACCESS_RW_INTERLEAVED)
  .set(SND_PCM_FORMAT_S16_LE)
  .rate_near(rate)
  .channels(1)
  .period_size_first(period)
  .commit();  // The object is disposed here

Instead of

{
	alsa::hw_config config(alsa_pcm);
	config.set(SND_PCM_ACCESS_RW_INTERLEAVED);
	config.set(SND_PCM_FORMAT_S16_LE);
	config.rate_near(rate);
	config.channels(1);
	config.period_size_first(period);
	config.commit();
}

(braces are needed for limiting the config variable lifetime)

>> class hw_config: internal::noncopyable {
> 
> Why should this object not be copyable?

Because it contains the PCM pointer, whose copy semantics are somewhat
hairy. E.g. the following code would break silently:

alsa::hw_config f() {
	alsa::pcm pcm;
	return alsa::hw_config(pcm);
}

Please note that you can still make copies of alsa::hw_params.

> And why do you have two different objects (*w_params and *w_config) for
> wrapping the hardware/software parameters?

The alsa::hw_config wrapper is meant to be used only temporarily, for
easily setting the parameters. It differs from alsa::hw_params by also
tying a PCM to it.

>> hw_config(snd_pcm_t* pcm): pcm(pcm) {
>> 	try { current(); } catch (std::runtime_error&) { any(); }
> 
> I don't like using exceptions when there's nothing wrong.  Besides,
> getting the current parameters may fail due to other errors (like device
> unplugged).

It seems like a sensible fallback, anyway. The other option would be to
load any() settings always and have the user call current(), if he wants
those instead. Would you find this preferable?

Some settings need to be loaded by the constructor in order to ensure
that the structure is in a consistent state at all times.

> I think it would be better if this object doesn't have a public
> constructor, and you would be able to create one only through a pcm
> object, like "hw_config c = pcm.any_hw_params();".

That seems to require unwanted hackery (friend classes, helper objects,
etc).

Rather, if such selection is needed, I would add a second argument to
the constructor (with a suitable default value), allowing one to choose
between the two (e.g. bool useCurrent = false). However, just loading
the any settings in the constructor and loading the current settings on
top of them as required seems easier to use (theoretically slightly
slower due to the extra initialization if the current parameters are
preferred, but performance cannot be an issue in configuring a PCM).

>> ~mmap() {
>> 	// We just assume that this works (can't do anything sensible if it fails).
>> 	snd_pcm_mmap_commit(pcm, offset, frames);
> 
> This is the place where all the usual write errors must be checked.
> This cannot be done in a destructor.  I think using RAII for the non-
> error commit just isn't possible.

Ouch. This is a big problem.

I see three options

1. Drop the MMAP wrapper entirely
    * Easily leads to leaks when exceptions are thrown

2. Add a separate commit function
    * Use exceptions to signal errors from this function
    * Set pcm and areas to NULL after commit
    * Possibly throw exceptions if the object is accessed after this
      (either by operator overloading or by getter functions instead of
      public members)
    * Still commit in destructor if commit was not called

3. Throw in destructor only if std::uncaught_exception() returns false
    * Ignore all errors if stack unwinding is in progress
    * Weird semantics, not commonly used

Option 2 is hairy, as it leaves the object in unusable state after
commit is called, but it still seems highly preferable to option 1,
which would require great care from the user for avoiding resource leaks.

Option 3 is pretty much out of the question because programmers don't
expect destructors to ever throw anything.

What do you think?

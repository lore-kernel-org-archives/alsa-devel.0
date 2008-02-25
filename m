From: =?UTF-8?B?TGFzc2UgS8Okcmtrw6RpbmVu?= <tronic@trn.iki.fi>
Subject: ALSA C++ API updated for 1.0.16
Date: Mon, 25 Feb 2008 20:54:22 +0200
Message-ID: <47C30EDE.8000400@trn.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050309060605000005000006"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pne-smtpout4-sn1.fre.skanova.net
	(pne-smtpout4-sn1.fre.skanova.net [81.228.11.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 796B2244BA
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 19:58:09 +0100 (CET)
Received: from trn.iki.fi (88.195.48.158) by pne-smtpout4-sn1.fre.skanova.net
	(7.3.129) id 47A7970A0011CBB5 for alsa-devel@alsa-project.org;
	Mon, 25 Feb 2008 19:58:08 +0100
Received: from trn.iki.fi (unknown [10.1.0.1])
	by trn.iki.fi (Postfix) with ESMTP id 5F6C344CA40B2
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 20:58:12 +0200 (EET)
Received: from [127.0.0.1] (unknown [10.1.0.1])
	by trn.iki.fi (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 20:58:12 +0200 (EET)
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

This is a multi-part message in MIME format.
--------------050309060605000005000006
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Here's an updated version of the C++ wrapper that I posted earlier in
September 2007. I would like this to be included in the ALSA
distribution after some peer review.

This wrapper has been used in UltraStar NG (a game shipped by Gentoo and
others) since September, with no known issues other than that it is
incomplete (very PCM-centric).

As a reminder, the API closely follows the C API, and also allows mixing
direct C API calls with itself transparently.


--------------050309060605000005000006
Content-Type: text/x-c++hdr;
 name="alsa.hpp"
Content-Disposition: inline;
 filename="alsa.hpp"
Content-Transfer-Encoding: quoted-printable

#ifndef ALSA_HPP_INCLUDED
#define ALSA_HPP_INCLUDED

/**

@file alsa.hpp
@brief An experimental low-level C++ API to ALSA.
@version 0.5
@author Lasse K=C3=A4rkk=C3=A4inen <tronic>
@license GNU LGPL 2.1 or later

This is a header-only C++ wrapper for the ALSA library. This means that y=
ou do
not need to add any new binary files to your build and you will only need=
 to
link with -lasound, as if you were using the C API directly. GCC will pro=
bably
optimize all of the wrapper overhead away in any case, leaving you with a=
 safer
and easier API to ALSA, but leaving your binaries just as if you had used=
 C.

The library is designed to be very closely related to the C API, so that =
you
can still see what is going on under the hood, and also so that porting e=
xisting
applications to it is trivial. The interoperatibility between C and C++ A=
PIs is
is a major design goal. What this means is that you can freely mix C and =
C++ API
calls with no problems.


Usage example:

alsa::pcm alsa_pcm;  // Create a PCM object (defaults to playback and mod=
e =3D 0)

The above creates an equivalent for the snd_pcm_t*, which is what you nee=
d to
play or record anything. Make sure that the alsa_pcm object stays alive a=
s long
as you need it (and preferrably not longer) by putting it inside a suitab=
le
class or even inside the main() function. The object cannot be copied, bu=
t you
can pass references to it to other objects or functions.

The alsa_pcm also automatically converts into snd_pcm_t* as required, so =
you can
use it as an argument for the C API functions.

Next you'll need to configure it:

unsigned int rate =3D 44100;
unsigned int period;

alsa::hw_config(alsa_pcm)  // Create a new config space
  .set(SND_PCM_ACCESS_RW_INTERLEAVED)
  .set(SND_PCM_FORMAT_S16_LE)
  .rate_near(rate)
  .channels(1)
  .period_size_first(period)  // Get the smallest available period size
  .commit();  // Apply the config to the PCM

alsa::hw_config(pcm) constructs a new config space, using the current set=
tings
from the PCM, if available, or the "any" space, if not set yet. The any s=
pace
contains all available hardware configurations and you have to narrow it =
down
to exactly one option by setting some parameters. Trying to narrow it too=
 much
(by asking an amount of channels that is not available, for example) caus=
es a
failure.

In case of failure, an alsa::error is thrown. When this happens, the comm=
it part
never gets executed and thus the result is not stored to alsa_pcm and the
failed operation will have no effect (even to the temporary hw_config obj=
ect,
which gets destroyed when the exception flies). However, all the operatio=
ns
already performed successfully remain in effect.

The rate_near functions behaves like the C API *_near functions
do: they take the preferred value as an argument and then they modify the
argument, returning the actual rate. For example, if your sound card only
supports 48000 Hz, rate will be set to that on that call, even if some la=
ter
part, such as setting the number of channels, fails.

In the example above, a temporary object of type alsa::hw_config was used=
, but
you can also create a variable of it, should you need to test something i=
n
between, or if you want to call the C API functions directly (hw_config
converts automatically into hw_params, which converts into snd_hw_params_=
t*).

For this, you may use a block like this:

{
    alsa::hw_config hw(alsa_pcm);
    hw.set(SND_ACCESS_(SND_PCM_ACCESS_MMAP_INTERLEAVED);
    hw.set(SND_PCM_FORMAT_FLOAT_BE);
    if (!snd_pcm_hw_params_is_full_duplex(hw)) hw.channels(2);
    hw.commit();
}

(anyone got a better example?)


Software configuration works in the same way, using alsa::sw_config, just=
 the
parameters to be adjusted are different.

When constructed, both sw_config and hw_config try to load config from th=
e given
PCM. If that fails, sw_config throws, but hw_config still tries loading t=
he any
space. Alternatively, you may supply a snd_pcm_hw/sw_params_t const* as a=
 second
argument for the constructor to get a copy of the contents of that that i=
nstead.

The contents may be loaded (overwrites the old contents) with these funct=
ions:
  .any()            Get the "any" configuration (hw_config only)
  .current()        Get the currently active configuration from PCM
Once finished with the changes, you should call:
  .commit()         Store current config space to the PCM

For enum values SND_PCM_*, you may use the following functions:
  .get(var)         Get the current setting into the given variable
  .set(val)         Set the value requested (also supports masks)
  .enum_test(val)   The same as .set, except that it does not set anythin=
g
  .enum_first(var)  Set the first available option, store the selection i=
n var
  .enum_last(var)   Set the last available option, store the selection in=
 var

The parameter to manipulate is chosen based on the argument type. The enu=
m_*
functions and masks are only available for hardware parameters, not for
sw_param.

For integer values (times, sizes, counts), these functions are available:
  .get_X(var)       Get the current setting into the given variable
  .X(val)           Set the value requested
For ranges, the following can also be used:
  .get_X_min(var)   Get the smallest available value into var
  .get_X_max(var)   Get the largest available value into var
  .X_min(var)       Remove all values smaller than var and store the new
                    smallest value into var.
  .X_max(var)       Remove all values larger than var, store new max in v=
ar.
  .X_minmax(v1, v2) Limit to [v1, v2], store new range in v1, v2.
  .X_near(var)      Set the closest available value and store it in var
  .X_first(var)     Set the first available option, store the selection i=
n var
  .X_last(var)      Set the last available option, store the selection in=
 var

For booleans, these functions are available:
  .get_X(var)    Get the current setting (var must be unsigned int or boo=
l)
  .set_X(val)    Set the value (val can be anything that converts into bo=
ol)
 =20
Replace X with the name of the parameter that you want to set. Consult th=
e ALSA
C library reference for available options. All functions that modify thei=
r
arguments require the same type as is used in the C API (often unsigned i=
nt or
snd_pcm_uframes_t). The only exception is with bool types, where both boo=
l and
unsigned int are accepted.

For those ranged parameters that support the dir argument (see ALSA docs)=
, the
default value is always 0 when writing and NULL (none) when reading. You =
may
supply the preferred dir value or variable as the second argument and the=
n the
value will be used or the result will be stored in the variable supplied.

For example, the following calls are equivalent:
snd_pcm_hw_params_set_format(pcm, hw, SND_PCM_FORMAT_FLOAT_LE)
  <=3D> hw.set(SND_PCM_FORMAT_FLOAT_LE)
snd_pcm_hw_params_set_rate_resample(pcm, hw, 1) <=3D> hw.rate_resample(tr=
ue)
snd_pcm_hw_params_set_channels_near(pcm, hw, &num) <=3D> hw.channels_near=
(num)
snd_pcm_hw_params_get_rate(hw, &rate, NULL) <=3D> hw.get_rate(rate)
snd_pcm_hw_params_get_rate(hw, &rate, &dir) <=3D> hw.get_rate(rate, dir)


... except for the fact that the C++ versions also check the return value=
s and
throw alsa::error if anything goes wrong. alsa::error inherits from
std::runtime_error and thus eventually from std::exception, so you can ca=
tch
pretty much everything by catching that somewhere in your code:

try {
	// do everything here
} catch (std::exception& e) {
	std::cerr << "FATAL ERROR: " << e.what() << std::endl;
}

However, recent versions of glibc seem to be handling uncaught exceptions=
 quite
nicely, so even without a try-catch you may get a nice printout in your c=
onsole:

terminate called after throwing an instance of 'alsa::error'
  what():  ALSA snd_pcm_hw_params_set_channels failed: Invalid argument
Aborted

If you need to know the error code, you may call e.code() after catching
alsa::error& e.


When you call the C API functions directly, the ALSA_CHECKED macro may pr=
ove to
be useful. It is used internally by the library for testing errors and th=
rowing
exceptions when calling the C functions. It will throw alsa::error with a
description of the error if the function returns a negative value.

The macro is well-behaving, as it only calls an internal helper function,
evaluating the arguments given exactly once.

Usage: ALSA_CHECKED(snd_pcm_whatever, (arg1, arg2, arg2));

Note: a comma between function name and arguments.

The return value can also still be used (will return only >=3D 0):


For MMAP transfers, another RAII wrapper, alsa::mmap, is provided.

Usage:

// First we need to call avail_update (storing the return value is option=
al)
snd_pcm_uframes_t count =3D ALSA_CHECKED(snd_pcm_avail_update, (pcm));
alsa::mmap mmap(pcm, 256) // Begin MMAP transfer, request 256 frames

// Process the audio (mmap.frames frames of it, accessible via mmap.areas=
,
// starting at offset mmap.offset) and then let mmap go out of scope, whi=
ch will
// end the transfer. If you didn't process all available frames, set the =
number
// of frames processed to mmap.frames before the object goes out of scope=
.

As usual, the constructor will throw alsa::error in case of error.


In case you really want to get low-level, alsa::hw_params and alsa::sw_pa=
rams
are offered. These only contain the corresponding snd_pcm_*_params_t, but=
 they
allocate and free memory automatically and they can also properly copy th=
e
struct contents when they get copied. Be aware that the structure content=
s are
not initialized during construction, so you have to initialize it yoursel=
f (just
like with the C API). They are used internally by hw_config and sw_config=
 and
normally it should be better to use these instead of dealing directly wit=
h the
params.

**/

#include <alsa/asoundlib.h>
#include <stdexcept>
#include <string>

/**
* A macro that executes func with the given args and tests for errors.
* Examples of use:
*   ALSA_CHECKED(snd_pcm_recover, (pcm, e.code(), 0));
*   snd_pcm_uframes_t count =3D ALSA_CHECKED(snd_pcm_avail_update, (pcm))=
;
* @param func the function name
* @param args arguments in parenthesis
* @return the return value of the function
* @throws alsa::error if the return value is smaller than zero.
**/
#define ALSA_CHECKED(func, args) alsa::internal::check(func args, #func)

namespace alsa {
	/** @short Exception class **/
	class error: public std::runtime_error {
		int err;
	  public:
		error(std::string const& function, int err): std::runtime_error("ALSA "=
 + function + " failed: " + std::string(snd_strerror(err))), err(err) {}
		int code() const { return err; }
	};

	namespace internal {
		/** For internal use only: a function used by the macro ALSA_CHECKED **=
/
		template<typename T> T check(T ret, char const* funcname) {
			if (ret < 0) throw error(funcname, ret);
			return ret;
		}
		/**
		* @short FOR INTERNAL USE ONLY. A utility class similar to
		* boost::noncopyable, duplicated here in order to avoid
		* a dependency on the Boost library.
		**/
		class noncopyable {
		  protected:
			noncopyable() {}
			~noncopyable() {}
		  private:
			noncopyable(noncopyable const&);
			noncopyable const& operator=3D(noncopyable const&);
		};
	}

	/**
	* @short A minimal RAII wrapper for ALSA PCM.
	* Automatically converts into snd_pcm_t* as needed, so the ALSA C API
	* can be used directly with this.
	**/
	class pcm: internal::noncopyable {
		snd_pcm_t* handle;
	  public:
		pcm(char const* device =3D "default", snd_pcm_stream_t stream =3D SND_P=
CM_STREAM_PLAYBACK, int mode =3D 0) {
			ALSA_CHECKED(snd_pcm_open, (&handle, device, stream, mode));
		}
		~pcm() { snd_pcm_close(handle); }
		operator snd_pcm_t*() { return handle; }
		operator snd_pcm_t const*() const { return handle; }
	};

	// RAII wrapper for snd_pcm_hw/sw_params_t types.
=09
#define ALSA_HPP_PARAMWRAPPER(type) \
	class type##_params {\
		snd_pcm_##type##_params_t* handle;\
		void init() { ALSA_CHECKED(snd_pcm_##type##_params_malloc, (&handle)); =
}\
	  public:\
		type##_params() { init(); }\
		~type##_params() { snd_pcm_##type##_params_free(handle); }\
		type##_params(type##_params const& orig) { init(); *this =3D orig; }\
		type##_params(snd_pcm_##type##_params_t const* orig) { init(); *this =3D=
 orig; }\
		type##_params& operator=3D(snd_pcm_##type##_params_t const* params) {\
			if (handle !=3D params) snd_pcm_##type##_params_copy(handle, params);\
			return *this;\
		}\
		operator snd_pcm_##type##_params_t*() { return handle; }\
		operator snd_pcm_##type##_params_t const*() const { return handle; }\
	};

	ALSA_HPP_PARAMWRAPPER(hw)
	ALSA_HPP_PARAMWRAPPER(sw)
#undef ALSA_HPP_PARAMWRAPPER

// Various helper macros used for generating code for hw_config and sw_co=
nfig

#define ALSA_HPP_FUNC(name, suffix) ALSA_HPP_TEMPLATE(& name(), suffix, (=
pcm, params))

#define ALSA_HPP_VARGET(name, type) \
  ALSA_HPP_TEMPLATE(& get_##name(type& val), _get_##name, (params, &val))=
\
  ALSA_HPP_TEMPLATE(const& get_##name(type& val) const, _get_##name, (par=
ams, &val))

#define ALSA_HPP_VAR(name, type) ALSA_HPP_VARGET(name, type)\
  ALSA_HPP_TEMPLATE(& name(type val), _set_##name, (pcm, params, val))

#define ALSA_HPP_ENUMVARMINIMAL(name) \
  ALSA_HPP_TEMPLATE(& get(snd_pcm_##name##_t& name), _get_##name, (params=
, &name))\
  ALSA_HPP_TEMPLATE(const& get(snd_pcm_##name##_t& name) const, _get_##na=
me, (params, &name))\
  ALSA_HPP_TEMPLATE(& set(snd_pcm_##name##_t name), _set_##name, (pcm, pa=
rams, name))

#define ALSA_HPP_ENUMVAR(name) ALSA_HPP_ENUMVARMINIMAL(name)\
  ALSA_HPP_TEMPLATE(& enum_test(snd_pcm_##name##_t name), _test_##name, (=
pcm, params, name))\
  ALSA_HPP_TEMPLATE(& enum_first(snd_pcm_##name##_t& name), _set_##name##=
_first, (pcm, params, &name))\
  ALSA_HPP_TEMPLATE(& enum_last(snd_pcm_##name##_t& name), _set_##name##_=
last, (pcm, params, &name))\
  ALSA_HPP_TEMPLATE(& set(snd_pcm_##name##_mask_t* mask), _set_##name##_m=
ask, (pcm, params, mask))
 =20
#define ALSA_HPP_BOOLVAR(name) \
  ALSA_HPP_CLASS& get_##name(bool& val) { unsigned int tmp; get_##name(tm=
p); val =3D tmp; return *this; }\
  /*ALSA_HPP_CLASS const& get_##name(bool& val) const { unsigned int tmp;=
 get_##name(tmp); val =3D tmp; return *this; }*/\
  ALSA_HPP_TEMPLATE(& get_##name(unsigned int& val), _get_##name, (pcm, p=
arams, &val))\
  /*ALSA_HPP_TEMPLATE(const& get_##name(unsigned int& val) const, _get_##=
name, (pcm, params, &val))*/\
  ALSA_HPP_TEMPLATE(& name(bool val =3D true), _set_##name, (pcm, params,=
 val))

#define ALSA_HPP_RANGEVAR(name, type) ALSA_HPP_VAR(name, type)\
  ALSA_HPP_TEMPLATE(& get_##name##_min(type& min), _get_##name##_min, (pa=
rams, &min))\
  ALSA_HPP_TEMPLATE(const& get_##name##_min(type& min) const, _get_##name=
##_min, (params, &min))\
  ALSA_HPP_TEMPLATE(& get_##name##_max(type& max), _get_##name##_max, (pa=
rams, &max))\
  ALSA_HPP_TEMPLATE(const& get_##name##_max(type& max) const, _get_##name=
##_max, (params, &max))\
  ALSA_HPP_TEMPLATE(& name##_min(type& min), _set_##name##_min, (pcm, par=
ams, &min))\
  ALSA_HPP_TEMPLATE(& name##_max(type& max), _set_##name##_max, (pcm, par=
ams, &max))\
  ALSA_HPP_TEMPLATE(& name##_minmax(type& min, type& max), _set_##name##_=
minmax, (pcm, params, &min, &max))\
  ALSA_HPP_TEMPLATE(& name##_near(type& val), _set_##name##_near, (pcm, p=
arams, &val))\
  ALSA_HPP_TEMPLATE(& name##_first(type& val), _set_##name##_first, (pcm,=
 params, &val))\
  ALSA_HPP_TEMPLATE(& name##_last(type& val), _set_##name##_last, (pcm, p=
arams, &val))

#define ALSA_HPP_RANGEVARDIR(name, type) \
  ALSA_HPP_TEMPLATE(& get_##name(type& val), _get_##name, (params, &val, =
NULL))\
  ALSA_HPP_TEMPLATE(const& get_##name(type& val) const, _get_##name, (par=
ams, &val, NULL))\
  ALSA_HPP_TEMPLATE(& get_##name(type& val, int& dir), _get_##name, (para=
ms, &val, &dir))\
  ALSA_HPP_TEMPLATE(const& get_##name(type& val, int& dir) const, _get_##=
name, (params, &val, &dir))\
  ALSA_HPP_TEMPLATE(& get_##name##_min(type& min), _get_##name##_min, (pa=
rams, &min, NULL))\
  ALSA_HPP_TEMPLATE(const& get_##name##_min(type& min) const, _get_##name=
##_min, (params, &min, NULL))\
  ALSA_HPP_TEMPLATE(& get_##name##_min(type& min, int& dir), _get_##name#=
#_min, (params, &min, &dir))\
  ALSA_HPP_TEMPLATE(const& get_##name##_min(type& min, int& dir) const, _=
get_##name##_min, (params, &min, &dir))\
  ALSA_HPP_TEMPLATE(& get_##name##_max(type& max), _get_##name##_max, (pa=
rams, &max, NULL))\
  ALSA_HPP_TEMPLATE(const& get_##name##_max(type& max) const, _get_##name=
##_max, (params, &max, NULL))\
  ALSA_HPP_TEMPLATE(& get_##name##_max(type& max, int& dir), _get_##name#=
#_max, (params, &max, &dir))\
  ALSA_HPP_TEMPLATE(const& get_##name##_max(type& max, int& dir) const, _=
get_##name##_max, (params, &max, &dir))\
  ALSA_HPP_TEMPLATE(& name(type val, int dir =3D 0), _set_##name, (pcm, p=
arams, val, dir))\
  ALSA_HPP_TEMPLATE(& name##_min(type& min), _set_##name##_min, (pcm, par=
ams, &min, NULL))\
  ALSA_HPP_TEMPLATE(& name##_min(type& min, int& dir), _set_##name##_min,=
 (pcm, params, &min, &dir))\
  ALSA_HPP_TEMPLATE(& name##_max(type& max), _set_##name##_max, (pcm, par=
ams, &max, NULL))\
  ALSA_HPP_TEMPLATE(& name##_max(type& max, int& dir), _set_##name##_max,=
 (pcm, params, &max, &dir))\
  ALSA_HPP_TEMPLATE(& name##_minmax(type& min, type& max), _set_##name##_=
minmax, (pcm, params, &min, NULL, &max, NULL))\
  ALSA_HPP_TEMPLATE(& name##_minmax(type& min, int& mindir, type& max, in=
t& maxdir), _set_##name##_minmax, (pcm, params, &min, &mindir, &max, &max=
dir))\
  ALSA_HPP_TEMPLATE(& name##_near(type& val), _set_##name##_near, (pcm, p=
arams, &val, NULL))\
  ALSA_HPP_TEMPLATE(& name##_near(type& val, int& dir), _set_##name##_nea=
r, (pcm, params, &val, &dir))\
  ALSA_HPP_TEMPLATE(& name##_first(type& val), _set_##name##_first, (pcm,=
 params, &val, NULL))\
  ALSA_HPP_TEMPLATE(& name##_first(type& val, int& dir), _set_##name##_fi=
rst, (pcm, params, &val, &dir))\
  ALSA_HPP_TEMPLATE(& name##_last(type& val), _set_##name##_last, (pcm, p=
arams, &val, NULL))\
  ALSA_HPP_TEMPLATE(& name##_last(type& val, int& dir), _set_##name##_las=
t, (pcm, params, &val, &dir))

	/** @short A helper object for modifying hw_params of a PCM. **/
	class hw_config: internal::noncopyable {
		snd_pcm_t* pcm;
		hw_params params;
	  public:
		/**
		* Construct a new config object, initialized with the current settings
		* of the PCM or with the "any" configuration space, if there are none.
		**/
		hw_config(snd_pcm_t* pcm): pcm(pcm) {
			try { current(); } catch (std::runtime_error&) { any(); }
		}
		/** Construct a new config object, initialized with a copy from given p=
arameters **/
		hw_config(snd_pcm_t* pcm, snd_pcm_hw_params_t const* params): pcm(pcm),=
 params(params) {}
		operator hw_params&() { return params; }
		operator hw_params const&() const { return params; }
#define ALSA_HPP_CLASS hw_config
#define ALSA_HPP_TEMPLATE(proto, suffix, params) ALSA_HPP_CLASS proto { A=
LSA_CHECKED(snd_pcm_hw_params##suffix, params); return *this; }
		// Load / store functions
		ALSA_HPP_FUNC(commit,)
		ALSA_HPP_FUNC(any, _any)
		ALSA_HPP_FUNC(current, _current)
		// Enum functions
		ALSA_HPP_ENUMVAR(access)
		ALSA_HPP_ENUMVAR(format)
		ALSA_HPP_ENUMVAR(subformat)
		// Bool functions
		ALSA_HPP_BOOLVAR(rate_resample)
		ALSA_HPP_BOOLVAR(export_buffer)
		// Range functions
		ALSA_HPP_RANGEVAR(channels, unsigned int)
		ALSA_HPP_RANGEVAR(buffer_size, snd_pcm_uframes_t)
		// Range functions with direction argument
		ALSA_HPP_RANGEVARDIR(rate, unsigned int)
		ALSA_HPP_RANGEVARDIR(period_time, unsigned int)
		ALSA_HPP_RANGEVARDIR(period_size, snd_pcm_uframes_t)
		ALSA_HPP_RANGEVARDIR(periods, unsigned int)
		ALSA_HPP_RANGEVARDIR(buffer_time, unsigned int)
#undef ALSA_HPP_TEMPLATE
#undef ALSA_HPP_CLASS
	};

	class sw_config: internal::noncopyable {
		snd_pcm_t* pcm;
		sw_params params;
	  public:
		sw_config(snd_pcm_t* pcm): pcm(pcm) { current(); }
		/** Construct a new config object, initialized with a copy from given p=
arameters **/
		sw_config(snd_pcm_t* pcm, snd_pcm_sw_params_t const* params): pcm(pcm),=
 params(params) {}
		operator sw_params&() { return params; }
		operator sw_params const&() const { return params; }
#define ALSA_HPP_CLASS sw_config
#define ALSA_HPP_TEMPLATE(proto, suffix, params) ALSA_HPP_CLASS proto { A=
LSA_CHECKED(snd_pcm_sw_params##suffix, params); return *this; }
		// Load / store functions
		ALSA_HPP_FUNC(commit,)
		ALSA_HPP_FUNC(current, _current)
		// Enum functions
		typedef snd_pcm_tstamp_t snd_pcm_tstamp_mode_t; // Workaround for incon=
sistent naming in asound
		ALSA_HPP_ENUMVARMINIMAL(tstamp_mode)
		// Simple variable functions
		ALSA_HPP_VAR(avail_min, snd_pcm_uframes_t)
		ALSA_HPP_VAR(start_threshold, snd_pcm_uframes_t)
		ALSA_HPP_VAR(stop_threshold, snd_pcm_uframes_t)
		ALSA_HPP_VAR(silence_threshold, snd_pcm_uframes_t)
		ALSA_HPP_VAR(silence_size, snd_pcm_uframes_t)
		ALSA_HPP_VAR(tstamp_mode, snd_pcm_tstamp_t)
		// Get-only variable
		ALSA_HPP_VARGET(boundary, snd_pcm_uframes_t)
#undef ALSA_HPP_TEMPLATE
#undef ALSA_HPP_CLASS
	};

#undef ALSA_HPP_FUNC
#undef ALSA_HPP_VAR
#undef ALSA_HPP_VARGET
#undef ALSA_HPP_ENUMVAR
#undef ALSA_HPP_ENUMVARMINIMAL
#undef ALSA_HPP_BOOLVAR
#undef ALSA_HPP_RANGEVAR
#undef ALSA_HPP_RANGEVARDIR

	/** @short A RAII wrapper for snd_pcm_mmap_begin/end block. **/
	class mmap {
		snd_pcm_t* pcm;
	  public:
		snd_pcm_channel_area_t const* areas;
		snd_pcm_uframes_t const offset; // Const for external API
		snd_pcm_uframes_t frames;
		/**
		* Initiate MMAP transfer. Returns a buffer via .areas member variable.
		* snd_pcm_avail_update must be called directly before constructing the
		* alsa::mmap object, otherwise snd_pcm_mmap_begin may return a wrong
		* count of available frames.
		* @param pcm PCM handle
		* @param fr number of frames to request (check .frames for actual count=
)
		**/
		mmap(snd_pcm_t* pcm, snd_pcm_uframes_t fr): pcm(pcm), areas(), offset()=
, frames(fr) {
			ALSA_CHECKED(snd_pcm_mmap_begin, (pcm, &areas, const_cast<snd_pcm_ufra=
mes_t*>(&offset), &frames));
		}
		/**
		* End MMAP transfer. If not all frames were used, the count of frames
		* used be set in .frames member variable before alsa::mmap destruction.
		**/
		~mmap() {
			// We just assume that this works (can't do anything sensible if it fa=
ils).
			snd_pcm_mmap_commit(pcm, offset, frames);
		}
	};

}

#endif


--------------050309060605000005000006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050309060605000005000006--

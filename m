From: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+rlk9@trn.iki.fi>
Subject: ALSA C++ API
Date: Sat, 08 Sep 2007 23:16:51 +0300
Message-ID: <46E30333.7080303@trn.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040505020800040108090105"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pne-smtpout4-sn1.fre.skanova.net
	(pne-smtpout4-sn1.fre.skanova.net [81.228.11.168])
	by alsa0.perex.cz (Postfix) with ESMTP id D3F01103810
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Sep 2007 22:36:29 +0200 (CEST)
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
Cc: ultrastar-ng-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040505020800040108090105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have written an experimental wrapper for a few parts of the PCM API,
using C++. I intend to keep it header-only, if possible. This minimizes
the binary compatibility issues and also improves performance slightly,
but unlikely noticeably (should be identical to using the C API directly).

Primary goals of this wrapper are safety (errors are handled by
exceptions and resource leaks should not be possible) and the simplicity
of use, while still keeping it very low-level, close to the C API.

Does anyone have interest to develop this further? It would also be nice
if it could eventually be included in the alsa-lib distribution.

The header and a sample program are attached below.

Comments are welcome.


--------------040505020800040108090105
Content-Type: text/plain;
 name="alsa.hpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa.hpp"

#ifndef ALSA_HPP_INCLUDED
#define ALSA_HPP_INCLUDED

/**
* @file Experimental low level C++ API to ALSA.
* @licence GNU LGPL 2.1 or later
**/

#include <alsa/asoundlib.h>
#include <stdexcept>

namespace alsa {
	namespace util {
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
			noncopyable const& operator=(noncopyable const&);
		};
	}

	/**
	* @short A minimal RAII wrapper for ALSA PCM.
	* Automatically converts into snd_pcm_t* as needed, so the ALSA C API
	* can be used directly with this.
	**/
	class PCM: util::noncopyable {
		snd_pcm_t* handle;
	  public:
		PCM(char const* device = "default", snd_pcm_stream_t stream = SND_PCM_STREAM_PLAYBACK, int mode = 0) {
			if (snd_pcm_open(&handle, device, stream, mode) < 0)
			  throw std::runtime_error(std::string("Cannot open ALSA device ") + device);
		}
		~PCM() {
			snd_pcm_close(handle);
		}
		operator snd_pcm_t*() { return handle; }
	};

	/**
	* @short A RAII wrapper for ALSA HWParams structure.
	* Automatically converts into snd_pcm_hw_params_t* as needed, so the
	* ALSA C API can still be used directly with this.
	* Note: contents need to be loaded before the struct can be used.
	**/
	class HWParams {
		snd_pcm_hw_params_t* handle;
		void init() {
			if (snd_pcm_hw_params_malloc(&handle) < 0)
			  throw std::runtime_error("ALSA snd_pcm_hw_params_malloc failed");
		}
	  public:
		HWParams() { init(); }
		~HWParams() {
			snd_pcm_hw_params_free(handle);
		}
		HWParams(HWParams const& orig) {
			init();
			*this = orig;
		}
		HWParams& operator=(HWParams const& orig) {
			if (this != &orig) {
				snd_pcm_hw_params_copy(handle, orig.handle);
			}
			return *this;
		}
		operator snd_pcm_hw_params_t*() { return handle; }
	};

	/**
	* @short A helper object for modifying HWParams of a PCM.
	*
	* Normally only temporary objects should be created. A typical use case:
	* alsa::PCM alsa_pcm;  // Create a PCM object
	* alsa::HWConfig(alsa_pcm)  // Create a new config space
	*   .set(SND_PCM_ACCESS_RW_INTERLEAVED)
	*   .set(SND_PCM_FORMAT_S16_LE)
	*   .rate_near(rate)
	*   .channels_near(channels)
	*   .period_time_near(period)
	*   .commit();  // Apply the config to the PCM
	* Note: in case of failure, an exception is thrown. When this happens,
	* the commit part never gets executed and thus this entire statement
	* will become void as if it was never executed in the first place.
	*
	* If you need to use the C snd_pcm_hw_params_* functions, you may use a
	* block like this:
	* {
	*     alsa::HWConfig hw(alsa_pcm);
	*     hw.foo();
	*     snd_pcm_hw_params_set_period_size(alsa_pcm, hw, 1024, 0);
	*     hw.bar().commit();
	* }
	**/
	class HWConfig: util::noncopyable {
		HWParams params;
		PCM& pcm;
	  public:
		HWConfig(PCM& pcm): pcm(pcm) { any(); }
		operator HWParams&() { return params; }
		void commit() {
			if (snd_pcm_hw_params(pcm, params) < 0)
			  throw std::runtime_error("ALSA snd_pcm_hw_params failed");
		}
		HWConfig& any() {
			if (snd_pcm_hw_params_any(pcm, params) < 0)
			  throw std::runtime_error("ALSA snd_pcm_hw_params_any failed");
			return *this;
		}
		HWConfig& current() {
			if (snd_pcm_hw_params_current(pcm, params) < 0)
			  throw std::runtime_error("ALSA snd_pcm_hw_params_current failed");
			return *this;
		}
		HWConfig& set(snd_pcm_access_t access) {
			if (snd_pcm_hw_params_set_access(pcm, params, access) < 0)
			  throw std::runtime_error("ALSA snd_pcm_hw_params_set_access failed");
			return *this;
		}
		HWConfig& set(snd_pcm_format_t format) {
			if (snd_pcm_hw_params_set_format(pcm, params, format) < 0)
			  throw std::runtime_error("ALSA snd_pcm_hw_params_set_format failed");
			return *this;
		}
		HWConfig& rate(unsigned int rate) {
			if (snd_pcm_hw_params_set_rate(pcm, params, rate, NULL) < 0)
			  throw std::runtime_error("ALSA snd_pcm_hw_params_set_rate failed");
			return *this;
		}
		HWConfig& rate_near(unsigned int& rate) {
			if (snd_pcm_hw_params_set_rate_near(pcm, params, &rate, NULL) < 0)
			  throw std::runtime_error("ALSA snd_pcm_hw_params_set_rate_near failed");
			return *this;
		}
		HWConfig& channels(unsigned int num) {
			if (snd_pcm_hw_params_set_channels(pcm, params, num) < 0)
			  throw std::runtime_error("ALSA snd_pcm_hw_params_set_channels failed");
			return *this;
		}
		HWConfig& channels_near(unsigned int& num) {
			if (snd_pcm_hw_params_set_channels_near(pcm, params, &num) < 0)
			  throw std::runtime_error("ALSA snd_pcm_hw_params_set_channels_near failed");
			return *this;
		}
		HWConfig& period_time(unsigned int samples) {
			if (snd_pcm_hw_params_set_period_time(pcm, params, samples, NULL) < 0)
			  throw std::runtime_error("ALSA snd_pcm_hw_params_set_period_time failed");
			return *this;
		}
		HWConfig& period_time_near(unsigned int& us) {
			if (snd_pcm_hw_params_set_period_time_near(pcm, params, &us, NULL) < 0)
			  throw std::runtime_error("ALSA snd_pcm_hw_params_set_period_time_near failed");
			return *this;
		}
	};
}

#endif


--------------040505020800040108090105
Content-Type: text/plain;
 name="alsarate.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsarate.cpp"

// This program tries to record from your sound card, using a chosen sampling
// rate. ALSA may give another rate, if the sound card does not support the
// requested rate. Two seconds of audio is recorded and the time spent is
// measured in order to find the actual rate of the sound card.

// Compile with g++ alsarate.cpp -o alsarate -I. -lasound
// ... assuming that you have alsa.hpp in the same folder.

// Usage: alsarate [ALSA device] [sampling rate] [time in seconds]

// GNU GPLv3 or later.

#include <alsa.hpp>
#include <sys/time.h>
#include <algorithm>
#include <iomanip>
#include <iostream>
#include <sstream>
#include <vector>

double getTime() {
	timeval t;
	if (gettimeofday(&t, NULL) == -1) throw std::runtime_error("gettimeofday failed");
	return t.tv_sec + t.tv_usec * 1e-6;
}

void test(char const* dev, unsigned long reqRate, double seconds, bool play) {
	std::cerr << ">>> Testing " << (play ? "playback" : "capture") << std::endl;
	try {
		std::cerr << "Opening ALSA device " << dev << " at " << reqRate << " Hz." << std::endl;
		double time = getTime();
		unsigned int rate = reqRate;
		unsigned int channels = 1;
		unsigned int period = 1;
		alsa::PCM alsaHandle(dev, play ? SND_PCM_STREAM_PLAYBACK : SND_PCM_STREAM_CAPTURE);
		alsa::HWConfig(alsaHandle)
		  .set(SND_PCM_ACCESS_RW_INTERLEAVED)
		  .set(SND_PCM_FORMAT_S16_LE)
		  .rate_near(rate)
		  .channels_near(channels)
		  .period_time_near(period)
		  .commit();
		std::cerr << "Got " << rate << " Hz, " << channels << " channels, period " << period * 1e-3 << " ms." << std::endl;
		int nFrames = 0;
		size_t len = rate * seconds;
		std::vector<short> buf(2048 * channels);
		for (size_t f = 0; f < len; f += nFrames) {
			unsigned int frames = std::min<unsigned int>(buf.size() / channels, len - f);
			if (play) {
				nFrames = snd_pcm_writei(alsaHandle, &buf[0], frames);
			} else {
				nFrames = snd_pcm_readi(alsaHandle, &buf[0], frames);
			}
			if (nFrames < 0) throw std::runtime_error("snd_pcm_readi or snd_pcm_writei failed");
		}
		time = getTime() - time;
		std::cerr << std::fixed << std::setprecision(2) << time << " seconds, measured rate " << std::setprecision(0) << len / time << " Hz." << std::endl;
	} catch (std::exception& e) {
		std::cerr << "FATAL ERROR: " << e.what() << std::endl;
	}
}

// Should use Boost, but who has the headers installed?
template <typename Out, typename In> Out lexical_cast(In val) {
	std::stringstream ss;
	Out ret;
	ss << val;
	if (ss >> ret) return ret;
	throw std::runtime_error("Invalid input, lexical cast failed");
}

int main(int argc, char** argv) {
	char const* dev = argc > 1 ? argv[1] : "default";
	unsigned int reqRate = argc > 2 ? lexical_cast<int>(argv[2]) : 48000;
	double time = argc > 3 ? lexical_cast<double>(argv[3]) : 10.0;
	test(dev, reqRate, time, true);
	test(dev, reqRate, time, false);
}


--------------040505020800040108090105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040505020800040108090105--

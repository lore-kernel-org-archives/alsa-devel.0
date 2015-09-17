From: Uli Franke <uli.franke@weiss.ch>
Subject: Re: Test device for automated testing
Date: Thu, 17 Sep 2015 10:09:32 +0200
Message-ID: <55FA753C.5050002@weiss.ch>
References: <55F9617A.6040301@weiss.ch> <55F96798.70106@ladisch.de>
 <55F96B5A.6000900@weiss.ch> <55F97CFD.9080608@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server11.hostfactory.ch (server11.hostfactory.ch
 [62.146.13.133])
 by alsa0.perex.cz (Postfix) with ESMTP id F05ED26513B
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 10:09:33 +0200 (CEST)
In-Reply-To: <55F97CFD.9080608@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 16.09.2015 16:30, Clemens Ladisch wrote:
> Uli Franke wrote:
>> I tried the "null" but this fails when setting hw parameters with an
>> assertion.
> 
> In theory, the null device does not have any restrictions.  But an
> assertion indicates a programming error (somewhere).  What is the
> message, and what are the hw parameters?

The assertion fails with

pcm_params.c:2360: _snd_pcm_hw_params_internal: Assertion `err >= 0' failed.

There's only a single result on google [1] which discusses this
assertion but the thread doesn't result in any meaningful conclusion.

I assembled a small test program which causes this very assertion to fail.

#include <alsa/asoundlib.h>

int main ()
{
	snd_pcm_hw_params_t *params;
	snd_pcm_t *pcm;

	snd_pcm_open(&pcm, "null", SND_PCM_STREAM_PLAYBACK, 0);
	snd_pcm_hw_params_malloc(&params);
	snd_pcm_hw_params_any(pcm, params);
	snd_pcm_hw_params(pcm, params);

	return 0;
}

I appended some system specs [2] (in case you should need more, just let
me know).

Regards
Uli

____
[1] http://sourceforge.net/p/cmus/mailman/message/32707782/
[2] System specs:

uli@ankerklause:~/.../dlna/wdmr$ uname -a
Linux ankerklause 3.16.0-46-generic #62~14.04.1-Ubuntu SMP Tue Aug 11
16:28:19 UTC 2015 i686 i686 i686 GNU/Linux

uli@ankerklause:~/.../dlna/wdmr$ aptitude show libasound2
Package: libasound2
State: installed
Automatically installed: yes
Multi-Arch: same
Version: 1.0.27.2-3ubuntu7
Priority: optional
Section: libs
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Architecture: i386
Uncompressed Size: 1'208 k
Depends: libc6 (>= 2.16), libasound2-data (>= 1.0.27.2-3ubuntu7)
PreDepends: multiarch-support
Suggests: libasound2-plugins (>= 1.0.24)
Breaks: bluez-alsa (<= 4.94-2), libasound2-plugin-equal (<= 0.6-1),
libasound2-plugins (< 1.0.24)
Provided by: liboss4-salsa-asound2
Description: shared library for ALSA applications
This package contains the ALSA library and its standard plugins, as well
as the required configuration files.

ALSA is the Advanced Linux Sound Architecture.
Homepage: http://www.alsa-project.org/

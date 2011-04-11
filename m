From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: GPL/LGPL licensing of the Alsa library
Date: Mon, 11 Apr 2011 15:58:28 +0200
Message-ID: <4DA30904.6020503@ladisch.de>
References: <5B9D7D28-C10D-42D5-9BB1-675103BC0957@neolex.fi>	<4D904E11.8020003@ladisch.de>
	<BANLkTikm=M_uR9LGAkp_yhHMLtEr+vVRiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id D8C2A1037EE
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 15:57:32 +0200 (CEST)
In-Reply-To: <BANLkTikm=M_uR9LGAkp_yhHMLtEr+vVRiA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ossi Niiranen <oniiranen@neolex.fi>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ossi Niiranen wrote:
> The source code distribution of the package we reviewed does not seem to
> include the hdspm.h file you refer to below nor the UCM files. Does that
> mean the distribution is in some way "broken"?

No, I just used whatever alsa-lib I had lying around, about 1.0.24.

> Ours did include also the sndop-mixer files which seem to be licensed under
> the GPL as well (although at least one of them does not necessarily warrant
> copyright protection as it is just a few lines).

I just searched for "GNU General"; this string isn't in these files.
I'm happy to see that your research is more thorough.  :-)

> You made some generic comments in your email about why the GPL licensing is
> not an issue. If you have the time and the interest (there is obviously no
> obligation), I'd wish to take that a bit further into a file specific
> analysis (as we need certainty on a file level to be able to see there is no
> risk).

OK

> For example, you say that aserver is "separate". Does that mean it is
> not shipped with the Alsa library? The impression I got from another
> response to my earlier post was that it is a legacy technology but still
> shipped with the library. If that's the case, I could not simply say that
> there are no GPL issues without further information on how this legacy tech
> is used.

The aserver executable is shipped _with_ the ALSA library, but it is not
part of the library itself; applications that use the ALSA library do
not use aserver directly.

The ALSA library offers an API that allows application to access sound
devices.  Furthermore, the library contains several plugins that
implement the actual access to specific devices, as well as other
plugins that modify the sound data (e.g., sample rate conversion) and
redirect the result to another plugin.

In most cases, the plugin at the bottom of this stack is the "hw" plugin
which interfaces with the ALSA drivers in the kernel.

There are the "shm" and "share" plugins that use sockets to talk with
the aserver program, which runs as a separate process and also uses
alsa-lib to access the actual sound device.  The goal of this is to
allow multiple programs to share this sound device.

Applications that link to the ALSA library use only the public API and
typically do not know which plugin(s) are used to implement the device;
the plugin configuration is read by alsa-lib from some machine-specific
.conf files.  (I wrote "typically" because it is possible for
applications to create their own configuration from scratch.)

Nowadays, the plugins that use aserver are considered legacy because
the dshare and dmix plugins allow the same sharing without having to run
a separate server program.

In conclusion, applications that use alsa-lib are not "derived from" or
"based on" the aserver program (in any interpretation of these clauses);
this falls clearly under the "mere aggregation" clause of the GPL.

> include/sound/asound.h
> include/sound/asoundef.h
> include/sound/asequencer.h

These files are copies of the respective kernel files and define the
interface between the kernel and the hw plugins.

> include/sound/asound_fm.h
> include/sound/emu10k1.h
> include/sound/hdsp.h
> include/sound/sb16_csp.h

These files are copies of the respective kernel files and define
interfaces that applications can use to directly access certain
hardware-dependent parts of these drivers.

The ALSA library uses only the system calls defined in these kernel
headers, so it is not derived from the kernel.

> m4/attributes.m4

Parts of this file are copied into the configure script when running
Autoconf.  This falls under the Autoconf exception.

> alsa-lib/test/latency.c
> alsa-lib/test/oldapi.c
> alsa-lib/test/playmidi1.c

The test programs are neither used by nor shipped with the compiled
alsa-lib.

> *.alisp

As far as I can tell, these files are not actually used anywhere.


Regards,
Clemens

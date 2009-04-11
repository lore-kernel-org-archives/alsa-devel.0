From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: DELL SP2309W Monitor with Integrated microphone
Date: Fri, 10 Apr 2009 21:23:42 -0400
Message-ID: <75b66ecd0904101823l4a34e297u1246a4ff6117643f@mail.gmail.com>
References: <1239411042.15067.41.camel@sundance.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E4612436D
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Apr 2009 03:23:43 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 4so1009142yxp.2
	for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2009 18:23:42 -0700 (PDT)
In-Reply-To: <1239411042.15067.41.camel@sundance.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Phil Gorbett <pgorbett@usc.edu.au>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 10, 2009 at 8:50 PM, Phil Gorbett <pgorbett@usc.edu.au> wrote:
> Any luck anyone with this one yet? =A0I too have the same issue as that
> posted previously (last month), and get the same results with the
> indicative testing. =A0I have tried several fixes via googling - module
> loading and sound "card" indexing via alsa.base modprobe file and LOTS
> of others. =A0Still no luck. =A0I am running FC10 with pulse, but think i=
t's
> probably a snd-usb-audio problem as the driver appears to be correctly
> loading and the webcam is clearly indicated in the sound prefs app and
> gconf/gstreamer.

Try disabling pulse and run:

arecord -v -f cd -D plughw:0 file.wav

Does file.wav contain any audio?  What does arecord output?

Lee

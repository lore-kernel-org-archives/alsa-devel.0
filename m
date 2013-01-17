From: Rene Herman <rene.herman@gmail.com>
Subject: libao problem (Re: No dmix/dsnoop on Intel ICH4/5 by
 default?)
Date: Thu, 17 Jan 2013 11:22:27 +0100
Message-ID: <50F7D0E3.3020401@gmail.com>
References: <50F6FF00.7020706@gmail.com> <50F71312.1000009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.gn.mail.iss.as9143.net (smtpq1.gn.mail.iss.as9143.net
 [212.54.34.164])
 by alsa0.perex.cz (Postfix) with ESMTP id EC085265142
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 11:22:28 +0100 (CET)
In-Reply-To: <50F71312.1000009@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, vorbis-dev@xiph.org
List-Id: alsa-devel@alsa-project.org

On 16-01-13 21:52, Clemens Ladisch wrote:

> Rene Herman wrote:

>> I'm out of touch of with alsa -- but should dmix/dsnoop still be
>> enabled by default on hardware that doesn't do hardware mixing?
>
> Yes.
>
>> I believe that it should be from /usr/share/alsa/cards/ICH4.conf,
>> but I don't get mixing on this setup when using the "default"
>> pcm...
>
> What's the output of "aplay -v something.wav"?

I won't bother you with that, since things do in fact work with aplay. 
It seems I'm looking at a libao problem.

Specifically: I can mix as many streams as I want using just "aplay" but 
if I start by playing one track with "ogg123" (which uses a default, 
unconfigured libao as its backend), I can't start a second ogg123, which 
then says:

===
ao_alsa WARNING: Unable to open surround playback.  Trying default device...
ALSA lib pcm_dmix.c:1018:(snd_pcm_dmix_open) unable to open slave
ao_alsa ERROR: Unable to open ALSA device 'default' for playback => 
Device or resource busy
ERROR: Cannot open device alsa.
===

I CAN still start an "aplay" at this point though. Moreover, things get 
weirder when I start with aplay. With one aplay running, I CAN start two 
additional ogg123 instances.

... so, err, ehm, err, what? :-)

This now seems at best related to ALSA in a secondary manner, and I'm 
CCing this to vorbis-dev (which I believe is the right email contact for 
libao?) but if you know of something of interest...

For vorbis-dev: this is on arch linux, (standard) kernel 3.6.11-1-ARCH, 
alsa-{lib,plugins,utils}-1.0.26-1, libao-1.1.0-2 and vorbis-tools-1.4.0-3.

Regards,
Rene

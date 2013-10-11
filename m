From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: [Portaudio] Recording devices opened mono still
	sending stereo causing corrupt audio
Date: Fri, 11 Oct 2013 14:07:14 +0100
Message-ID: <201310111407.14308.gineera@aspect135.co.uk>
References: <52575722.7060208@mixxx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net
 [62.24.128.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 7800A261A1B
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 15:06:32 +0200 (CEST)
In-Reply-To: <52575722.7060208@mixxx.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Portaudio Mailing List <portaudio@music.columbia.edu>
Cc: mixxx-devel <mixxx-devel@lists.sourceforge.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Friday 11 October 2013 02:40, Sean M. Pappalardo - D.J. Pegasus wrote:
> I'm a developer for Mixxx, the cross-platform open-source DJ software
> which uses PortAudio and we've been trying for a long time to track down
> the cause of "horrible mic sound" as documented in our bug:
> https://bugs.launchpad.net/mixxx/+bug/900364
> The resulting recorded audio sounds about 50-60% lower pitch with
> crackles and it only happens with the ALSA API on Linux and only with
> certain (mostly Intel-based) audio devices.
>
> I have just discovered by testing in Audacity (which also uses PA) that
> the problem occurs when PA (and therefore ALSA) is asked to open just
> one channel of a sound input device yet the device (or ALSA) seems to
> stream two anyway. I have been able to reproduce the problem in Audacity
> (which also uses PA) when selecting the ALSA API and mono recording, but
> it works correctly when I change it to stereo recording.
>
> I'm suspecting there's a miscommunication between PA and ALSA or ALSA
> and the sound hardware where either the lower level is saying its
> input(s) can only be opened in stereo and the higher level (or the
> application above it) ignores that, or the lower level says it's fine
> opening mono but then misbehaves.
>
> How can I find out which, whether it's ALSA, PA, or the sound hardware
> at fault?

As one of those involved with Portaudio-Alsa, I have had a read through the 
Mixx bug record (900364).  I don't have any immediate candidates for the 
cause, but here are a number of suggestions/questions that may help 'close 
in' on the problem; any of these may give more insight.

Is the trouble ALWAYS associated with a duplex stream - ie does the Mic always 
record fine when there is no simultaneous output to the same device?  It may 
be that Portaudio is mis-handling this case, mono input with stereo output.

Look at un-compressed bad recording (perhaps with Audacity) - are the samples 
obviously duplicated (each level twice)?  Perhaps post a short wav (1 sec) or 
a screen shot.  The compressed files don't show this, but may be smoothing it 
out.

Is Pulseaudio running on these systems?  If so, try with that disabled 
(pasuspender...) - in fact, for testing it is best to eliminate any effects 
it may introduce unless it is implicated.

What Portaudio devices does this occur with?  Is it only default/sysdefault, 
or with the 'hw' devices?.  If the hw ones, try setting the environment 
variable PA_ALSA_PLUGHW to 1 before running the Mixx app in a terminal and 
report if there is any change - that will enable channel adaption in Alsa.

Build the app with Portaudio debug enabled ( --enable-debug-output or define 
PA_ENABLE_DEBUG_OUTPUT) and see the terminal output.  Perhaps post it in 
non-working case.

Build Portaudio stand-alone and run the test/example program pa_devs on the 
troublesome system so we can see how the capabilities are reported.

There may be issues with how different Alsa soundcard drivers treat mono 
microphone inputs.  Some may output the same data to both channels, and 
return twice as much data as expected.  Pulseaudio, if operating, may also do 
copying.

Hope this gives some avenues to pursue!

Regards

Alan

From: "Sean M. Pappalardo - D.J. Pegasus" <spappalardo@mixxx.org>
Subject: Recording devices opened mono still sending stereo
 causing corrupt audio
Date: Thu, 10 Oct 2013 18:40:50 -0700
Message-ID: <52575722.7060208@mixxx.org>
Reply-To: Portaudio Mailing List <portaudio@music.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <portaudio-bounces@music.columbia.edu>
List-Unsubscribe: <http://music.columbia.edu/mailman/options/portaudio>,
	<mailto:portaudio-request@music.columbia.edu?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/portaudio>
List-Post: <mailto:portaudio@music.columbia.edu>
List-Help: <mailto:portaudio-request@music.columbia.edu?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/portaudio>,
	<mailto:portaudio-request@music.columbia.edu?subject=subscribe>
Errors-To: portaudio-bounces@music.columbia.edu
Sender: portaudio-bounces@music.columbia.edu
To: Portaudio Mailing List <portaudio@music.columbia.edu>, alsa-devel@alsa-project.org
Cc: mixxx-devel <mixxx-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

(Re-sending including alsa-devel and more information.)

Hello there.

I'm a developer for Mixxx, the cross-platform open-source DJ software 
which uses PortAudio and we've been trying for a long time to track down 
the cause of "horrible mic sound" as documented in our bug: 
https://bugs.launchpad.net/mixxx/+bug/900364
The resulting recorded audio sounds about 50-60% lower pitch with 
crackles and it only happens with the ALSA API on Linux and only with 
certain (mostly Intel-based) audio devices.

I have just discovered by testing in Audacity (which also uses PA) that 
the problem occurs when PA (and therefore ALSA) is asked to open just 
one channel of a sound input device yet the device (or ALSA) seems to 
stream two anyway. I have been able to reproduce the problem in Audacity 
(which also uses PA) when selecting the ALSA API and mono recording, but 
it works correctly when I change it to stereo recording.

I'm suspecting there's a miscommunication between PA and ALSA or ALSA 
and the sound hardware where either the lower level is saying its 
input(s) can only be opened in stereo and the higher level (or the 
application above it) ignores that, or the lower level says it's fine 
opening mono but then misbehaves.

How can I find out which, whether it's ALSA, PA, or the sound hardware 
at fault?

Sincerely,
Sean M. Pappalardo
"D.J. Pegasus"
Mixxx Developer - Controller Specialist

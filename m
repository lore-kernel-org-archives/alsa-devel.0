From: "S. Aguinaga" <sa_jr@yahoo.com>
Subject: problem persist on Mac Pro (quad pro) using fedora 9
Date: Mon, 27 Oct 2008 10:33:35 -0700 (PDT)
Message-ID: <545468.84884.qm@web65603.mail.ac4.yahoo.com>
Reply-To: "S. Aguinaga" <sa_jr@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web65603.mail.ac4.yahoo.com (web65603.mail.ac4.yahoo.com
	[76.13.9.71]) by alsa0.perex.cz (Postfix) with SMTP id 002D124335
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 18:33:36 +0100 (CET)
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

Hello Team,

I'm hoping that some of you folks might know the work-around and or fix to my  Mac Pro (quad core)
installation of alsa ( on fedora 9 ).

I wanted to get the record to work copied the same thing I did on my laptop MacBook Pro, which is 
working ( to some extent, such as with audacity ), but on the Mac Pro tower it has gotten worse.  
I used to have audio on the front speaker, and now I have none. And I'm not sure what else to try.

aplay 1.wav does not generate sound, but alsamixer seems to have all ports on and looking ok.

1.    /etc/modprobe.d/sound reads:
options snd-hda-intel model=macpro
2.    ~/.asound reads ( but my gui volume controls tools don't work ) ... I'm wondering 
if there anyway to not rely on pulseaudio or if I need to have pulseaudio working on my
fedora 9 installation.

pcm.pulse{
    type pulse
}
ctl.pulse { 
    type pulse
}
pcm.phononpulse {
    type plug
    slave.pcm {
        type pulse
    }
      hint {
        show on
        description "PulseAudio"
    }
}

3. the file /etc/asound.conf reads the following ... so I wonder if this is enough and should I erase .asoundrc ?
If so, what else do I need to get  audio working.  
pcm.!default { 
        type hw
        card Intel
}
ctl.!default {
        type hw
        card Intel
}

I also have asound.state and where should I check to see if it is ok?

// Sal 
// Northwestern University - HARP

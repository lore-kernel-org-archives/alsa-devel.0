From: "Fabien COMTE" <fabien.comte@ercogener.com>
Subject: Re: Asterisk and ALSA/Jack
Date: Sat, 3 Oct 2009 15:12:14 +0200
Message-ID: <11453.5307082862$1254727836@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 3744F1037EA
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Oct 2009 15:12:22 +0200 (CEST)
References: 
In-Reply-To: 
Content-Language: fr
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I want to use Asterisk with ALSA / Jack audio.

I tried the next configurations :

1 ) app_jack.so -> does not work.

2 ) chan_alsa.so without jackd started
my .asoundrc :
pcm.!default =

{
    type hw
    card 1
}
pcm.jack1 {
    type jack
    playback_ports {
        0 alsa_pcm:playback_1
        1 alsa_pcm:playback_2
    }
    capture_ports {
        0 alsa_pcm:capture_1
        1 alsa_pcm:capture_2
    }
}

pcm.jack1b {
    type plug
    device jack1b
    server linux

	=

    slave {
    	 pcm "jack1"
        rate 8000
        format FLOAT
	 channels 2
    }
}

ctl.mixer0 {
    type hw
    card 1
}

in alsa.conf=A0:
input_device=3Ddefault
output_device=3Ddefault

That works fine.

3 ) chan_alsa.so with jackd started
Jackd launch command :
jackd --port-max 16 --realtime --no-mlock -d alsa --playback hw:1,0
--capture hw:1,0 --rate 8000 --period 1024 --shorts --inchannels 2
--outchannels 2 --dither triangular &

my .asoundrc :

pcm.!default =

{
    type plug
    slave {
    	 pcm "jack1"
        rate 8000
        format FLOAT
	 channels 2
    }
}
pcm.jack1 {
    type jack
    playback_ports {
        0 alsa_pcm:playback_1
        1 alsa_pcm:playback_2
    }
    capture_ports {
        0 alsa_pcm:capture_1
        1 alsa_pcm:capture_2
    }
}

pcm.jack1b {
    type plug
    device jack1b
    server linux

	=

    slave {
    	 pcm "jack1"
        rate 8000
        format FLOAT
	 channels 2
    }
}


ctl.mixer0 {
    type hw
    card 1
}

in alsa.conf=A0:
input_device=3Ddefault
output_device=3Ddefault

It doesn't work. Asterisk outputs are :
[Oct  3 10:34:50] ERROR[1364]: chan_alsa.c:175 alsa_card_init: snd_pcm_open
failed: No such file or directory
[Oct  3 10:34:50] ERROR[1364]: chan_alsa.c:175 alsa_card_init: snd_pcm_open
failed: No such file or directory
[Oct  3 10:34:50] ERROR[1364]: chan_alsa.c:272 soundcard_init: Problem
opening ALSA I/O devices

But aplay my_test_file.wav works fine and arecord too...

Does anyone have an idea ?

Thanks,

Fabien

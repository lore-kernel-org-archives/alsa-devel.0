From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Asterisk and ALSA/Jack
Date: Mon, 05 Oct 2009 10:02:33 +0200
Message-ID: <4AC9A819.3000900@ivitera.com>
References: <000101ca442b$20b13f90$6213beb0$@comte@ercogener.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FC6C103800
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 10:02:08 +0200 (CEST)
In-Reply-To: <000101ca442b$20b13f90$6213beb0$@comte@ercogener.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabien COMTE <fabien.comte@ercogener.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fabien COMTE wrote:
> Hi,
> 
> I want to use Asterisk with ALSA / Jack audio.
> 
> I tried the next configurations :
> 
> 1 ) app_jack.so -> does not work.
> 
> 2 ) chan_alsa.so without jackd started
> my .asoundrc :
> pcm.!default 
> {
>     type hw
>     card 1
> }
> pcm.jack1 {
>     type jack
>     playback_ports {
>         0 alsa_pcm:playback_1
>         1 alsa_pcm:playback_2
>     }
>     capture_ports {
>         0 alsa_pcm:capture_1
>         1 alsa_pcm:capture_2
>     }
> }
> 
> pcm.jack1b {
>     type plug
>     device jack1b
>     server linux
> 
> 	
>     slave {
>     	 pcm "jack1"
>         rate 8000
>         format FLOAT
> 	 channels 2
>     }
> }
> 
> ctl.mixer0 {
>     type hw
>     card 1
> }
> 
> in alsa.conf :
> input_device=default
> output_device=default
> 
> That works fine.
> 
> 3 ) chan_alsa.so with jackd started
> Jackd launch command :
> jackd --port-max 16 --realtime --no-mlock -d alsa --playback hw:1,0
> --capture hw:1,0 --rate 8000 --period 1024 --shorts --inchannels 2
> --outchannels 2 --dither triangular &
> 
> my .asoundrc :
> 
> pcm.!default 
> {
>     type plug
>     slave {
>     	 pcm "jack1"
>         rate 8000
>         format FLOAT
> 	 channels 2
>     }
> }
> pcm.jack1 {
>     type jack
>     playback_ports {
>         0 alsa_pcm:playback_1
>         1 alsa_pcm:playback_2
>     }
>     capture_ports {
>         0 alsa_pcm:capture_1
>         1 alsa_pcm:capture_2
>     }
> }
> 
> pcm.jack1b {
>     type plug
>     device jack1b
>     server linux
> 
> 	
>     slave {
>     	 pcm "jack1"
>         rate 8000
>         format FLOAT
> 	 channels 2
>     }
> }
> 
> 
> ctl.mixer0 {
>     type hw
>     card 1
> }
> 
> in alsa.conf :
> input_device=default
> output_device=default
> 
> It doesn't work. Asterisk outputs are :
> [Oct  3 10:34:50] ERROR[1364]: chan_alsa.c:175 alsa_card_init: snd_pcm_open
> failed: No such file or directory
> [Oct  3 10:34:50] ERROR[1364]: chan_alsa.c:175 alsa_card_init: snd_pcm_open
> failed: No such file or directory
> [Oct  3 10:34:50] ERROR[1364]: chan_alsa.c:272 soundcard_init: Problem
> opening ALSA I/O devices
> 
> But aplay my_test_file.wav works fine and arecord too...
> 
> Does anyone have an idea ?
> 
Does asterisk run under the same user as the .asoundrc is defined for?

Since your card is nb. 1, perhaps asterisk uses a default configuration
for card0 which may not be present on your system.


Pavel.

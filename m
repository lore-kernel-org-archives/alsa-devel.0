From: Pablo Fonovich <pablo_f_7@hotmail.com>
Subject: Re: PCM3168 alsa driver for beaglebone black (Pablo
	Fonovich)
Date: Thu, 7 Jan 2016 15:35:24 -0300
Message-ID: <BAY169-W20D6BAD1989477CC899ABEEEF50@phx.gbl>
References: <mailman.205.1452101441.813.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from BAY004-OMC3S20.hotmail.com (bay004-omc3s20.hotmail.com
 [65.54.190.158])
 by alsa0.perex.cz (Postfix) with ESMTP id 22780260439
 for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2016 19:35:25 +0100 (CET)
In-Reply-To: <mailman.205.1452101441.813.alsa-devel@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi:
Now my driver is working (just) a bit better, but is still not functional... when i try to play something it says:

davinci_evm sound: ASoC: machine hw_params failed: -524
aplay: set_params:1297: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (125011 125012)
PERIOD_SIZE: 5513
PERIOD_BYTES: 22052
PERIODS: 4
BUFFER_TIME: (500045 500046)
BUFFER_SIZE: 22052
BUFFER_BYTES: 88208
TICK_TIME: 0

Some hints or docummentation of this? remember i'm a noob
Thanks


> Message: 2
> Date: Tue, 5 Jan 2016 21:35:12 -0300
> From: Pablo Fonovich <pablo_f_7@hotmail.com>
> To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
> Subject: [alsa-devel] PCM3168 alsa driver for beaglebone black
> Message-ID: <BAY169-W8142231FA115FDA205200FEEF40@phx.gbl>
> Content-Type: text/plain; charset="iso-8859-1"
> 
> Hi:
> I'm working in a project of making an audio cape for beaglebone black with pcm3168 codec... so far i've written the driver i've attached based on pcm1681.c available in linux kernel.
> Im a noob in this subjets, so i would like to know how can now make it work in my custom system for the beaglebone. 
> I followed the guide in this link http://processors.wiki.ti.com/index.php/Sitara_Linux_Audio_DAC_Example, but it makes me write the ops and hw structures that i already have in my pcm3168.c file, in the davinci_evm.c file.
> 
> The drivers compiles and is detected at boot time, as it says in the guide. But when i type aplay command to play some wav, the message "ALSA lib pcm.c:2267:(snd_pcm_open_noupdate) Unknown PCM default
> aplay: main:722: audio open error: No such file or directory" appears, so i'm missing something...
> 
> I don't knwo if this post belongs to this list, but any help would be great...
> If some docummentation about writing a driver for an embedded system is available, please tell me... 
> Also, if someone can suggest me some guidelines of work i would be grateful, cause i just can't get organized with the information i found
> 
> Thanks very Much... 
> 
> Pablo
> 
>  		 	   		  
> -------------- next part --------------
> An embedded and charset-unspecified text was scrubbed...
> Name: pcm3168.c
> URL: <http://mailman.alsa-project.org/pipermail/alsa-devel/attachments/20160105/f0bcc63c/attachment-0001.c>
> 

 		 	   		  

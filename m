From: James Wright <james@jigsawdezign.com>
Subject: Re: Resource temporarily unavailable?
Date: Mon, 23 Feb 2004 02:05:52 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040223020552.6e3bc8ff.james@jigsawdezign.com>
References: <20040223012510.4fe96823.james@jigsawdezign.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040223012510.4fe96823.james@jigsawdezign.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


  Ok, please ignore this thread its my own fault... i was not exiting a loop properly (screwed up my buffer_size variable
when i fixed the compile time errors), which in turn caused too many writes to the pcm device... 


Apologies,
James



On Mon, 23 Feb 2004 01:25:10 +0000
James Wright <james@jigsawdezign.com> wrote:

> 
>    A few days ago i upgraded from kernel 2.6.1 to 2.6.3 and also grabbed alsa-lib, alsa-utils, alsa-oss versions 1.0.2. Today i try and compile my sound routines, and have a few compile time errors regarding passing
> integers instead of pointers to snd_pcm_hw_params_set_rate_near(), which was easily fixed, but now when i try
> and do a snd_pcm_mmap_writen() or snd_pcm_writen() i get the error "Resource temporarily unavailable". I'm totally
> stumped, as i haven't changed anything else...
> 
> here's some system info:
> 
> Advanced Linux Sound Architecture Driver Version 1.0.2c (Thu Feb 05 15:41:49 2004 UTC).
> Compiled on Feb 19 2004 for kernel 2.6.3 (SMP).
> 
> 
> 0 [Live           ]: EMU10K1 - Sound Blaster Live!
>                      Sound Blaster Live! (rev.7) at 0xb800, irq 23
> 
> 
> [james@neutrino asound]$ more pcm    
> 00-00: emu10k1 : EMU10K1 : playback 32 : capture 1
> 00-01: emu10k1 mic : EMU10K1 MIC : capture 1
> 00-02: emu10k1 efx : EMU10K1 EFX : capture 1
> 00-03: emu10k1 : EMU10K1 FX8010 : playback 8
> 
> 
> Thanks,
> James
> 
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

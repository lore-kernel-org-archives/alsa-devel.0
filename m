From: "Adriano Grassi" <califalcon@gmail.com>
Subject: Re: Acer Aspire 9810 hda-intel RealTek ALC883 no sound
	thru speakers only via SPDIF/Headphones.
Date: Mon, 2 Jul 2007 12:01:03 -0400
Message-ID: <5cd1dd0707020901p3cd7726eq7fd17cf77ce7842@mail.gmail.com>
References: <1183183634.31906.17.camel@XTTG-Mob1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 28A68103888
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jul 2007 18:01:04 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so333481ana
	for <alsa-devel@alsa-project.org>; Mon, 02 Jul 2007 09:01:03 -0700 (PDT)
In-Reply-To: <1183183634.31906.17.camel@XTTG-Mob1>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa Development Project <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Anyone have any Idea on how to solve this problem? Is this chipset even
supported ALC883?

Thanks.



On 6/30/07, Adrian Grassi <califalcon@gmail.com> wrote:
>
> Hi guys, I have a Acer Aspire 9810 with hda-intel realtek ALC883 chipset
> and no matter what version of alsa and ditribution I try I only get
> sound thru the shared SPDIF/Headphone Jack.
>
> This laptop has a built in 2.1 power speaker system which works fine
> under windows but not in any linux distro's I have tried:
>
> Ubuntu 7.04 - Kubuntu 7.04 - Suse 10.2 - Ubuntu Gutsy 7.10 Beta -
> Mandriva Spring 2007.1
>
> I think this is a configuration issue however I can't find any info
> anywhere on how to fix it, I did find a few posts where several people
> are having the same issue.
>
> Can someone please shed some light on how to fix this issue, if any
> additional information is needed please let me know, I have been trying
> to solve this for over 5 days now and is driving me bananas.
>
>
>
>
> Here is the aadebug from alsa-wiki:
>
>
> Debug INFO
> ALSA Audio Debug v0.1.0 - Sat Jun 30 02:01:40 EDT 2007
> http://alsa.opensrc.org/aadebug
> http://www.gnu.org/licenses/gpl.txt
>
> Kernel ----------------------------------------------------
> Linux XTTG-Mob1 2.6.22-7-generic #1 SMP Mon Jun 25 17:33:14 GMT 2007
> i686 GNU/Linux
>
> Loaded Modules --------------------------------------------
> snd_hda_intel         256024  1
> snd_pcm_oss            44672  0
> snd_mixer_oss          17664  1 snd_pcm_oss
> snd_pcm                80388  3 snd_hda_intel,saa7134_alsa,snd_pcm_oss
> snd_seq_dummy           4740  0
> snd_seq_oss            33152  0
> snd_seq_midi            9600  0
> snd_rawmidi            25728  1 snd_seq_midi
> snd_seq_midi_event      8448  2 snd_seq_oss,snd_seq_midi
> snd_seq                53232  6
> snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
> snd_timer              24324  2 snd_pcm,snd_seq
> snd_seq_device          9228  5
> snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
> snd                    54660  12
>
> snd_hda_intel,saa7134_alsa,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
> snd_page_alloc         10888  2 snd_hda_intel,snd_pcm
>
> Modprobe Conf ---------------------------------------------
> Warning: module config file does not exist
> This means any kernel modules will not be auto loaded
> See your linux distro docs on how to create this file
>
> Proc Asound -----------------------------------------------
> Advanced Linux Sound Architecture Driver Version 1.0.14 (Thu May 31
> 09:03:25 2007 UTC).
> 0 [Intel          ]: HDA-Intel - HDA Intel
>                       HDA Intel at 0xd2300000 irq 23
> 1 [SAA7134        ]: SAA7134 - SAA7134
>                       saa7133[0] at 0xd2005000 irq 16
>   2:        : timer
>   3:        : sequencer
>   4: [ 1- 0]: digital audio capture
>   5: [ 1]   : control
>   6: [ 0- 2]: digital audio capture
>   7: [ 0- 0]: digital audio playback
>   8: [ 0- 0]: digital audio capture
>   9: [ 0]   : control
> cat: /proc/asound/hwdep: No such file or directory
> 01-00: SAA7134 PCM : SAA7134 PCM : capture 1
> 00-02: ALC883 Analog : ALC883 Analog : capture 2
> 00-00: ALC883 Analog : ALC883 Analog : playback 1 : capture 2
> Client info
>   cur  clients : 3
>   peak clients : 3
>   max  clients : 192
>
> Client   0 : "System" [Kernel]
>   Port   0 : "Timer" (Rwe-)
>   Port   1 : "Announce" (R-e-)
>     Connecting To: 15:0
> Client  14 : "Midi Through" [Kernel]
>   Port   0 : "Midi Through Port-0" (RWe-)
> Client  15 : "OSS sequencer" [Kernel]
>   Port   0 : "Receiver" (-we-)
>     Connected From: 0:1
>
> Dev Snd ---------------------------------------------------
> controlC0  controlC1  pcmC0D0c  pcmC0D0p  pcmC0D2c  pcmC1D0c  seq  timer
>
> CPU -------------------------------------------------------
> model name      : Intel(R) Core(TM)2 CPU         T7200  @ 2.00GHz
> cpu MHz         : 2000.000
> model name      : Intel(R) Core(TM)2 CPU         T7200  @ 2.00GHz
> cpu MHz         : 2000.000
>
> RAM -------------------------------------------------------
> MemTotal:      2074528 kB
> SwapTotal:     1951888 kB
>
> Hardware --------------------------------------------------
> 00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and
> 945GT Express Memory Controller Hub (rev 03)
> 09:04.0 Multimedia controller: Philips Semiconductors SAA7133/SAA7135
> Video Broadcast Decoder (rev d1)
> 09:06.2 Mass storage controller: Texas Instruments 5-in-1 Multimedia
> Card Reader (SD/MMC/MS/MS PRO/xD)
>
>
>


-- 
Thank you for your time.

Best regards,

From: "Yuan, Hang" <hang.yuan@intel.com>
Subject: RE: 2.6.12 sound problem
Date: Fri, 29 Jul 2005 18:21:11 +0800
Message-ID: <4811572DEBA3F04E9E6C269B321042650105FE8A@bjsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: sclark46@earthlink.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----Original Message-----
From: alsa-devel-admin@lists.sourceforge.net =
[mailto:alsa-devel-admin@lists.sourceforge.net] On Behalf Of Stephen =
Clark
Sent: 2005=C4=EA7=D4=C228=C8=D5 22:12
To: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] 2.6.12 sound problem

Stephen Clark wrote:

>Hello List,
>
>
>I recently upgraded my laptop, HP Pavilion N5430, from a 2.4.21 kernel
>to 2.6.12. As a result of
>doing this my sound no longer works correctly. It plays the same thing
>repeatedly some number
>of times - if it plays at all.
>
>Any ideas on how to debug this would be appreciated.
>
>Additional info I don't see any interrupts in /proc/interrupts for the=20
>Allegro which is on int 5.
>I just tried the same laptop with knoppix and a 2.4.27 kernel and sound =

>works great and I do
>see interrupts for Allegro on int 5.
>
>
>Thanks,
>Steve
>
>aplay -v and aadebug output follow.
>
>root@joker4 ~]# aplay -v /usr/share/apps/kget/sounds/started.wav
>Playing WAVE '/usr/share/apps/kget/sounds/started.wav' : Unsigned 8 =
bit,
>Rate 11128 Hz,Mono
>Plug PCM: Hardware PCM card 0 'ESS Allegro PCI' device 0 subdevice 1
>
>Its setup is:
>stream       : PLAYBACK
>access       : RW_INTERLEAVED
>format       : U8
>subformat    : STD
>channels     : 1
>rate         : 11128
>exact rate   : 11128 (11128/1)
>msbits       : 8
>buffer_size  : 5564
>period_size  : 1391
>period_time  : 125000
>tick_time    : 1000
>tstamp_mode  : NONE
>period_step  : 1
>sleep_min    : 0
>avail_min    : 1391
>xfer_align   : 1391
>start_threshold  : 5564
>stop_threshold   : 5564
>silence_threshold: 0
>silence_size : 0
>boundary     : 1458569216
>aplay: pcm_write:1171: write error: Input/output error
>
>aadebug output:
>ALSA Audio Debug v0.0.9 - Mon Jul 25 14:49:10 EDT 2005
>http://alsa.opensrc.org/?page=3Daadebug
>
>Kernel ----------------------------------------------------
>Linux joker4.seclark.com 2.6.12-prep #1 Sun Jul 24 22:39:46 EDT 2005
>i686 athlon i386 GNU/Linux
>
>Loaded Modules --------------------------------------------
>snd_maestro3           25252  2
>snd_ac97_codec         76408  1 snd_maestro3
>snd_seq_dummy           3972  0
>snd_seq_oss            37760  0
>snd_seq_midi_event      9600  1 snd_seq_oss
>snd_seq                62992  5 =
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
>snd_seq_device          9228  3 snd_seq_dummy,snd_seq_oss,snd_seq
>snd_pcm_oss            51760  0
>snd_mixer_oss          18304  1 snd_pcm_oss
>snd_pcm               100744  4 snd_maestro3,snd_ac97_codec,snd_pcm_oss
>snd_timer              33924  2 snd_seq,snd_pcm
>snd_page_alloc         10116  1 snd_pcm
>snd                    57860  12
>snd_maestro3,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_o=
ss,snd_mixer_oss,snd_pcm,snd_timer
>
>Modprobe Conf ---------------------------------------------
>alias snd-card-0 snd-maestro3
>options snd-card-0 index=3D0
>options snd-maestro3 index=3D0
>remove snd-maestro3 { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ;
>}; /sbin/modprobe -r --ignore-remove snd-maestro3
>
>Proc Asound -----------------------------------------------
>Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24
>10:33:392005 UTC).
>0 [PCI            ]: Allegro - ESS Allegro PCI
>                       ESS Allegro PCI at 0x1400, irq 5
>    1:       : sequencer
>   16: [0- 0]: digital audio playback
>   24: [0- 0]: digital audio capture
>    0: [0- 0]: ctl
>   33:       : timer
>00-00: Allegro : Allegro : playback 2 : capture 1
>
>Dev Snd ---------------------------------------------------
>controlC0  pcmC0D0c  pcmC0D0p  seq  timer
>
>CPU -------------------------------------------------------
>model name      : mobile AMD Duron(tm) Processor
>cpu MHz         : 299.999
>
>RAM -------------------------------------------------------
>MemTotal:       255652 kB
>SwapTotal:      524280 kB
>
>Hardware --------------------------------------------------
>00:00.0 Host bridge: ALi Corporation M1647 Northbridge [MAGiK 1 /
>MobileMAGiK 1] (rev 04)
>00:08.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1
>(rev 12)
>
> =20
>
I've downloaded the latest alsa 1.09rc4a and tried it with no success.=20
Is there anything I can do
to further troubleshoot this. I configured the sw --with-debug=3Dfull =
but=20
didn't see any additional output.
I am willing to get my hands dirty if someone will give me some=20
direction. This laptop is used by my teenage daughter and she has to=20
have sound ;).

Steve

Is the kernel in UP mode? If so, try SMP mode or enable "local APIC =
support", "I/O APIC support" and re-build UP kernel. I met the similar =
problem like you described and no interrupts were reported in =
/proc/interrupts. I don't know the exact reason. But the workaround =
above can solve the problem. Hope this method can also help you.

- Henry


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

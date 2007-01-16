From: difrost@poczta.onet.pl
Subject: Re: hwptr issue with CMI9880
Date: Tue, 16 Jan 2007 14:47:41 +0100
Message-ID: <20070116134743Z1213974-2997+146720@ps13.test.onet.pl>
References: <s5hhcuwgqi3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hhcuwgqi3.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

U=BFytkownik Takashi Iwai <tiwai@suse.de> napisa=B3:
>At Fri, 12 Jan 2007 12:12:39 +0100,
>difrost@poczta.onet.pl wrote:
>> =

>> Hi All.
>> =

>> Recently I bought new 5.1 speakers and was trying to set 5.1 surround
>> sound with Alsa 1.0.14rc1. I didn't managed to do that using all
>> knowledge that can be found in Uncle Google, so I went into debug mode
>> and found following message (I also added some more variable prints so
>> this is ,,extended'' message) in my kernel log:
>> =

>> Jan 12 23:30:45 slawek kernel: ALSA /NORA/SlaP4/tmp/alsa-driver-1.0.14rc=
1/acore/../alsa-kernel/cor
>> e/pcm_lib.c:207: Unexpected hw_pointer value [1] (stream =3D 0, delta: -=
3, max jitter =3D 2730, period
>> s =3D 4, period size =3D 0x555, hw_ptr_base =3D 0x0, new_hw_ptr =3D 0x55=
2, runtime->hw_ptr_interrupt =3D 0x0
>> , hw_ptr_interrupt =3D 0x555, pos =3D 0x552) : wrong interrupt acknowled=
ge?
>> Jan 12 23:30:45 slawek kernel:  [<e02a8ceb>] snd_pcm_period_elapsed+0x1e=
6/0x339 [snd_pcm]
>> Jan 12 23:30:45 slawek kernel:  [<e0068cf4>] azx_interrupt+0x52/0x95 [sn=
d_hda_intel]
>> Jan 12 23:30:45 slawek kernel:  [<c0131f75>] handle_IRQ_event+0x1a/0x3f
>> Jan 12 23:30:45 slawek kernel:  [<c01330ed>] handle_fasteoi_irq+0x7c/0xae
>> Jan 12 23:30:45 slawek kernel:  [<c0104f99>] do_IRQ+0x7d/0xa4
>> Jan 12 23:30:45 slawek kernel:  [<c01033ce>] common_interrupt+0x1a/0x20
>> Jan 12 23:30:45 slawek kernel:  [<c0100f2d>] mwait_idle_with_hints+0x3b/=
0x3f
>> Jan 12 23:30:45 slawek kernel:  [<c0100f3d>] mwait_idle+0xc/0x1b
>> Jan 12 23:30:45 slawek kernel:  [<c010193e>] cpu_idle+0x5e/0x74
>> Jan 12 23:30:45 slawek kernel:  [<c037b6ec>] start_kernel+0x338/0x340
>> Jan 12 23:30:45 slawek kernel:  [<c037b1ae>] unknown_bootoption+0x0/0x206
>> Jan 12 23:30:45 slawek kernel:  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =

>> =

>> AFAIK this message is harmless if it comes from snd_pcm_update_hw_ptr
>> but in this case it comes from snd_pcm_update_hw_ptr_interrupt. It
>> looks like irq is not handled correctly - I think (not sure, I'm not
>> expert in that field). Message occurs also with pci=3Dnoacpi
>> specified. I haven't tried single_cmd, but can do that if
>> necessary. I don't know whether it is kernel or sloppy hardware
>> problem.
>
>Or, might be a problem of reading the DMA pointer.
>Try module option position_fix=3D1, 2 or 3.
>

With posiotion_fix set to 3 above messages didn't shows up but sound is cra=
ppy  (so called ,,click noises''). With previous set, sound is OK. I think =
that this might be hardware problem because I still can't set 5.1 surround =
and no dmix working at all. Any ideas...how to fix this or where can I look=
 for solution?

BR, Jacek

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV

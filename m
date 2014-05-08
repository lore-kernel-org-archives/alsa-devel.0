From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda - using POS_FIX_LPIB on
	Broadwell HDMI Audio
Date: Thu, 8 May 2014 07:58:07 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D195233B1@SHSMSX103.ccr.corp.intel.com>
References: <1399485804-75028-1-git-send-email-libin.yang@intel.com>
 <s5hzjisq2kj.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D195232A6@SHSMSX103.ccr.corp.intel.com>
 <s5htx90q0mi.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19523313@SHSMSX103.ccr.corp.intel.com>
 <s5hr444pzap.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D1952333A@SHSMSX103.ccr.corp.intel.com>
 <s5hoaz8pydg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 804E32654AE
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 09:58:49 +0200 (CEST)
In-Reply-To: <s5hoaz8pydg.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I tested the non-snoop mode. It's worse than snoop mode. Only noise can be heard if using non-snoop mode.

I add the print in the function azx_position_ok(). The below is the dmesg:
[  119.509631] <0>posbuf: 26368, lpib: 16320, wallclk: 2330325
[  119.509674] snd_hda_intel 0000:00:03.0: IRQ timing workaround is activated for card #0. Suggest a bigger bdl_pos_adj.
[  119.509683] <0>posbuf: 26368, lpib: 16332, wallclk: 2331659
[  119.515467] <0>posbuf: 28224, lpib: 17444, wallclk: 2470504
[  119.523460] <0>posbuf: 30592, lpib: 18976, wallclk: 2662403
[  119.531431] <0>posbuf: 32128, lpib: 20508, wallclk: 2853751
[  119.594932] snd_hda_intel 0000:00:03.0: Unstable LPIB (20416 >= 16384); disabling LPIB delay counting
[  119.594940] <0>posbuf: 53120, lpib: 32708, wallclk: 4378574
[  119.680236] <0>posbuf: 14144, lpib: 49088, wallclk: 6426353
[  119.680268] <0>posbuf: 14208, lpib: 49096, wallclk: 6427176
[  119.687378] <0>posbuf: 15552, lpib: 50460, wallclk: 6597848
[  119.695391] <0>posbuf: 19776, lpib: 52000, wallclk: 6790194
[  119.765532] <0>posbuf: 42816, lpib: 65472, wallclk: 8474222
[  119.765558] <0>posbuf: 42880, lpib: 65476, wallclk: 8474886
[  119.771373] <0>posbuf: 43968, lpib: 1056, wallclk: 8614451
[  119.779343] <0>posbuf: 45824, lpib: 2588, wallclk: 8805772
[  119.787383] <0>posbuf: 63168, lpib: 4132, wallclk: 8998804
[  119.795365] <0>posbuf: 65472, lpib: 5664, wallclk: 9190453
[  119.803355] <0>posbuf: 1472, lpib: 7200, wallclk: 9382317
[  119.936141] <0>posbuf: 41272, lpib: 32704, wallclk: 12570283
[  120.021440] <0>posbuf: 1600, lpib: 49088, wallclk: 14618206
[  120.106744] <0>posbuf: 35584, lpib: 65472, wallclk: 16666259
[  120.192049] <0>posbuf: 59520, lpib: 16320, wallclk: 18714292
[  120.192083] <0>posbuf: 59584, lpib: 16328, wallclk: 18715146
[  120.199208] <0>posbuf: 60928, lpib: 17696, wallclk: 18886244
[  120.207186] <0>posbuf: 63360, lpib: 19228, wallclk: 19077747
[  120.215205] <0>posbuf: 64896, lpib: 20768, wallclk: 19270235
[  120.277352] <0>posbuf: 17472, lpib: 32704, wallclk: 20762304
[  120.362649] <0>posbuf: 51200, lpib: 49088, wallclk: 22810207
[  120.447951] <0>posbuf: 24128, lpib: 65472, wallclk: 24858211
[  120.533254] <0>posbuf: 50240, lpib: 16320, wallclk: 26906204
[  120.618557] <0>posbuf: 7872, lpib: 32704, wallclk: 28954206
[  120.703866] <0>posbuf: 34304, lpib: 49088, wallclk: 31002327
[  120.789162] <0>posbuf: 57216, lpib: 65472, wallclk: 33050211
[  120.874466] <0>posbuf: 21696, lpib: 16320, wallclk: 35098213
[  120.959775] <0>posbuf: 40896, lpib: 32704, wallclk: 37146356
[  121.045071] <0>posbuf: 65512, lpib: 49088, wallclk: 39194209
[  121.045105] <0>posbuf: 65512, lpib: 49096, wallclk: 39195098
[  121.050904] <0>posbuf: 1088, lpib: 50208, wallclk: 39334239
[  121.130373] <0>posbuf: 25672, lpib: 65472, wallclk: 41242241
[  121.130393] <0>posbuf: 25736, lpib: 65476, wallclk: 41242756
[  121.134894] <0>posbuf: 26568, lpib: 804, wallclk: 41350761
[  121.142891] <0>posbuf: 28104, lpib: 2340, wallclk: 41542772
[  121.150843] <0>posbuf: 29640, lpib: 3868, wallclk: 41733690
[  121.158872] <0>posbuf: 31816, lpib: 5408, wallclk: 41926445
[  121.300979] <0>posbuf: 5184, lpib: 32704, wallclk: 45338238
[  121.386301] <0>posbuf: 39616, lpib: 49092, wallclk: 47386704
[  121.471582] <0>posbuf: 63168, lpib: 65472, wallclk: 49434209
[  121.471617] <0>posbuf: 63232, lpib: 65480, wallclk: 49435075
[  121.478756] <0>posbuf: 1152, lpib: 1312, wallclk: 49606462
[  121.556891] <0>posbuf: 25408, lpib: 16320, wallclk: 51482305
[  121.556926] <0>posbuf: 25472, lpib: 16328, wallclk: 51483213
[  121.562750] <0>posbuf: 26560, lpib: 17448, wallclk: 51623001
[  121.570720] <0>posbuf: 28096, lpib: 18976, wallclk: 51814375
[  121.578734] <0>posbuf: 32128, lpib: 20516, wallclk: 52006750
[  121.586740] <0>posbuf: 33664, lpib: 22052, wallclk: 52198989
[  121.727492] <0>posbuf: 4032, lpib: 49088, wallclk: 55578261
[  121.812793] <0>posbuf: 33600, lpib: 65472, wallclk: 57626206
[  121.898104] <0>posbuf: 61632, lpib: 16320, wallclk: 59674370
[  121.898141] <0>posbuf: 61632, lpib: 16328, wallclk: 59675331
[  121.902593] <0>posbuf: 62464, lpib: 17184, wallclk: 59782193
[  121.910606] <0>posbuf: 2816, lpib: 18724, wallclk: 59974590
[  121.983404] <0>posbuf: 28096, lpib: 32704, wallclk: 61722303
[  121.983445] <0>posbuf: 28096, lpib: 32712, wallclk: 61723274
[  121.990560] <0>posbuf: 29504, lpib: 34080, wallclk: 61894156
[  121.998546] <0>posbuf: 34624, lpib: 35612, wallclk: 62085935
[  122.068702] <0>posbuf: 49600, lpib: 49088, wallclk: 63770204
[  122.154009] <0>posbuf: 15488, lpib: 65472, wallclk: 65818332
[  122.154046] <0>posbuf: 15552, lpib: 65480, wallclk: 65819256
[  122.158520] <0>posbuf: 16384, lpib: 804, wallclk: 65926628
[  122.239309] <0>posbuf: 45760, lpib: 16320, wallclk: 67866282
[  122.239331] <0>posbuf: 45760, lpib: 16324, wallclk: 67866855
[  122.246459] <0>posbuf: 47168, lpib: 17692, wallclk: 68037996
[  122.254452] <0>posbuf: 52480, lpib: 19228, wallclk: 68229867
[  122.324608] <0>posbuf: 16192, lpib: 32704, wallclk: 69914215
[  122.324644] <0>posbuf: 16256, lpib: 32712, wallclk: 69915098
[  122.330453] <0>posbuf: 19264, lpib: 33828, wallclk: 70054572
[  122.409916] <0>posbuf: 47744, lpib: 49088, wallclk: 71962318
[  122.409950] <0>posbuf: 47808, lpib: 49096, wallclk: 71963172
[  122.414421] <0>posbuf: 48640, lpib: 49952, wallclk: 72070480
[  122.422413] <0>posbuf: 50496, lpib: 51488, wallclk: 72262373
[  122.495215] <0>posbuf: 4544, lpib: 65472, wallclk: 74010232
[  122.580516] <0>posbuf: 30144, lpib: 16320, wallclk: 76058218
[  122.580549] <0>posbuf: 30144, lpib: 16328, wallclk: 76059056
[  122.586330] <0>posbuf: 31296, lpib: 17436, wallclk: 76197834
[  122.594354] <0>posbuf: 34304, lpib: 18976, wallclk: 76390435
[  122.665824] <0>posbuf: 48000, lpib: 32704, wallclk: 78106302
[  122.665859] <0>posbuf: 48064, lpib: 32712, wallclk: 78107204
[  122.670317] <0>posbuf: 49152, lpib: 33568, wallclk: 78214218
[  122.751125] <0>posbuf: 10368, lpib: 49088, wallclk: 80154285
[  122.751157] <0>posbuf: 10432, lpib: 49096, wallclk: 80155098
[  122.758292] <0>posbuf: 11776, lpib: 50464, wallclk: 80326335
[  122.766288] <0>posbuf: 13312, lpib: 52000, wallclk: 80518371
[  122.774277] <0>posbuf: 15616, lpib: 53536, wallclk: 80710186
[  122.782262] <0>posbuf: 17152, lpib: 55068, wallclk: 80901852
[  122.921726] <0>posbuf: 55680, lpib: 16320, wallclk: 84250213
[  123.007035] <0>posbuf: 20928, lpib: 32704, wallclk: 86298342
[  123.092332] <0>posbuf: 45824, lpib: 49088, wallclk: 88346236
[  123.092347] <0>posbuf: 45824, lpib: 49092, wallclk: 88346635
[  123.098155] <0>posbuf: 48512, lpib: 50208, wallclk: 88486077
[  123.106141] <0>posbuf: 50048, lpib: 51740, wallclk: 88677794
[  123.177633] <0>posbuf: 12928, lpib: 65472, wallclk: 90394202
[  123.177664] <0>posbuf: 12928, lpib: 65476, wallclk: 90394982
[  123.182132] <0>posbuf: 13824, lpib: 800, wallclk: 90502214
[  123.190135] <0>posbuf: 15360, lpib: 2336, wallclk: 90694383
[  123.198168] <0>posbuf: 22400, lpib: 3880, wallclk: 90887194
[  123.262941] <0>posbuf: 41152, lpib: 16320, wallclk: 92442299
[  123.262975] <0>posbuf: 41152, lpib: 16328, wallclk: 92443159
[  123.270098] <0>posbuf: 46080, lpib: 17696, wallclk: 92614190
[  123.278088] <0>posbuf: 53120, lpib: 19232, wallclk: 92806002
[  123.348238] <0>posbuf: 7808, lpib: 32704, wallclk: 94490195
[  123.433540] <0>posbuf: 41664, lpib: 49088, wallclk: 96538196
[  123.433574] <0>posbuf: 41728, lpib: 49096, wallclk: 96539044
[  123.438020] <0>posbuf: 42560, lpib: 49948, wallclk: 96645775
[  123.446056] <0>posbuf: 44096, lpib: 51492, wallclk: 96838682
[  123.454017] <0>posbuf: 45632, lpib: 53020, wallclk: 97029796
[  123.462035] <0>posbuf: 49536, lpib: 54560, wallclk: 97222323
[  123.604151] <0>posbuf: 26624, lpib: 16320, wallclk: 100634303

The aplay output is:
Playing WAVE '/home/younglee/wavs/48KHz.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
Plug PCM: Hardware PCM card 0 'HDA Intel HDMI' device 7 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 4096
  period_time  : 85333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 4096
  period_event : 0
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
  appl_ptr     : 0
  hw_ptr       : 0
Aborted by signal Interrupt...

Regards,
Libin

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, May 8, 2014 2:40 PM
> To: Yang, Libin
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Pierre-Louis Bossart
> Subject: Re: [PATCH] ALSA: hda - using POS_FIX_LPIB on Broadwell HDMI
> Audio
> 
> At Thu, 8 May 2014 06:28:17 +0000,
> Yang, Libin wrote:
> >
> > Hi Takashi,
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Thursday, May 8, 2014 2:20 PM
> > > To: Yang, Libin
> > > Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Pierre-Louis Bossart
> > > Subject: Re: [PATCH] ALSA: hda - using POS_FIX_LPIB on Broadwell
> > > HDMI Audio
> > >
> > > At Thu, 8 May 2014 06:13:31 +0000,
> > > Yang, Libin wrote:
> > > >
> > > > Hi Takashi,
> > > >
> > > > > -----Original Message-----
> > > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > > Sent: Thursday, May 8, 2014 1:51 PM
> > > > > To: Yang, Libin
> > > > > Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Pierre-Louis
> > > > > Bossart
> > > > > Subject: Re: [PATCH] ALSA: hda - using POS_FIX_LPIB on Broadwell
> > > > > HDMI Audio
> > > > >
> > > > > At Thu, 8 May 2014 05:48:04 +0000, Yang, Libin wrote:
> > > > > >
> > > > > > Hi Takashi,
> > > > > >
> > > > > > I checked the wallclock counter. The counter is OK. But it
> > > > > > failed to correct
> > > > > the position.
> > > > >
> > > > > So, how wrong the position buffer is?  Is the problem intermittent?
> > > > > Please elaborate more.
> > > >
> > > > The issue is the position is almost always inaccurate. You will
> > > > hear there is
> > > intermittent noise in the sound. And the sound is played faster than
> > > it should be.
> > > >
> > > > The following message is what I got from dmesg:
> > > >
> > > > [ 73.278117] snd_hda_intel 0000:00:03.0: IRQ timing workaround is
> > > activated for card #0. Suggest a bigger bdl_pos_adj.
> > > > [ 73.528575] snd_hda_intel 0000:00:03.0: Unstable LPIB (26240 >=
> > > > 24064); disabling LPIB delay counting
> > > >
> > > > Do you think the print of wallclk and position information in the
> > > > function
> > > azx_position_ok() is useful to you? If yes, I will add debug code to
> > > print the info.
> > >
> > > It'd better to have the raw values of posbuf, lpib and wallclock for
> > > further analysis, yes.
> > >
> > > BTW, did you try non-snoop mode via snoop=0 option?
> >
> > I haven't tried non-snoop. Do I use `modprobe snd-hda-intel snoop=0` to
> use non-snoop mode?
> 
> Yes.
> 
> Takashi

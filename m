From: "Peter Heatwole" <peter599@gotnet.net>
Subject: Re: SPDIF and cs46xx ?
Date: Sun, 16 Mar 2003 13:31:47 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <14a4584ea6cb4a6894e70d84e717abc6.peter599@gotnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

   I have also been attempting to use Dolby Digital passthru with my Turtle
Beach Santa Cruz=2E  Unfortunately I have not yet been successful=2E
   For these tests I am using todays (March 16) CVS of alsa-kernel, alsa-dri=
ver
and alsa-lib=2E  For xine I'm using xine-lib-1-beta8, compiled with todays A=
LSA
CVS=2E

   In my tests I have had two different results:

1) No sound
2) A clicking sound (described by another user as "cards in a bike")  For the=

   times I get this sound, it's normally about 4-6 beats-per-second (or so),=
 but
   if I unmute "IEC958 Input" it nearly doubles (about 8-12 beats-per-second=
)=2E

------------------

   Here's the relevant console output from xine when I start playing a movie:=


liba52:No accelerated IMDCT transform found
audio_alsa_out: Audio Device name =3D iec958:AES0=3D0x6,AES1=3D0x82,AES2=3D0=
x0,AES3=3D0x2
audio_alsa_out: Number of channels =3D 2
audio_alsa_out:open pause_resume=3D0
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 16384
period_size  : 512
period_time  : 10666
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 512
xfer_align   : 1
start_threshold  : 512
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
start_mode: DATA
xrun_mode: STOP
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 512
xfer_align: 1
silence_threshold: 0
silence_size: 0
boundary: 1073741824
metronom: fixing sound card drift by -1544 pts
audio_alsa_out:write:BAD STATE, state =3D 1
audio_alsa_out:write:BAD STATE2, state =3D 1, going to try XRUN
audio_alsa_out:write:BAD STATE, state =3D 1
audio_alsa_out:write:BAD STATE2, state =3D 1, going to try XRUN

------------------

   Here's my syslog output when I start and stop a AC3 stream (with either x=
ine
or ac3dec [-C/-P]):

Mar 16 12:54:17 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/c=
s46xx_lib=2Ec:
1430: open raw iec958 channel
Mar 16 12:54:17 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/d=
sp_spos_scb_
lib=2Ec:226: cs46xx_dsp_proc_free_scb_desc: freeing PCMSerialInput_II
Mar 16 12:54:17 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/d=
sp_spos_scb_
lib=2Ec:226: cs46xx_dsp_proc_free_scb_desc: freeing AsynchFGTxSCB
Mar 16 12:54:17 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/d=
sp_spos_scb_
lib=2Ec:290: dsp_spos: creating SCB <AsynchFGTxSCB>
Mar 16 12:54:17 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/d=
sp_spos_scb_
lib=2Ec:1178: IEC958 pass through
Mar 16 12:54:17 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/d=
sp_spos_scb_
lib=2Ec:1243: dsp_spos: creating SRC "SrcTask_SCB0"
Mar 16 12:54:17 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/d=
sp_spos_scb_
lib=2Ec:597: dsp_spos: setting SrcTask_SCB0 rate to 48000
Mar 16 12:54:17 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/d=
sp_spos_scb_
lib=2Ec:290: dsp_spos: creating SCB <SrcTask_SCB0>
Mar 16 12:54:17 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/d=
sp_spos_scb_
lib=2Ec:1268: dsp_spos: creating PCM "PCMReader_SCB0" (5)
Mar 16 12:54:17 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/d=
sp_spos_scb_
lib=2Ec:290: dsp_spos: creating SCB <PCMReader_SCB0>
Mar 16 12:54:17 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/c=
s46xx_lib=2Ec:
1001: period_size (2048), periods (32) buffer_size(65536)
Mar 16 12:54:27 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/c=
s46xx_lib=2Ec:
1446: close raw iec958 channel
Mar 16 12:54:27 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/d=
sp_spos_scb_
lib=2Ec:226: cs46xx_dsp_proc_free_scb_desc: freeing PCMReader_SCB0
Mar 16 12:54:27 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/d=
sp_spos_scb_
lib=2Ec:226: cs46xx_dsp_proc_free_scb_desc: freeing SrcTask_SCB0
Mar 16 12:54:27 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/d=
sp_spos_scb_
lib=2Ec:226: cs46xx_dsp_proc_free_scb_desc: freeing AsynchFGTxSCB
Mar 16 12:54:27 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/d=
sp_spos_scb_
lib=2Ec:290: dsp_spos: creating SCB <AsynchFGTxSCB>
Mar 16 12:54:27 darkstar kernel: ALSA =2E=2E/=2E=2E/alsa-kernel/pci/cs46xx/d=
sp_spos_scb_
lib=2Ec:290: dsp_spos: creating SCB <PCMSerialInput_II>

------------------

   TIA for any advice or help with this=2E  And thanks for all your great wo=
rk,
Benny=2E

-- Peter Heatwole
"Murphy was just a well known pessimist=2E"



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en

From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: SPDIF output finally working properly with CS4630
Date: Wed, 24 Jul 2002 23:53:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3F21CD.9090600@cucumelo.org>
References: <3D3DBDA2.10602@cucumelo.org> <20020724013400.GA5214@porky> <3D3E2D08.3070800@cucumelo.org> <20020724181919.GC1681@porky> <3D3EF4CA.1090504@cucumelo.org> <20020724201201.GI1681@porky> <3D3F0710.1060307@cucumelo.org> <20020724212315.GK1681@porky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Peter Heatwole <peter599@gotnet.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>    The IEC958 control is supposed to be there because of the CS4297A 
> codec.
> Your changes only involved the CS4297.
>    My IEC958 is coaxial, and I'm using a set of Cambridge SoundWorks
> DTT2500 Digital speakers. I don't know of any other way to check if 
> the card is sending a signal or not. 

Well, if you have access to a oscilloscope that can be programed to view 
the differential result
of the signals then probably you can proably view the digital data.
But i've never tested to do this, and don't have any access to a 
oscilloscope at home ...

>
>    I've attached a few files that may help. I just noticed some module
> errors that may be the cause of my problems.


Then, do you know if your IEC958 is connected to CS4297A or CS4630 ??
If it is connected to the CS4297A then this patch will not provide any 
output
on that IEC958 port.
.

>WriteBackSCB:
>0040 3FC0000F 00000301 00010400 00000000 
>0044 00000000 00000000 00000000 00000000 
>0048 00000000 00B00000 00D0806D 330480C3 
>004C 04800000 00000003 00800003 0000FFFF 
>0050 00000000 00000000 00000000 00000000 
>0054 00000000 00000000 00000000 00000000 
>0058 00000000 00000000 00000000 00000000 
>005C 00000000 00000000 00000000 00000000 
>0060 00000000 00000000 00000000 00000000 
>0064 00000000 00000000 00000000 00000000 
>0068 00000000 00000000 00000000 00000000 
>006C 00000000 00000000 00000000 00000000 
>
This dump should not be that long!
Did you change anything in the code ? the SCB block
has always a fixed size of 16 Dwords. A new SCB block will
start on 0x0050.

>
>MasterMixSCB:
>0090 00000000 00000000 00001478 00000000 
>0094 00000000 00000000 00000000 00000000 
>0098 00000080 00A00000 0000809A 000000C3 
>009C 14F80000 00000000 80008000 80007FFF 
>
The 9th Dword in SCB is the sub_list_ptr which points
to the SCB's child SCB. Which is in this case is 00A0
which points to the SRCTaskSCB (sample rate converter).
When SPDIF output is muted the MasterMixSCB sub_list_ptr
is 00A0 -> SRCTaskSCB, and when SPDIF output is unmuted
sub_list_ptr is 0x00E0 AsynchFGTxSCB.
In the moment of this dump the SPDIF seems to be muted.

>
>PCMREADER:
>0600 ED42F99C EE6EF940 EFB0F8EF F0F6F8A9 
>0610 F236F86E F372F83F F4AAF818 F5DDF7F5 
>0620 F70DF7D1 F83AF7A6 F969F778 FAA3F742 
>MIX_SAMPLE_BUF1:
>1400 FF0BF666 FE8DF5C0 FE00F526 FD60F499 
>1410 FCBFF421 FC1CF3BF FB76F36F FAD7F334 
>1420 FA45F314 F9C4F30B F94FF319 F8EAF33E 
>
>1780 00000000 00000000 00000000 00000000 
>1790 00000000 00000000 00000000 00000000 
>17A0 00000000 00000000 00000000 00000000 
>17B0 00000000 00000000 00000000 00000000 
>17C0 00000000 00000000 00000000 00000000 
>17D0 00000000 00000000 00000000 00000000 
>17E0 00000000 00000000 00000000 00000000 
>17F0 00000000 00000000 00000000 00000000 
>SPDIFO_BUFFER:
>1800 00000000 00000000 00000000 00000000 
>1810 00000000 00000000 00000000 00000000 
>1820 00000000 00000000 00000000 00000000 
>1830 00000000 00000000 00000000 00000000 
>...
>18D0 00000000 00000000 00000000 00000000 
>18E0 00000000 00000000 00000000 00000000 
>18F0 00000000 00000000 00000000 00000000 
>1900 00000000 00000000 00000000 00000000 
>OUTPUT_SNOOP:
>1200 00000000 00000000 00000000 00000000 
>1210 00000000 00000000 00000000 00000000 
>1220 00000000 00000000 00000000 00000000 
>1230 00000000 00000000 00000000 00000000 
>...
>12D0 00000000 00000000 00000000 00000000 
>12E0 00000000 00000000 00000000 00000000 
>12F0 00000000 00000000 00000000 00000000 
>1300 00000000 00000000 00000000 00000000 
>
As the SPDIFO_BUFFER is empty nothing is going
out to the SPDIF output.

>
>0090 MasterMixSCB:
>00000000 00000000 00001400 00000000 
>00000000 00000000 00000000 00000000 
>00000080 00a00000 0000809a 000000c3 
>14800000 00000000 80008000 80007fff 
>
Here SPDIF still muted.


>
>0130 SPIOWriteSCB:
>804d804d 00000000 00000000 00000000 
>00000000 00000000 00000000 00000000 
>00000000 00000000 00000194 00000000 
>00000000 00000000 00000000 00000000 
>
Last IO wroten by cs46xx_poke_via_dsp(...) was address 0x804d, and value 0x0
the 0x804d is the SP SPDOUT_CONTROL register, value 0 disables SPDIF.
Probably cs46xx_dsp_disable_spdif_in() was invoked, is invoked
at end of snd_cs46xx_chip_init(...) when module is initialized..

>
>0bc0 SPDIFOSCB:
>00000000 000000b0 00000000 00000000 
>00000000 00000086 1820fffc 00000000 
>00000000 00000600 0bcd020f 00000040 
>000020ff 0000804c 00010108 deadc0ed 
>
First dword 0, SPDIF output inactive.

>Jul 24 13:23:09 porky kernel: dsp_spos: downloading code to chip (00021470-00021570)
>Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01016:b8630 addr 02d7
>Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01014:e8630 addr 029d
>Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01016:e03a0 addr 02dc
>Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01015:103a0 addr 02a2
>Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01017:10730 addr 02e2
>Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01015:40730 addr 02a8
>Jul 24 13:23:09 porky kernel: dsp_spos: 3 instructions reallocated
>Jul 24 13:23:09 porky kernel: snd_cs46xx_download bank 02
>Jul 24 13:23:09 porky kernel: MasterMixSCB
>
Well, that's what i can interpret from this outputs.

Everything look basically OK.
Seems like you have loaded the module successfully and have not started
playing yet.

/Benny




-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim

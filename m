From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: How to put 16bit none audio PCM data stream into a 32bit none audio S/P-DIF transport stream?
Date: Mon, 14 Apr 2003 23:27:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030414212708.GB22184@ulima.unil.ch>
References: <s5h4r57rf1m.wl@alsa2.suse.de> <3E9553C2.3000100@superbug.demon.co.uk> <20030410112657.GA2332@ulima.unil.ch> <3E994CCE.6020105@cucumelo.org> <20030413170501.GA2323@ulima.unil.ch> <3E99AAAB.1070101@cucumelo.org> <20030413183035.GC2323@ulima.unil.ch> <3E99F176.6080503@cucumelo.org> <20030414190615.GA22184@ulima.unil.ch> <3E9B341E.4040200@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3E9B341E.4040200@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net, James@superbug.demon.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 15, 2003 at 12:20:14AM +0200, Benny Sjostrand wrote:

> Well, I supose I should upgrade -;)

Or me downgrade as it works for you :-)

> So lets try changing thoose values to:
> AES0=3D0x2,AES1=3D0x0,AES2=3D0x82,AE3=3D0x2

ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1441: open raw iec958 chan=
nel
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing PCMSerialInput_II
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing AsynchFGTxSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <AsynchFGTxSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1704: setting SP_SPD=
OUT_CSUV register to stream (02003006)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1241: IEC958 pass th=
rough
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1306: dsp_spos: crea=
ting SRC "SrcTask_SCB0"
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:597: dsp_spos: setti=
ng SrcTask_SCB0 rate to 48000
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <SrcTask_SCB0>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1331: dsp_spos: crea=
ting PCM "PCMReader_SCB0" (5)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <PCMReader_SCB0>
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1001: period_size (2048), =
periods (32) buffer_size(65536)
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2179: setting SP_SPDOUT_CS=
UV register (02823002)
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2179: setting SP_SPDOUT_CS=
UV register (02003006)
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1457: close raw iec958 cha=
nnel
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing PCMReader_SCB0
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing SrcTask_SCB0
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1721: setting SP_SPD=
OUT_CSUV register to default (02003000)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing AsynchFGTxSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <AsynchFGTxSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <PCMSerialInput_II>

> Could you just test the new AES0-3.... values, and sendme the logs=20
> again. (check the SP_SPDOUT_CSUV in logs outputs, i would like it to=20
> have 0x02820302 value)

It's a value I could find, is that good?

I have tried xine with the same iec958:AES0=3D0x2,AES1=3D0x0,AES2=3D0x82,=
AES3=3D0x2
value:

ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1418: open front channel
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1441: open raw iec958 chan=
nel
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing PCMSerialInput_II
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing AsynchFGTxSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <AsynchFGTxSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1704: setting SP_SPD=
OUT_CSUV register to stream (02003006)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1241: IEC958 pass th=
rough
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1306: dsp_spos: crea=
ting SRC "SrcTask_SCB0"
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:597: dsp_spos: setti=
ng SrcTask_SCB0 rate to 48000
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <SrcTask_SCB0>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1331: dsp_spos: crea=
ting PCM "PCMReader_SCB0" (5)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <PCMReader_SCB0>
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1001: period_size (2048), =
periods (32) buffer_size(65536)
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2179: setting SP_SPDOUT_CS=
UV register (02823002)
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2179: setting SP_SPDOUT_CS=
UV register (02003006)
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1457: close raw iec958 cha=
nnel
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing PCMReader_SCB0
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing SrcTask_SCB0
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1721: setting SP_SPD=
OUT_CSUV register to default (02003000)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing AsynchFGTxSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <AsynchFGTxSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <PCMSerialInput_II>

Have a great day,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: How to put 16bit none audio PCM data stream into
 a 32bit none audio S/P-DIF transport stream?
Date: Tue, 15 Apr 2003 00:20:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E9B341E.4040200@cucumelo.org>
References: <s5h65poq65j.wl@alsa2.suse.de> <20030409114312.GE14489@ulima.unil.ch> <s5h4r57rf1m.wl@alsa2.suse.de> <3E9553C2.3000100@superbug.demon.co.uk> <20030410112657.GA2332@ulima.unil.ch> <3E994CCE.6020105@cucumelo.org> <20030413170501.GA2323@ulima.unil.ch> <3E99AAAB.1070101@cucumelo.org> <20030413183035.GC2323@ulima.unil.ch> <3E99F176.6080503@cucumelo.org> <20030414190615.GA22184@ulima.unil.ch>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>0.9.20 with lots of different DVD tested...
>  
>
Well, I supose I should upgrade -;)

>
>So, I'll take Star Wars II for my new test ;-)
>
Just in case that something differs between DVD's, you never know ... 
(but probably dont care at all)

>ac3dec from_beyond_the_edge_44k_256kbps.ac3 --device=iec958:AES0=0x2,AES1=0x82,AES2=0x0,AES3=0x2
>5.1 Mode 44.1 KHz 256 kbps Complete Main Audio Service
>Using PCM device 'iec958:AES0=0x2,AES1=0x82,AES2=0x0,AES3=0x2'
>  
>
So lets try changing thoose values to:
AES0=0x2,AES1=0x0,AES2=0x82,AE3=0x2

>ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1241: IEC958 pass through
>ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1306: dsp_spos: creating SRC "SrcTask_SCB0"
>ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:597: dsp_spos: setting SrcTask_SCB0 rate to 48000
>ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creating SCB <SrcTask_SCB0>
>ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1331: dsp_spos: creating PCM "PCMReader_SCB0" (5)
>ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creating SCB <PCMReader_SCB0>
>ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1001: period_size (2048), periods (32) buffer_size(65536)
>ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2179: setting SP_SPDOUT_CSUV register (02003002)
>ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2179: setting SP_SPDOUT_CSUV register (00003087)
>
Last value look's complety wrong (00003087), and (02003002) is suspect, 
... (probably my fault ...)

>Thank you very much,
>
>  
>
You're welcome!

Could you just test the new AES0-3.... values, and sendme the logs 
again. (check the SP_SPDOUT_CSUV in logs outputs, i would like it to 
have 0x02820302 value)

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

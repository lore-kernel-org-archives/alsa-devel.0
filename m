From: =?iso-8859-1?Q?Ren=E9_Kermis?= <kermis@gmx.de>
Subject: Re: problem for VIA 8233A
Date: Mon, 3 Jun 2002 11:09:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <002001c20ade$54630c30$6abc5f86@kermit>
References: <Pine.LNX.4.21.0206031642240.27809-100000@ns1>
Reply-To: =?iso-8859-1?Q?Ren=E9_Kermis?= <rene@kermis.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

you have to use the cvs-version. The driver for 8233A is not included in
0.5.12a and 0.9.0rc1.
Takashi Iwai corrected some bugs in the driver on 31-05-02 so that it is
possible to use it with the 8233A. I have tested the driver on an EPoX 8K3A+
(KT333, VT8233A). The sound quality is better than from the commercial
OSS-module.

Regards,
René


----- Original Message -----
From: "Siu Kam Ming" <ming@thizlinux.com>
To: <alsa-devel@lists.sourceforge.net>
Sent: Monday, June 03, 2002 10:56 AM
Subject: [Alsa-devel] problem for VIA 8233A


> Hi,
>
> I have a motherboard(ECS-K7VTA2) which using via-8233a as audio chip. I
> saw someone can drive this chip by using alsa driver successfully. But I
> can not make the sound work.
>
> I am using kernel 2.4.18. I try 0.9.0rc1 and 0.5.12a. I can insert the
> module successfully. And I can use "aumix" to tune the mixer. But I can
> not play any sound files. The speaker keep slience.
>
> Does anyone have idea to solve this problem?
>
> This is the content of my "/etc/modules.conf".
>
> alias parport_lowlevel parport_pc
> alias eth0 8139too
> alias char-major-62 ptserial
> alias usb-controller usb-uhci
> alias usb-interface0 usb-uhci
> alias sound-slot-0 snd-via8233
> alias char-major-116 snd
> alias char-major-14 soundcore
> options snd snd_major=116 snd_cards_limit=1
> alias snd-card-0 snd-via8233
> alias sound-slot-0 snd-card-0
> alias sound-service-0-0 snd-mixer-oss
> alias sound-service-0-1 snd-seq-oss
> alias sound-service-0-3 snd-pcm-oss
> alias sound-service-0-8 snd-seq-oss
> alias sound-service-0-12 snd-pcm-oss
> post-install snd-via8233 /sbin/modprobe snd-pcm-oss
> post-install snd-pcm-oss /sbin/modprobe snd-mixer-oss
>
> This is the result of lspci:
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
> 00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
> 10)
> 00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
> 00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
> 00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23)
> 00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23)
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
> Controller (rev 40)
> 01:00.0 VGA compatible controller: S3 Inc. 86c368 [Trio 3D/2X] (rev 02)
>
> Regards,
> Ming
>
>
>
> _______________________________________________________________
>
> Don't miss the 2002 Sprint PCS Application Developer's Conference
> August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm

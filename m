From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: Re: RME installation problems
Date: Wed, 12 Feb 2003 20:12:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030212191240.GA806@finnendahl.de>
References: <20030212183033.GD3093@finnendahl.de> <1045076338.1544.3.camel@lotte>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1045076338.1544.3.camel@lotte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, Justin Cormack <justin@street-vision.com>
List-Id: alsa-devel@alsa-project.org

Am Mittwoch, den 12. Februar 2003 um 18:58:53 Uhr (+0000) schrieb Justin Cormack:
> hmm, I just got a new one and had no problem. The firmware is downloaded
> by the driver.

I guess that means it can't be related to firmware issues.

> 
> What does lspci -n -s slotno (eg lspci -n -s 00:0c.0 if thats what lspci
> shows is your card) show?

east:~# lspci -n -s 00:0b.0
00:0b.0 Class 0401: 10ee:3fc5 (rev 0b)
east:~# 

and without otions:

east:~# lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 730 Host (rev 02)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:0b.0 Multimedia audio controller: Xilinx, Inc.: Unknown device 3fc5 (rev 0b)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D (rev 31)

> 
> Whats up in Rotterdam?

DEAF a biennual Electronic Arts Exhibition organized by V2. It's
pretty big and similar in its focus to the Ars Electronica in Linz.

--
Orm


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

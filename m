From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0 modem
Date: Thu, 15 Sep 2005 19:10:15 +0800
Message-ID: <43295697.3010207@netvigator.com>
References: <4321B5A4.5090803@netvigator.com> <20050911124530.GA16795@titan.lahn.de> <4325AEA3.1090602@netvigator.com> <20050913000909.GB19713@tecr> <20050913085552.GA2655@titan.lahn.de> <20050913173529.GD31269@sashak.softier1.local> <20050913174930.GA5816@titan.lahn.de> <4327DA14.3040205@netvigator.com> <20050914205608.GD14657@sashak.softier1.local> <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050915092155.GA7328@titan.lahn.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Philipp Matthias Hahn wrote:
> Hello!
> 
> On Thu, Sep 15, 2005 at 11:11:58AM +0200, Philipp Matthias Hahn wrote:
> 
>>On Wed, Sep 14, 2005 at 11:56:08PM +0300, Sasha Khapyorsky wrote:
>>
>>>Philipp, you could play with VORTEX_CODEC_ID_SHIFT value (au88x0,h) in
>>>range 24-31.
>>
>>...
>>
>>>diff -rpu au88x0_orig/au88x0.h au88x0/au88x0.h
>>
>>...
>>
>>>+#define VORTEX_CODEC_ID_SHIFT	30 /* unknown: may be 24-31 (or irrelevat) */
>>
>>Sorry, no luck with any value in the range 24-31.
> 
> 
> Sorry, I wronly patched the driver.
> 24-31/25 works. tar-file with copies of /proc/asound/au8810 attached.
> 
> BYtE
> Philipp

You found the modem codec :)

#define VORTEX_CODEC_ID_SHIFT	24

/proc/asound/au8810/codec97#0/mc97#1-1

1-1/0: Silicon Laboratory Si3036,8 rev 6

Extended modem ID: codec=1 LIN1
Modem status     : GPIO MREF ADC1 DAC1 PRE(ADC2) PRF(DAC2) PRG(HADC) 
PRH(HDAC)
Line1 rate       : 8000Hz

/proc/asound/au8810/codec97#0/mc97#1-1+regs

0:00 = 0000
0:02 = 0000
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 0000
0:0c = 0000
0:0e = 0000
0:10 = 0000
0:12 = 0000
0:14 = 0000
0:16 = 0000
0:18 = 0000
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 0000
0:28 = 0000
0:2a = 0000
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
0:3c = 4001
0:3e = f00f
0:40 = 1f40
0:42 = 0000
0:44 = 0000
0:46 = 8080
0:48 = 0000
0:4a = 0000
0:4c = 003e
0:4e = fffe
0:50 = 003f
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0122
0:5c = f210
0:5e = 0040
0:60 = 0000
0:62 = 6000
0:64 = 0002
0:66 = 0a08
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0000
0:74 = 0000
0:76 = 0000
0:78 = 0000
0:7a = 0000
0:7c = 5349
0:7e = 4c26



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

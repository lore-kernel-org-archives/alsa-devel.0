From: Weijia Yang <gte733z@prism.gatech.edu>
Subject: Re: cs46xx experimental DSP drivers
Date: Tue, 24 Sep 2002 14:56:15 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D90B54F.20402@prism.gatech.edu>
References: <3D8F7F59.6030105@prism.gatech.edu> <3D90A8D8.7070103@cucumelo.org>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Benny Sjostrand wrote:
>> I am testing out the cs46xx experimental DSP drivers on the 9/22 cvs 
>> build on a TB Santa Cruz. The drivers work fine except for the fact 
>> that all sound is "flat"--almost no base at all. This is in comparison 
>> to the original cs46xx drivers that come with rc3. The sound quality 
>> difference is very noticeable. I have tried tweaking with all the 
>> mixer settings with no result. I have also tried the experimental DSP 
>> drivers on the rc3 build with the same results. Anyone know a fix? Thanks 
> 
> 
> 
> It's hard to say what the problem can be. The Santa Cruz card have been 
> reported to work fine.
> Maybe it's the soundcard amplifier possibly is turned off, have you
> tried with "external_amp=1" ???
> 
> Can you do a "lspci -a" and a "lspci -a -n" send me the output, just to 
> check
> is your card possibly has a different vendor/ID.
> 
> /Benny
> 

Benny--
	Where exactly do I set this "external_amp" option? I see a 'External 
Amplifier Power Down' in amixer, but only option is muting, which turns 
sound off completely.  Also, several other people have also reported the 
"flat" sounds, as well as cpu usage spikes when initiating a sound 
stream. The posts can be seen at 
<http://forums.gentoo.org/viewtopic.php?t=10826&highlight=cs46xx>
and
<http://forums.gentoo.org/viewtopic.php?t=10810&highlight=cs46xx>

Here is the output you asked for:
lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] 
System Contr
oller (rev 13)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP 
Bridge
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40
)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master 
IDE (rev
  06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:0a.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 
[CrystalClear So
undFusion Audio Accelerator] (rev 01)
00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 78)
00:10.0 Unknown mass storage controller: Promise Technology, Inc. 20265 
(rev 02)
01:05.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3] 
(rev a3)


lspci -n
00:00.0 Class 0600: 1022:700e (rev 13)
00:01.0 Class 0604: 1022:700f
00:07.0 Class 0601: 1106:0686 (rev 40)
00:07.1 Class 0101: 1106:0571 (rev 06)
00:07.2 Class 0c03: 1106:3038 (rev 16)
00:07.3 Class 0c03: 1106:3038 (rev 16)
00:07.4 Class 0c05: 1106:3057 (rev 40)
00:0a.0 Class 0401: 1013:6003 (rev 01)
00:0d.0 Class 0200: 10b7:9200 (rev 78)
00:10.0 Class 0180: 105a:0d30 (rev 02)
01:05.0 Class 0300: 10de:0200 (rev a3)


-- 
Weijia Yang
School of Electrical and Computer Engineering
Georgia Institute of Technology
Atlanta, GA



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

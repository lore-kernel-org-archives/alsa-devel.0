From: Brett Bolen <bbolen@extron.com>
Subject: Audio Driver -- too much data, coming in two quickly
Date: Wed, 1 Sep 2010 14:02:43 +0000 (UTC)
Message-ID: <loom.20100901T153508-926@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id CB86124141
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Sep 2010 17:00:12 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OqonE-00056z-97
	for alsa-devel@alsa-project.org; Wed, 01 Sep 2010 17:00:04 +0200
Received: from rrcs-24-172-120-202.midsouth.biz.rr.com ([24.172.120.202])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 01 Sep 2010 17:00:04 +0200
Received: from bbolen by rrcs-24-172-120-202.midsouth.biz.rr.com with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 01 Sep 2010 17:00:04 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have a TI Davinci DM365/368 board that uses a cirrus logic cs4272 decoder. 
The decoder will only output 32bit pcm ( 24 bits valid) @ 48khz.  I've modified
the Davinci-* drivers and added a codec driver, and it worked fine for the
2.6.18 kernel ( using oss emulation).  The apps aplay & arecord worked as well.

MCBSP (davinci-i2s.c) is set to capture 32bit left, then 32bit right from the
I2S stream, and the EDMA (davinci-pcm) driver is set to capture 8k buffers ( 16
buffers for a total of 128k buffers).  Since I am capturing 2x4 bytes per sample
it's 1024 frames at 48khz, or 48 times a second or about 21ms per DMA buffer.

We've updated the kernel, and I've put in my driver mods for a newer kernel (
2.6.32-rc2-psp37, from TI), but now I'm seeing the following problem:

Data starts coming in fine, then about one time per second, I see a large amount
of frames/captures all at once.  Instead of 21ms, per 1024 frames, I see several
reads of 1024 frames in less than 5 ms.  It's almost like I get the whole ring
buffer ( ie get pointer overlapped the put pointer).

I've put in debug in the edma driver that indicates we are inserting data into
ALSA at 21ms, so the data is coming in at a steady rate.  But the data out has
these large spews of data about once a second.

BTW our capture program is capturing 16bit pcm stereo at 48khz using plughw:0,0.

I see this with our application as well as a simple app based on the tutorial.

We are using alsa-lib 1.0.23.  

How can I figure out what is happening, or fix this problem?  Any suggestions?
any similar problems fixed lately?  Is there a way I can get the current ring
buffer pointers ( either from driver or application?)


Here is a sample run.  a tick is a microsecond, so most captures are about 21ms.
During capture, the the number on the left is a timstamp in ticks.

~ # alsa_capture
alsa_capture: v0.1b
delay calibration:0=266 10=152 100=233 1000=1129 10000=10138 100000=100150 ticks
( 112075 11925 1787 658 425 273 7) ticks
Returned 1024 frames per period
---------------------------after set hw params 1
PCM handle name = 'plughw:0,0'
PCM state = PREPARED
access type = RW_INTERLEAVED
format = 'S16_LE' (Signed 16 bit Little Endian)
subformat = 'STD' (Standard)
channels = 2
rate = 48000 bps
period time = 21333 us
period size = 1024 frames !!
buffer time = 341333 us
buffer size = 16384 frames
periods per buffer = 16 frames
exact rate = 48000/1 bps
significant bits = 16
is batch = 0
is block transfer = 1
is double = 0
is half duplex = 0
is joint duplex = 0
can overrange = 0
can mmap = 0
can pause = 1
can resume = 0
can sync start = 0
.........................................
loops is 93/0x5d, period_time is 21333/5355, frames=1024/400
  157321-l0092:1024 frames         22445 ticks read,       64 ticks process
  180009-l0091:1024 frames         20415 ticks read,       20 ticks process
  200614-l0090:1024 frames         21074 ticks read,       19 ticks process
  221881-l0089:1024 frames         21136 ticks read,       19 ticks process
  243209-l0088:1024 frames         21147 ticks read,       18 ticks process
  264545-l0087:1024 frames         21132 ticks read,       19 ticks process
  285866-l0086:1024 frames          2023 ticks read,       13 ticks process
  288049-l0085:1024 frames           456 ticks read,       12 ticks process
  288656-l0084:1024 frames           459 ticks read,       12 ticks process
  289264-l0083:1024 frames           455 ticks read,       12 ticks process
  289868-l0082:1024 frames           451 ticks read,       12 ticks process
  290463-l0081:1024 frames           483 ticks read,       13 ticks process
  291103-l0080:1024 frames           457 ticks read,       11 ticks process
  291705-l0079:1024 frames           454 ticks read,       11 ticks process
  292306-l0078:1024 frames           457 ticks read,       13 ticks process
  292911-l0077:1024 frames           563 ticks read,       15 ticks process
  293649-l0076:1024 frames           466 ticks read,       14 ticks process
  294268-l0075:1024 frames           457 ticks read,       10 ticks process
  294874-l0074:1024 frames           453 ticks read,       14 ticks process
  295474-l0073:1024 frames           453 ticks read,       12 ticks process
  296076-l0072:1024 frames           454 ticks read,       11 ticks process
  296680-l0071:1024 frames           452 ticks read,       12 ticks process
  297278-l0070:1024 frames          9735 ticks read,       18 ticks process
  307196-l0069:1024 frames         21163 ticks read,       19 ticks process
  328577-l0068:1024 frames         21104 ticks read,       19 ticks process
  349869-l0067:1024 frames         21168 ticks read,       19 ticks process
  371223-l0066:1024 frames         21157 ticks read,       18 ticks process
  392568-l0065:1024 frames         21112 ticks read,       20 ticks process
  413871-l0064:1024 frames         21161 ticks read,       19 ticks process
  435247-l0063:1024 frames         21113 ticks read,       19 ticks process
  456556-l0062:1024 frames         21041 ticks read,       18 ticks process
  477785-l0061:1024 frames         21155 ticks read,       19 ticks process
  499123-l0060:1024 frames         21106 ticks read,       18 ticks process
  520416-l0059:1024 frames         21169 ticks read,       18 ticks process
  541770-l0058:1024 frames         21119 ticks read,       20 ticks process
  563080-l0057:1024 frames         21167 ticks read,       19 ticks process
  584434-l0056:1024 frames         21149 ticks read,       18 ticks process
  605770-l0055:1024 frames         21155 ticks read,       19 ticks process
  627112-l0054:1024 frames         21148 ticks read,       19 ticks process
  648468-l0053:1024 frames         21180 ticks read,       19 ticks process
  669836-l0052:1024 frames         21090 ticks read,       19 ticks process
  691111-l0051:1024 frames         21236 ticks read,       20 ticks process
  712645-l0050:1024 frames         20952 ticks read,       19 ticks process
  733783-l0049:1024 frames         21117 ticks read,       18 ticks process
  755088-l0048:1024 frames         21158 ticks read,       18 ticks process
  776452-l0047:1024 frames         21117 ticks read,       19 ticks process
  797752-l0046:1024 frames          6071 ticks read,       17 ticks process
  804001-l0045:1024 frames           461 ticks read,       12 ticks process
  804620-l0044:1024 frames           456 ticks read,       13 ticks process
  805223-l0043:1024 frames           454 ticks read,       12 ticks process
  805823-l0042:1024 frames           456 ticks read,       13 ticks process
  806428-l0041:1024 frames           452 ticks read,       12 ticks process
  807028-l0040:1024 frames           452 ticks read,       11 ticks process
  807627-l0039:1024 frames           483 ticks read,       13 ticks process
  808266-l0038:1024 frames           455 ticks read,       14 ticks process
  808869-l0037:1024 frames           453 ticks read,       13 ticks process
  809469-l0036:1024 frames           734 ticks read,       20 ticks process
  810400-l0035:1024 frames           469 ticks read,       13 ticks process
  811025-l0034:1024 frames           460 ticks read,       11 ticks process
  811636-l0033:1024 frames           456 ticks read,       12 ticks process
  812239-l0032:1024 frames           458 ticks read,       13 ticks process
  812846-l0031:1024 frames           566 ticks read,       16 ticks process
  813586-l0030:1024 frames          5340 ticks read,       14 ticks process
  819096-l0029:1024 frames         21161 ticks read,       16 ticks process
  840440-l0028:1024 frames         21118 ticks read,       19 ticks process
  861744-l0027:1024 frames         21167 ticks read,       18 ticks process
  883095-l0026:1024 frames         21220 ticks read,       19 ticks process
  904504-l0025:1024 frames         21089 ticks read,       16 ticks process
  925775-l0024:1024 frames         21124 ticks read,       19 ticks process
  947085-l0023:1024 frames         21153 ticks read,       17 ticks process
  968423-l0022:1024 frames         21142 ticks read,       20 ticks process
  989754-l0021:1024 frames         21164 ticks read,       18 ticks process
 1011134-l0020:1024 frames         21126 ticks read,       18 ticks process
 1032444-l0019:1024 frames         21153 ticks read,       18 ticks process
 1053786-l0018:1024 frames         21129 ticks read,       18 ticks process
 1075123-l0017:1024 frames         21115 ticks read,       19 ticks process
 1096429-l0016:1024 frames         21162 ticks read,       18 ticks process
 1117806-l0015:1024 frames         21175 ticks read,       20 ticks process
 1139171-l0014:1024 frames         21093 ticks read,       18 ticks process
 1160452-l0013:1024 frames         19131 ticks read,       18 ticks process
 1179789-l0012:1024 frames           461 ticks read,       13 ticks process
 1180410-l0011:1024 frames           455 ticks read,       12 ticks process
 1181016-l0010:1024 frames           456 ticks read,      159 ticks process
overrun occurred
PIPE
ALSA lib pcm.c:7245:(snd_pcm_recover) overrun occured
 1181786-l0009:1024 frames            24 ticks read,      935 ticks process
 1182911-l0008:1024 frames         22105 ticks read,       19 ticks process
 1205210-l0007:1024 frames         20603 ticks read,       19 ticks process
 1226000-l0006:1024 frames         21102 ticks read,       18 ticks process
 1247285-l0005:1024 frames         21123 ticks read,       17 ticks process
 1268588-l0004:1024 frames         21146 ticks read,       18 ticks process
 1289920-l0003:1024 frames         21138 ticks read,       17 ticks process
 1311244-l0002:1024 frames         21158 ticks read,       18 ticks process
 1332585-l0001:1024 frames         21148 ticks read,       18 ticks process
 1353922-l0000:1024 frames          5404 ticks read,       15 ticks process
.end
.drain
.pcm_close
.free
~ #



Timestamps?

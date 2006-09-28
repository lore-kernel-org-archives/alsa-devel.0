From: "YongLi" <sdshliyong@163.com>
Subject: Alsa driver data transfer problem: the MSB is changed
	to 1
Date: Thu, 28 Sep 2006 16:43:06 +0800
Message-ID: <001901c6e2da$216e9140$9b01a8c0@LiYong>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello All,

I am desiging a TI sound card driver on my ARM board using Linux 2.6.18.

The ARM SOC uses IIS and IIC to control this soud codec chip. 

I found a stranger problem reltaed to the sound PCM data: The data transfered by DMA is different from the data I write to the sound device!

If I perform this command:

cat test.txt > /dev/dsp

using the printk to trace the data flow, I found the snd_pcm_oss_write function write all the data in test.txt to 
substream->runtime->oss.buffer. However, In the snd_pcm_plug_write_transfer function, the channel changes and the data is different:

original data(text.txt):
[00]=30
[01]=31
[02]=32
[03]=33
[04]=34
[05]=35
[06]=36
[07]=37
[08]=38
[09]=39
[10]=0a

The modified data:
[00]=00
[01]=b0
[02]=00
[03]=b0
[04]=00
[05]=b1
[06]=00
[07]=b1
[08]=00
[09]=b2
[10]=00
[11]=b2
[12]=00
[13]=b3
[14]=00
[15]=b3

It seems that all the 8th bit are changed to 1. I am not sure if it is correct.

Thank you!

Tyler Li

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

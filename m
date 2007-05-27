From: Matthias Nyffenegger <matthias.nyffenegger@bluewin.ch>
Subject: alsa playback channel interleaving question
Date: Sun, 27 May 2007 22:36:10 +0200
Message-ID: <4659EBBA.9050701@bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail18.bluewin.ch (mail18.bluewin.ch [195.186.19.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 61DA224699
	for <alsa-devel@alsa-project.org>;
	Sun, 27 May 2007 22:33:26 +0200 (CEST)
Received: from [192.168.1.44] (85.2.12.198) by mail18.bluewin.ch (Bluewin
	7.3.121) id 4649A0200026FBF9 for alsa-devel@alsa-project.org;
	Sun, 27 May 2007 20:33:25 +0000
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

Hi,

Earlier this year I wrote to this list:

> I am trying to write an alsa driver for my audiowerk8 soundcard.
> The aw8 uses a Philips saa7146 chipset. There are 2 capture and
> 8 playback channels mapped on the saa7146's DMA as follows:
> 
> DMA1: 2xcapture
> DMA2: 4xplayback
> DMA3: 4xplayback
> 
> Sample format is 16bit.
> 
> Frame format is as follows:
> (A number corresponds to a channel, a stereo channel-pair is embraced
> by [] and 1 digit corresponds to one sample byte)
> 
> capture channels [0,1] on DMA1:        00--11--
> playback channels [2,3],[4,5] on DMA2: 22443355
> playback channels [6,7],[8,9] on DMA3: 66887799

I tried to find a way to handle this in the card, but this special 
interleaving
for the playback channels is by hardware restriction and can't be worked 
around
in the soundcard itself.
AFAIK alsa provides the samples interleaved like 22334455 (66778899). To 
avoid
channel switching I guess some special processing in the alsa driver is 
required.
Where is this done best? Do I have to move around the samples in the 
interrupt
handler or does alsa provide some (possibly better) means to achive the 
correct
(for the soundcard) interleaving?

Regards, Matthias

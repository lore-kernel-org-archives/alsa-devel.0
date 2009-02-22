From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Subject: Problem recording from an RME Hammerfall DSP 9632
Date: Sun, 22 Feb 2009 16:33:20 +0100
Message-ID: <m33ae6bi67.fsf@quimbies.gnus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id B8E8424563
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 16:40:02 +0100 (CET)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LbGR0-00072D-8B
	for alsa-devel@alsa-project.org; Sun, 22 Feb 2009 15:40:02 +0000
Received: from cm-84.215.28.140.getinternet.no ([84.215.28.140])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 15:40:02 +0000
Received: from larsi by cm-84.215.28.140.getinternet.no with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 15:40:02 +0000
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

At least that's what I think I have.  lspci says:

00:08.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP (rev 97)

Playback works just fine, and analogue input works as well.  With
hdspmixer I'm able to route the analogue input to the SPDIF outputs,
and I'm able to control the volume of the playback via amixer:

[larsi@rocket-sam /tmp]$ amixer cset numid=5 16,8,32768
numid=5,iface=HWDEP,name='Mixer'
  ; type=INTEGER,access=rw------,values=3,min=0,max=65536,step=1
  : values=0,0,0
$ amixer cset numid=5 17,9,32768

(etc)

So playback and routing from inputs to outputs works as expected.

However, I'm not able to record anything.

$ arecord -t raw -r 44100 -c 2 -f S16_LE | od
Recording raw data 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
0000000 000000 000000 000000 000000 000000 000000 000000 000000
*

So I'm getting output from the capture device -- but it's all zeroes.

I've tried using amixer to route everything to everything else, but that
doesn't have any effect for arecord, either.

What am I missing?

-- 
(domestic pets only, the antidote for overdose, milk.)
  larsi@gnus.org * Lars Magne Ingebrigtsen

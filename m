From: Peter Vollmer <remllov_@gmx.de>
Subject: ice1712 - consumer mode capture
Date: Mon, 16 Jun 2003 15:27:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.2.20030616152626.09e0abc0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I'm using the Terratec EWS88MT (ice1712) and trying to track down some 
problems I have with the consumer capture mode ( multitrack works )
When doing a
arecord -r 48000 -c 2 -f S16_LE -D hw:0,1,0 | hexdump
with a stereo input of L: silence R: 10 Hz sine
I get some weird mirroring of PCM bytes :
wav header ...
0000000 4952 4646 ff24 7fff 4157 4556 6d66 2074
0000010 0010 0000 0001 0002 bb80 0000 ee00 0002
0000020 0004 0010 6164 6174 ff00 7fff 0000 0000
0000030 0000 0000 0000 0000 0000 0000 0000 0000
*
pcm data, sine starts on rigt channel,
silence on left channel
0000d20 0101 0101 0101 0101 0202 0202 0202 0202
0000d30 0303 0303 0404 0404 0404 0404 0404 0404
0000d40 0505 0505 0606 0606 0606 0606 0707 0707
0000d50 0707 0707 0808 0808 0909 0909 0909 0909
0000d60 0a0a 0a0a 0a0a 0a0a 0b0b 0b0b 0b0b 0b0b
0000d70 0c0c 0c0c 0c0c 0c0c 0d0d 0d0d 0e0e 0e0e
0000d80 0e0e 0e0e 0f0f 0f0f 1010 1010 1010 1010
0000d90 1010 1010 1111 1111 1212 1212 1212 1212
0000da0 1313 1313 1313 1313 1414 1414 1515 1515
0000db0 1515 1515 1616 1616 1616 1616 1717 1717
0000dc0 1818 1818 1818 1818 1919 1919 1919 1919
0000dd0 1a1a 1a1a 1a1a 1a1a 1b1b 1b1b 1c1c 1c1c
0000de0 1c1c 1c1c 1d1d 1d1d 1d1d 1d1d 1e1e 1e1e
0000df0 1e1e 1e1e 1f1f 1f1f 2020 2020 2020 2020

when it should look similar to this
0018 0000 0019 0000 0020 0000 ...

Was this the reason for 'Consumer mode does not work well at the moment 
--jk' at module startup ?

I noticed this problems first on a non PC platform (xscale ixp425) which is 
not fully PCI compliant and lacks some PCI-DMA transfer modes. So I first 
assumed some PCI problems.
But checking back on PC/alsa 0.9.3 I found this similar behaviour. Now I 
would think that the initialisation for consumer record is broken somehow. 
Any suggestions/ideas ?
Thanks
Peter



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5

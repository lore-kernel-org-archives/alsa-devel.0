From: Matthias Nyffenegger <matthias.nyffenegger@bluewin.ch>
Subject: DMA, substream, frame,
	channel - how is this all related
Date: Fri, 02 Mar 2007 22:57:39 +0100
Message-ID: <45E89DD3.2080405@bluewin.ch>
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

Hi,

I am trying to write an alsa driver for my audiowerk8 soundcard.
The aw8 uses a Philips saa7146 chipset. There are 2 capture and
8 playback channels mapped on the saa7146's DMA as follows:

DMA1: 2xcapture
DMA2: 4xplayback
DMA3: 4xplayback

Sample format is 16bit.

Frame format is as follows:
(A number corresponds to a channel, a stereo channel-pair is embraced
by [] and 1 digit corresponds to one sample byte)

capture channels [0,1] on DMA1:        00--11--
playback channels [2,3],[4,5] on DMA2: 22443355
playback channels [6,7],[8,9] on DMA3: 66887799

I guess this is interleaved format.

Since I don't really understand the relation between DMA, substreams,
frames and channels I wonder how a alsa substreams map best to this
configuration:
1) 1 substream per DMA
   -> can alsa handle frames with more than 2 channels, and if yes, how?
2) 1 substream per stereo channel-pair
3) 1 substream per channel


Regards, Matthias




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

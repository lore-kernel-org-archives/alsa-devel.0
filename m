From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: DMA, substream, frame,
 channel - how is this all related
Date: Sat, 3 Mar 2007 15:25:00 +0100
Message-ID: <20070303152500.15233bd2.pochini@shiny.it>
References: <45E89DD3.2080405@bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45E89DD3.2080405@bluewin.ch>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Matthias Nyffenegger <matthias.nyffenegger@bluewin.ch>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 02 Mar 2007 22:57:39 +0100
Matthias Nyffenegger <matthias.nyffenegger@bluewin.ch> wrote:

> Hi,
> 
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
> 
> I guess this is interleaved format.

Not exactly. The interleaved format used by ALSA and most hardware is that
the data of each audio frame is written requentially [0,1,2,3,...]. In you
case the data is interleaved, but the channel order is different [0,2,1,3].
It means that if you try to play a stereo sound through DMA2 the sound is
sent to the left channels of the two stereo pairs. You can solve this
problem later.


> Since I don't really understand the relation between DMA, substreams,
> frames and channels I wonder how a alsa substreams map best to this
> configuration:

DMA channels depend on the hardware. A substream is a logical thing. You
have to decide their relation.


> 1) 1 substream per DMA

The simplest way. The downside is that who opens the device monopolyzes all
4 channels regardless how may it really uses.


>    -> can alsa handle frames with more than 2 channels, and if yes, how?

You have to set it, just like any other parameter, constraint, capability:

substream->runtime->hw.channels_max = n;


> 2) 1 substream per stereo channel-pair

It's possible only if a DMA channel can handle two independent substreams.
For example, can only one of the spereo pair play something (while the other
is stopped/paused) ?  Other hw limitations may apply (eg. the sample rate
and the playback volume may be the same for all 4 channels).


> 3) 1 substream per channel

Same as above.


--
Giuliano.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: ALSA kernel sequencer client
Date: Mon, 24 Jul 2006 12:48:48 -0400
Message-ID: <1153759729.25859.67.camel@mindpipe>
References: <1153525198.17115.76.camel@mindpipe>
	<20060724111803.GB12899@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060724111803.GB12899@turing.informatik.uni-halle.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-07-24 at 13:18 +0200, Clemens Ladisch wrote:
> Lee Revell wrote:
> > I'm developing a driver for a device that's like an MPU output port, but
> > some extra hardware registers need to be written to when note on/off
> > messages arrive.  Since the MIDI stream must be interpreted and hardware
> > needs to be accessed directly I think I need to develop an ALSA
> > sequencer kernel client.
> 
> Currently, a sequencer client is only used for devices where all MIDI
> messages must be interpreted by the driver and where the device doesn't
> ever see them.  The USB MIDI and serial MIDI drivers do their own
> parsing.
> 
> This doesn't mean that you shouldn't use a sequencer client.
> 

I think I'm going to use a rawmidi device and snoop the MIDI stream for
note on/note off.  It does not look too hard, and unlike the sequencer
is documented.

> > I remember seeing some docs for developing this kind of thing,
> 
> I'm sure there never were such docs.
> 
> > but can't find them - can someone point me in the right direction?
> 
> Use the Source, Luke^H^H^Hee: the USB MIDI driver was a sequencer client
> before October 2002.

Thanks for the info.

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

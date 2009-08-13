From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: ALSA and MP3
Date: Thu, 13 Aug 2009 10:23:49 +0100
Message-ID: <h60m38$hkk$1@ger.gmane.org>
References: <8aaaf9230908130118hec83f4awe28fb5e53b5e02a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 47E9C243D2
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 11:24:03 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MbWXR-0001VQ-HB
	for alsa-devel@alsa-project.org; Thu, 13 Aug 2009 09:24:01 +0000
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2009 09:24:01 +0000
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2009 09:24:01 +0000
In-Reply-To: <8aaaf9230908130118hec83f4awe28fb5e53b5e02a6@mail.gmail.com>
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

'Twas brillig, and gammay at 13/08/09 09:18 did gyre and gimble:
> Hello,
> I am looking at making this product use case possible:
> Audio samples are streamed over wire/wireless from a source device to a sink
> device. The streaming format is in mp3. On the source device I need to
> capture locally played mp3 samples and stream to the sink device. The sink
> device takes care of uncompressing and playback.
> 
> Can we capture compressed mp3 streams directly using ALSA? It is possible to
> capture uncompressed PCM samples using file plug or by other means in
> ALSA. While it is possible to directly read from the mp3 file, I would
> rather grap the samples that a media player sends out because a) it takes
> care of timing b) I can control the media player to play/pause the stream
> and for playlist management. For the user it is transperent - he/she will
> use only the local media player to control the streaming.
> 
> I am not sure if this lies in the domain of ALSA at all - as I understand
> once we are in ALSA we are dealing with only PCM. In such case, please give
> me some pointers where I can look at to make this possible. I am using
> mplayer, but can also look at other types (non-GUI, command-line based). Can
> we do this in a non-media player specific way?

Sounds like something that is much more in the gstreamer domain I think.

For general purpose interaction with network devices generally for 
desktop audio systems, pulseaudio is more appropriate (it already 
interacts with UPnP devices, native pulseaudio servers and Apple RAOP 
Airtunes devices over the network). It does not deal with codecs at 
present however, but some kind of work in that area will probably have 
to be done eventually (tho' it wont do any encoding/decoding by itself - 
it would always hand over to e.g. gstreamer for this job).

Jump on IRC and have a chat over at #gstreamer or #pulseaudio for 
inspiration.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
   Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
   Mandriva Linux Contributor [http://www.mandriva.com/]
   PulseAudio Hacker [http://www.pulseaudio.org/]
   Trac Hacker [http://trac.edgewall.org/]

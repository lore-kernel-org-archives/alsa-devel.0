From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Driver Programming
Date: Fri, 26 Nov 2004 12:39:07 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411261226040.3150-100000@studcom.urz.uni-halle.de>
References: <41A60B97.3010809@fetron.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41A60B97.3010809@fetron.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Klaus Fetscher <K.Fetscher@t-online.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Klaus Fetscher wrote:
> I want to programm an driver for the Cirrus CS42516. This Codec
> communicates with an ARM9 CPU over 3 I2S channels. I want to use 3
> stereo channels for playing and two stereo channels for receiving the
> data. All three channels are working with the same clock-rate.
>
> I have read the documentation "Writing an Alsa Driver" but I am confused
> about the meaning of PCM Streams and Substreams. What must I declare,
> one PCM Stream with three Substreams or 3 PCM Streams ?

When an application opens a PCM device without specifying a substream
(the standard case), ALSA chooses the first free substream.
Therefore, substreams are usually only used with chips that do
hardware mixing on them and route them to the same output.

If the channels are independent, it's better to use separate streams.

> Is there any existing driver with a similar configuration (more than one
> channel)?

The cmipci driver handles cards with two DACs.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

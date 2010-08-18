From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Information request - writing a driver for a
 virtual soundcard
Date: Wed, 18 Aug 2010 22:00:37 +0200
Message-ID: <20100818200037.GN17833@buzzloop.caiaq.de>
References: <AANLkTiksDnhg=kBupJ1uQO_vXq+8q-tk+TXwAwgtRaSm@mail.gmail.com>
	<20100818191510.GL17833@buzzloop.caiaq.de>
	<AANLkTi=EO295r9BpmR105gYLRsjFhG3_kiD81mHTSLKP@mail.gmail.com>
	<20100818193354.GM17833@buzzloop.caiaq.de>
	<AANLkTimkXD-LMULa4vdMHMSw7Q2aLjHZTuEgm2ts7fYs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C1F3B103830
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 22:00:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimkXD-LMULa4vdMHMSw7Q2aLjHZTuEgm2ts7fYs@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Olof <olof@baah.se>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 18, 2010 at 09:44:05PM +0200, Olof wrote:
> > I still don't understand where the actual audio material has its origin,
> > or where it should be sent to, respectively.
> 
> Origin is anything the user would choose to play on a "normal" system.
> Pure sound from CD, mp3, ogg, wma played with xmmls, totem movie
> player etc. Any application used to play sound on a Linux box. The PCM
> stream would be compressed and transmitted over TCP/IP to the
> smartphone which would play it on its output.

Jup. You can easily do that by capturing the PulseAudio master monitor
and do whatever you like with the data inside your PulseAudio client.

Another option - in case you have full control over the code running on
the smart phone - is to make the phone act as PulseAudio network
service, so multiple other network members could send audio to it, or
receive audio from it. With or without authentication, compressed or
uncompressed and all that, depending on your implementation.

Daniel

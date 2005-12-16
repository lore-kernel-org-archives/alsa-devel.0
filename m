From: "James C. Georgas" <jgeorgas@rogers.com>
Subject: Re: broken emu10k1 ADC
Date: Fri, 16 Dec 2005 16:06:14 -0500
Message-ID: <1134767174.12185.34.camel@Rainsong.home>
References: <1134683387.12352.34.camel@Rainsong.home>
	 <43A1E847.8010601@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43A1E847.8010601@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> Hardly and alsa-devel topic...

Update:
	I dug up an old Windows 98 CD, and analog capture works fine on this
platform, so the hardware is good.

> Have you checked which socket the line in is connected to.
> If it is the Line in, you will get stereo,
> If it is the Mic in, you will get a single channel.
> If you are recording from the CD/Aux input on the sound card, linked 
> internally to the CD player, then you might have a valid problem.

Yeah, I tried them all. The card is only capturing the left channel for
any analog input (i.e. line, cd, aux, phone, mic, mix, mix mono).

By "capturing", I mean "routing the analog source to the STAC9708-11's
ADC outputs".

I suppose the disconnect could be after the ADC instead of before it,
but if this is the case, then both the AC97 Playback control and the
AC97 Capture control would have to have the same bug, since the right
channel is missing on both of their outputs.

Still not on the list; please CC me.

Thanks

-- 
James C. Georgas <jgeorgas@rogers.com>



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

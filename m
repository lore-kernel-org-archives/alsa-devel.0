From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: RME HDSP 9652 syncing problem
Date: Mon, 17 May 2004 11:13:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <34707.217.235.25.99.1084785191.squirrel@www.undata.org>
References: <1084770662.18496.10.camel@winter.nautronix>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1084770662.18496.10.camel@winter.nautronix>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Hi,
>
> I have been using the RME HDSP 9652 for several months now and have
> noticed a problem with the synchonisation.
>
> I have an external word clock which runs into 2 RME analog/digital
> interfaces, as well as the HDSP itself.
>
> The HDSP is setup to sync to word clock input, and sample clock source
> is autosync.
>
> The problem I am seeing is that if I transmit to 24 x 48kHz channels,
> then the first 8 channels (ADAT-1) seem to continuously loose their Sync
> status and I can pops (nulls) and clicks (spikes) in the recorded data
> (by looping the transmit back into receive). Running hdspmixer also
> shows the levels of the first 8 channels jumping around as the sync is
> lost.
>
> Does anyone know what could be causing this problem? I have attached
> information about the system that I think is relevant.
>
> Thanks
> Ryan Winter
>
>

Hi Ryan,

I can't see any problem with your software setup. Moreover the alsa
controls you use for this are basically only wrappers to hardware
registers, so I would tend to think that your problem is hardware related.
What comes to my mind immediately, rather than a faulty card (though it's
possible), would be a faulty cable or a problem in the WordClock chain. I
suppose all the external converters you use are slaved to the same device
as the card, so maybe one of those converters is defective or wired with a
faulty WordClock cable or termination. What happens if you swap the
converters ADAT ports ? Do you still get sync issues only on ADAT-1 ? For
the pops and clicks issue, how do you loop the transmit back into the
receive ?

Thomas





-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click

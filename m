From: Brian L Scipioni <brian@gaugetheory.org>
Subject: Re: ALSA, JACK, ASIO
Date: Thu, 10 Feb 2005 04:56:55 -0500
Message-ID: <1108029414.1806.23.camel@radium.gaugetheory.org>
References: <9e47339105020710162d246fed@mail.gmail.com>
	 <s5his52u6et.wl@alsa2.suse.de> <9e473391050208182623c5b3ea@mail.gmail.com>
	 <1107982073.1806.10.camel@radium.gaugetheory.org>
	 <87y8dxp9fm.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <87y8dxp9fm.fsf@sulphur.joq.us>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Jack O'Quin <joq@io.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks.  A couple more ASIO questions:

Could the ASIO protocol be implemented on top of ALSA or within JACK? 
Would it provide for low(er) latency operation on cards that support it?
Would ASIO perhaps just provide some parallel functionality that is
already represented in ALSA and/or JACK?

thanks,
brian


On Wed, 2005-02-09 at 19:04, Jack O'Quin wrote:
> Brian L Scipioni <brian@gaugetheory.org> writes:
> 
> > This may not be an alsa issue but:
> >
> > Can/does ASIO run on top of ALSA using JACK? JACK claims the "-a" option
> > for ASIO  on supported cards, but it will not accept the option. jackd
> > -h does not list the option, but the docs at LAU Guide do.
> >
> > jackd -a -d alsa
> 
> The poorly-named --asio option was removed from JACK a year or two
> ago.  It had nothing to do with running any real ASIO code in Linux,
> but just described an option for checking realtime overruns "similar"
> to the way ASIO (presumably) does.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

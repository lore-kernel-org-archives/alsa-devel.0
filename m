From: Richard Bown <bownie@bownie.com>
Subject: Re: ALSA instrument API
Date: Fri, 5 Apr 2002 07:41:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204050643.AFG63235@msgdirector2.onetel.net.uk>
References: <200204041124.AFF89495@msgdirector2.onetel.net.uk> <200204041431.JAA13020@renoir.op.net> <20020404161319.5d5062bf.coding@reduz.com.ar>
Reply-To: bownie@bownie.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020404161319.5d5062bf.coding@reduz.com.ar>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Juan Linietsky <coding@reduz.com.ar>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Juan Linietsky wrote:

> I'm interested in extending the api only for retrieval of info about 
> bank names/info, patch names/info and controller names. Info would
> default to some midi standard defaults.  What do you have in mind for
> an instrument api?

I don't have anything in mind for the instrument API - I'm just curious really.
>From our app's perspective we want to be informed about possible instruments
sometimes and prescriptive the rest of the time.  I'm wondering actually how
much you really need at the driver level for this kind of thing?

Once you've worked out the device you're talking to its up to the user (or other
enthusiastic individuals) to create templates of device specific MIDI mappings
to allow the application's presentation of the features.  It would be nice to
have self describing MIDI devices but this isn't really part of the standard is
it?  And (again) how would you be consistent across external and soundcard
devices?  We already see this kind of distinction in OSS and ALSA and one thing
any instrument interface is going to want is consistency of approach.

Anyway, just some thoughts.  For the moment I'm going to implement our ALSA
layer such that it reports devices, synths, channels etc. and creates an
Instrument map for the application to use.  We'll see how we get on with that
approach.

R
-- 
http://www.all-day-breakfast.com/rosegarden
http://www.bownie.com

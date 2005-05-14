From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Re: Several questions about digital mixing
 /plugin/sound effect
Date: Sat, 14 May 2005 14:40:12 +1000
Message-ID: <20050514144012.41e0bdd0.erikd-alsa@mega-nerd.com>
References: <20050514041056.74619.qmail@web31702.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050514041056.74619.qmail@web31702.mail.mud.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
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

rong wang wrote:

> 1. if we have several audio streams needed to be mixed
> before sending to CODEC, Should we
>    have to use server such as Jacked to do the mixing
> work? From document, Jacked is majorly used for data
> streaming from one application to another application,
> if I don't have such need, only for digital mixing,
> Could I avoid to use Jacked such kind of audio server
> for digital mixing purpose?

Yes, noone is forcing you to use Jackd.

> For Jack server, how many
> applications support and use Jacked?

Dozens.

> >From searching on the web, it seems not a lot.

Get a better search engine :-).

> 2.  Is the alsa-lib  statically linked to audio
> application? Or the library is dynamically linked? 

Usually dynamically linked.

> 3. Where the software sound effect processing (Chorus,
> echo cancellation etc) in the ALSA?

I don't know about echo cancelation, but there are a couple of
choruses. I run Debian on my machines and I ahve the following
ladpsa collections installed:

    swh-plugins - Steve Harris's LADSPA plugins
    tap-plugins - Tom's Audio Processing LADSPA plugins
    cmt - Computer Music Toolkit (cmt) a collection of LADSPA plugins


> 4. Is there any document to introduce ALSA plugin (how
> to expand it to include our own plugin, how it works
> etc)?

    www.ladspa.org

> 5. If I have one application tried to playback
> different format sound, MP3, AAC etc, if I have my own
> MP3, AAC decoder, Is there anyway application can
> unplug one SW CODEC and load another plugin depends on
> File format on the fly?

No LADSPA only transports floating point PCM audio data, it can't
transport encoded data.

> 6. If on my machine, I cannot run float data type,
> only integer, Could I still use Jacked, according to
>    doc, Jacked is 32 bit float?

No, Jack (and LADSPA) are floating point data only.

> Is there any other
> better choice? 

Not that I know of.

> 7. If I don't need sequencer etc stuff, How could I
> remove the sequencer from lib and rebuild the lib?

What do you think you would gain from this? 20k of disk space?

YOu might also want to join the Linux-audio-devel mailing
list. The ALSA list is pretty much ALSA specific.

Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
Everyone seems to assume that the current system in America is capitalism.
I beg to differ. True capitalism does not involve false advertising,
distribution cartels, or political lobbying for special advantages in the
market. How can you call Microsoft or the RIAA capitalist, when their main
business is interfering with a free market? Some of us would like to see a
*return* to capitalism in this country. - Jim Flynn on Linuxtoday.com


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click

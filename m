From: Pete Black <pete@claudia.daemon.sh>
Subject: ALSA 'share' device, or 'software multi-open'
Date: Mon, 30 Sep 2002 12:46:11 +1200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D979ED3.3050205@claudia.daemon.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi there,

I am interested in knowing what ALSA's current support is for a 
'software multi-open' driver/plugin, that can take the output of several 
streams, mix them together in realtime and play them out to the soundcard.

 From browing the list archives, I come across several references to a 
'share' plugin, but also several references to the fact that the author 
of the plugin is the only one who has ever actually used it.

I am aware of esd/arts/JACK etc., but none of these projects do what I 
would like to have - a simple, lowish-latency, application-transparent 
method of sharing a sound card.

I have also seen posts on the same alsa-devel mailing list to the effect 
that mixing several audio streams in software is easy, and an 
application-level problem hence the lack of implementation in ALSA 
itself. I think that idea is ludicrous, and this type of sharing is 
absolutely necessary, especially when using Linux to make music with the 
variety of software synths that are now available.

Specifically, I have a CMI8738 card, and I want to be able to run seq24 
(MIDI sequencer),and a couple of separate software synths at the same time.

I understand that drivers such as the SBLive and trident support 
multi-open, passing the streams to the hardware for mixing, but why does 
there seem to be no way to do the same thing with software?

ESD doesn't seem to put any appreciable load on the system, and network 
transparency is not really a requirement, at least for me.

Does ALSAs architecture make doing this in software at the driver/plugin 
level difficult, or is it just that nobody wants this capability?

And, should it be that this functionality is simply not implemented, 
what would be the best way to approach building in this capability - the 
plugin API, an extended, card-specific driver, or what?

Thanks

-Pete







-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

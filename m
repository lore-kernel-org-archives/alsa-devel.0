From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: mixer device
Date: Thu, 13 May 2004 11:51:13 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405131551.i4DFpEOM024442@dhin.linuxaudiosystems.com>
References: <20040513153457.GE6913@sunrise.pg.gda.pl>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 13 May 2004 17:34:57 +0200."
             <20040513153457.GE6913@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>When using OSS you can just do mixer ioctl's on the opened PCM fd.

When using OSS, you can't model a lot of the functionality present in
contemporary audio interface hardware mixers.

So there's a choice: a limited, simple API that fails to support card
features, or a complex API that over time gets a simpler version added
to it.

Right now, ALSA is following the second path, but is not very far
along the "simpler API" part of it.

>as possible. It should be constructed from user point of view.

What user? A programmer? A home theater owner who wants to move AC3
data from a DVD through their 5.1 system? A professional studio owner
with 48 channels of digital I/O? A game player? A web browser?

I think that *applications* needs to be designed from a user point of
view, not APIs. And APIs need to, in those famous words, "make easy
things easy, hard things simple and the impossible a little difficult".

>How easy is to use it and which functionality it gives us.

I have never been a big fan of the way that the ALSA API has turned
out, but as someone who has followed it all the way from 0.4 onwards,
I have to acknowledge that there are good reasons, mostly very good
reasons, for nearly every aspect of its design.

I wrote JACK to massively simplify the abstraction used by audio
applications, but it doesn't address the mixer situation. 


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click

From: Paul Davis <pbd@op.net>
Subject: Re: PCM API questions
Date: Mon, 24 Jun 2002 17:14:36 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206242113.g5OLDAf25236@post2.fast.net>
References: <20020624165734.GA11051@reverberate.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 24 Jun 2002 09:57:34 PDT."
             <20020624165734.GA11051@reverberate.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Joshua Haberman <joshua@haberman.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Maybe this is what the "default" device is intended for, but can it
>accommodate more than one card?  I happen to have a sound card built into
>my motherboard and another in a PCI slot -- how do I tell XMMS which one
>to use?

an excellent context for the question. 

i want to extend the question just a little. it seems from watching a
few friends who use windows audio apps that its conventional there to
name audio output options after the physical hardware. so you see
things like "Terratec XWP" and "Ensoniq PCM" and so forth. This is
nice because its what a lot of users think in terms of.

in ALSA, we really don't see such naming at all. thats fine with me,
but it leads me to wonder. the reason that the names are useful is
that they don't move around when you change the install order for the
modules (for example). so, the "Ensoniq PCM" is always the "Ensoniq
PCM" whether its the first card or the second.

Now, AFAICT, Windows doesn't make it very easy to deal with multiple
"Ensoniq PCM" devices whereas ALSA does. However, there does seem to
be something "missing" when we present users with

   plughw:1,0

as the name of suitably flexible device for general purpose audio on
the second card in the absence of a ~/.asoundrc file ....

So I'm left wondering what naming scheme to use to get a more flexible
way of referring to cards *without* using an ~/.asoundrc
file. Alternatively, how to autogenerate the file so that it provides
nice names?

--p


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/

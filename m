From: Christian Esken <c.esken@cityweb.de>
Subject: Re: how to write a mixer using alsa lib api ?
Date: Mon, 24 Nov 2003 00:01:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311240001.53427.c.esken@cityweb.de>
References: <20031020073544.92112.qmail@web15307.mail.bjs.yahoo.com> <Pine.OSF.4.58.0310211216380.242455@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.OSF.4.58.0310211216380.242455@kosh.hut.fi>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 21 October 2003 11:16, Tommi Sakari Uimonen wrote:
> > and I want to know where I find some documnent to know
> > how to use these alsa lib api,namely,I want a
> > specification of these api,thanks a lots .
>
> http://www.alsa-project.org/alsa-doc/alsa-lib/

Nice hint. But your comment is barely nothing more than a RTFM. If the mixer 
documentation would be usable this would be OK. But actually the 
documentation is lacking a lot, especially with the mixer interface. Need an 
example:

int snd_mixer_poll_descriptors()
Documnetation says: "get poll descriptors"

Cool: "get poll descriptors". I wanted to do this my whole life. :) Whatever 
these "poll descriptors" do, I do not know. But it is important, or is it 
not?!? :-(

More questions: Why are there multiple API's: Should I use the "normal" or the 
"simple" API (BTW:The simple mixer interface from mixer/simple.c is not on 
the Web).

Need more examples:
snd_mixer_set_callback()
What good is this function for? A callback for what? And is this optional, 
just to avoid polling or and explicite update or what?

snd_mixer_elem_attach()
Documentation say: "Attach an HCTL to an opened mixer."
Whatever an HCTL might be, I don't know. Why I should do it, I do not know as 
well. The snd_mixer_attach() documentation does not tell me. It also does not 
tell me what is an in- or out-parameter and if I have to allocate the memory 
for the data (if there are any) of the out-parameter myself.

snd_mixer_elem_type_t snd_mixer_elem_get_type ( const snd_mixer_elem_t * obj ) 
Documentation does not tell me what types exist: snd_mixer_elem_type_t is not 
hyperlinked and neither be found under "Data Structures" nor under "Data 
Fields"

Sorry if my posting sounds rude, but I am fighting since months with the mixer 
API and the frustration is growing: I am not even able to read the correct 
playback volume if another application changes it. I went to reading the 
alsa-lib source, because alsamixer is not a really good example (it also has 
no documentation). 

Sorry again, but with ALSA1.0 approaching, the documentation clearly needs an 
upgrade: The Mixer is not even contained in the "Module Index" of the 
mentioned web page.
Telling application developers that want to push ALSA to RTFM is not the right 
way IMHO. 

Greetings,
  Chris


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

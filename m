From: Corvus Corax <corvus-ml@cybertrench.com>
Subject: Re: changing audio routing through mixer	controls	with
 emu10k1/audigy
Date: Wed, 28 Sep 2005 00:22:46 +0200
Message-ID: <20050928002246.7a750e95@VikingPC.home>
References: <20050925234658.4d008c9e@VikingPC.home>
	<1127696645.26124.4.camel@mindpipe>
	<1127696983.26124.6.camel@mindpipe>
	<20050926223642.60df06fb@VikingPC.home>
	<1127778203.28523.34.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1127778203.28523.34.camel@mindpipe>
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

Am Mon, 26 Sep 2005 19:43:22 -0400
schrieb Lee Revell <rlrevell@joe-job.com>:

> On Mon, 2005-09-26 at 22:36 +0000, Corvus Corax wrote:
> > The tools (unlike their OSS counterparts which are segfaulting on this
> > arch) are compiling and working on my system, however there is either
> > no effect on the DSP, or garbage out of the speaker - while the front
> > end seems to be working ( additional mixer sliders and all appear and
> > seem to be working, however without any effect on sound output) 
> 
> Did you run the init_live script?  This should produce the same mixer
> state that the driver contains by default.
> 
> Lee
> 

yes, its running "flawlessly" and the qlo10k1 program is displaying all those
quite complex routes as it should (I guess at least, they make sense that way
they are)

Only the soundcard doesnt behave like it should, regardless of loaded patch set
I get one of three outcomes:

1 no sound at all
2 sound like without any patches loaded (only 2 speakers active)
3 like two, but with more or less extreme distortion on the left speaker

those card status change randomly when I remove or add routings or patches,
so even when I remove I route totally unrelated to the PCM--....-->Speaker path
so soundcards behaviour sometimes changes - totally randomly

when I say "clear_dsp" the card works like in standard setup and no routes or
patches are displayed - I guess that function is at least working as it should.

(mentionable that the same card worked with a tuned custom patchset under OSS
 on my old linux system and the windows drivers work as expected too, so the
 DSP hardware is likely to be ok)

could it be that some of the data to be loaded into the DSP may be of
wrong type - or loaded onto a wrong address in DSP memory - doe to being run on
a 64bit system with pointers twice as big? (sizeof(int*)=8)

how could I debug this?



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

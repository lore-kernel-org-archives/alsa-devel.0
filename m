From: peloy@chapus.net (Eloy A. Paris)
Subject: Re: Occasional metallic sound when recording (cs46xx)
Date: Thu, 23 Oct 2003 10:49:37 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <878yncuhz2.fsf@canaima.chapus.net>
References: <200310221739.h9MHd0m1024945@oud.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200310221739.h9MHd0m1024945@oud.linuxaudiosystems.com> (Paul
 Davis's message of "Wed, 22 Oct 2003 13:39:00 -0400")
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

Hello,

Paul Davis <paul@linuxaudiosystems.com> writes:

> its almost certainly a software problem in mythTV and gnome sound
> recorder. i've written code that does this several times - every time
> it takes me ages to figure out why, and then i can never remember when
> i do it the next time. its related to off-by-1 errors in processing
> incoming audio.
>
> not necessarily, of course, just a point of view.

Hhhmmmm, but wouldn't a problem like this cause the metallic sound
everytime? In my case it works fine must of the time, but every now and
then I get the darn metallic noise. Also, I can fix it by running the
alsamixer and toggling on and off the capture setting of the ADC
channel.

I forgot to mention that when I am hearing the metallic sound, if I
increase the volume of the "line in" channel in the mixer, I hear the
audio from the TV tuner just fine (this is the bypass, from line-in
directly to the speakers). This confirms that the input signal is fine,
I think.

What I'll try next is to connect the audio output from the TV tuner card
to my sound card's microphone input, instead of the line-in input just
to see if there are any differences, although I doubt it.

Other suggestions?

Thanks,

Eloy.-


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/

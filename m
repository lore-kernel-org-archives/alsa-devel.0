From: peloy@chapus.net (Eloy A. Paris)
Subject: Re: Occasional metallic sound when recording (cs46xx)
Date: Thu, 23 Oct 2003 15:01:50 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87oew7g4m9.fsf@canaima.chapus.net>
References: <200310221739.h9MHd0m1024945@oud.linuxaudiosystems.com>
	<3F981FF3.4040902@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F981FF3.4040902@gmx.at> (Wilfried Weissmann's message of
 "Thu, 23 Oct 2003 20:37:39 +0200")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

Wilfried Weissmann <Wilfried.Weissmann@gmx.at> writes:

> i also have the same problem with speakfreely with my cs46xx.

I'm sorry for you but am happy at the same time that I am not the only
one experiencing this.

> it does not look like the metallic sound is triggered by any specific
> event (load, I/O,...). out of the sudden somethings goes wrong.

Yes, I agree, doesn't seem related to anything in particular.

> also experienced it with the kde sound recorder. but i have not
> updated the alsa driver for a while (still 0.9.5 or so).

I am running version 0.9.8 of the alsa-driver, and the problem is still
there.

> toggleing the ADC sounds like a good idea. i have not tried that yet
> but reloading the modules works too.

Well, try doing the ADC thing and let me know if it works for you. This
has the advantage that you don't have to shut down the application you
are using.

> hmm, what makes something sound metallic anyway? echo?

Good question, I wish I knew. I guess I'll try enabling debugging output
in the cs46xx driver. I am particulary interested in knowing what
happens when you toggle capture of the ADC channel in alsamixer.

Cheers,

Eloy.-


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/

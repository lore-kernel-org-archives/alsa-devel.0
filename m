From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Query devices in a non-blocking fashion
Date: Wed, 10 Dec 2003 12:26:53 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20031210122653.pochini@shiny.it>
References: <oprzvc5mu3q1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <oprzvc5mu3q1sf88@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: alsa-devel@lists.sourceforge.net, Paul Davis <paul@linuxaudiosystems.com>
List-Id: alsa-devel@alsa-project.org


On 08-Dec-2003 Arve Knudsen wrote:
> Wether its done via the control or pcm interface, it'd be good to have a
> loose coupling between configuration and streams, so one could could access
> configuration space without locking a stream don't you think?

Yes, of course. Perhaps it can be done already with the current API. I
never investigated how the configuration process works, but I know the
driver can define rule functions to manage complex hw constraints.
Maybe you can change the snd_pcm_hardware_t structure according to the
new setting from those functions. I mean, the application calls
snd_pcm_hw_params_set_rate_near(96000);
The hw_rule function is called, which does pcmhw.channels_max=12;
Paul, Jaroslav, is it possible/legal ?


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

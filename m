From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Cards and PCM instances
Date: Sat, 18 Feb 2006 14:09:28 +0100
Message-ID: <20060218140928.62793ef7.pochini@shiny.it>
References: <20060216114804.698A289A8A@sc8-sf-spam1.sourceforge.net>
	<BAY111-DAV13EC412102C661A02696E1C2F80@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <BAY111-DAV13EC412102C661A02696E1C2F80@phx.gbl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nikhil Rao <nikhil_p_rao@hotmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 16 Feb 2006 21:15:06 -0800
"Nikhil Rao" <nikhil_p_rao@hotmail.com> wrote:

> In "Writing an ALSA driver", the author has mentioned that each card can
> have upto 4 PCM instances.
>
> Does a PCM instance correspond to an independent audio output ?

Mostly, yes, it does, but they can also be related in some ways (eg. if the
card has only one clock generator, all channels share the same clock
frequency).


> For e.g, in the project I am working the hardware  has 2 audio outputs that
> would be used to render 2 separate PCM streams at the same time, would this
> configuration correspond to 2 different PCMs or to 2 different cards ?

2 PCMs is the most obvious config, IMO, expecially if the control interface
is one. With 2 card instances you also need 2 control interfaces.


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

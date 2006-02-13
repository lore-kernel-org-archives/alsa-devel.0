From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: using more than 8 boards of the same kind, at once, on a single system
Date: Mon, 13 Feb 2006 11:18:33 +0000
Message-ID: <ad2655cb0602130318x47bcc98fj@mail.gmail.com>
References: <1139755387.25868.1.camel@lnx.rgptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1139755387.25868.1.camel@lnx.rgptech.com>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: hurricane <hurricane@barmusic.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 12/02/06, hurricane <hurricane@barmusic.com> wrote:
> Hi Folks!
>
>         I have designed a video/audio USB2.0 board (WISIWYG 1.0), that I
> use on
> 2.6.11-1.27_FC3smp that uses the WIS GO7007 chip, and have run into a
> limit of 8 boards that can be recognized for audio by the WIS device
> driver. I need to use up to 48 boards on one system. Video For Linux
> works with this number, but I am at a loss for getting the audio system
> to work with more than 8 boards at once. (My board uses stereo Audio,
> raw pcm)
>

I would have thought that there could be latency problems with this
number of USB devices on the same machine.
What application is this for. maybe separating them to have fewer per
box would be better.
If there are no latency problems, then this would be a good driver for
increasing the amount of sound cards allowable per machine.

James


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

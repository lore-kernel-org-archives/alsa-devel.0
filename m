From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Reminder [Fwd: Alsadriver ca0106]
Date: Sun, 11 Jun 2006 10:12:21 +0100
Message-ID: <448BDE75.80804@superbug.co.uk>
References: <448BC98F.3080105@mnet-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <448BC98F.3080105@mnet-online.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: simon.lewis@mnet-online.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Simon Lewis wrote:
> 
> -------- Original-Nachricht --------
> Betreff: 	Alsadriver ca0106
> Datum: 	Tue, 06 Jun 2006 20:48:00 +0200
> Von: 	Simon Lewis <simon.lewis@mnet-online.de>
> Antwort an: 	simon.lewis@mnet-online.de
> An: 	alsa-devel@lists.sourceforge.net
> 
> 
> 
> Hello Alsa Development
> 
> I have a Creative Labs Soundblaster 7.1 Live 24bit sound card.
> 
> Yast (SuseLINUX 10.1) correctly installs the ca0106 driver for this card.
> 
> However, I do not have a Input level control for the line/mic jack in either;
>        - alsamixer, alsamixergui, kmix or gnome-alsamixer.
> 
> Is this simply a configuration problem or a bug with the driver?
> 
> I notice that ca0106.conf does not have an input definition.
> 

Your version of the snd-ca0106 driver probably does not have them.
The input levels are fixed at 0dB in your version.

cat /proc/asound/version   to find out which version you have.
In the most up to date alsa-driver, one will see input gain controls. I
have only just implemented them.

James

From: Manuel Jander <manuel.jander@usm.cl>
Subject: RE: Sound with metal effect
Date: Fri, 01 Apr 2005 12:58:37 -0400
Message-ID: <1112374717.3167.21.camel@localhost>
References: <XFMail.20050401093951.pochini@shiny.it>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20050401093951.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, 2005-04-01 at 09:39 +0200, Giuliano Pochini wrote:
> On 31-Mar-2005 Laurielle LEA wrote:
> 
> > I'm integrating ALSA to my voipclient (softphone) and
> > my problem is the sound received by the remote user is
> > with metal effect.
> 
> VoIP uses 8KHz sampling rate IIRC. What did you expect ?

Metal effect indicates bad antialiasing filters. That may be caused by
bad hardware, bad hardware setup or a very bad software emulation. 8KHz
sound obviously does not sound CD-quality, but it should not have
aliasing noise. It should just sound with lower bandwidth, specially
higher frequencies being cutoff. Standard phone bandwidth is between
300-3400 Hz.
Software resampling through removing or adding samples, and doing some
mean value cooking is far from optimal. It would be better to use a
recursive Z-tranform (or whatever math tool you prefer) synthesised
algorithm. Even a small IIR filter for postprocessing would barely
consume any CPU power. Such algorithms are well known and available.

Best Regards
-- 
Manuel Jander
Dipl.-Ing. Fachrichtung Elektronik



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30

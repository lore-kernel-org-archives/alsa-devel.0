From: Thorsten Haas <thorsten.haas@gmx.de>
Subject: Re: Re: USB recording - repetitive peaks
Date: Fri, 5 Jul 2002 10:38:36 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207051038.36780.thorsten.haas@gmx.de>
References: <3D208C5C.36649172@ladisch.de> <200207050856.26032.thorsten.haas@gmx.de> <3D255A1F.6090505@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D255A1F.6090505@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Freitag, 5. Juli 2002 10:34 schrieb Patrick Shirkey:
> Thorsten Haas wrote:
> >>>I'm not sure about the sound quality it is definitely better. I will see
> >>>if I can generate a test tone to use instead of actual music.
> >
> > I checked out cvs this morning and compiled. I grabbed my function
> > generator and fed my quattro usb with some signal; 400Hz, 0,7V
> > peak-to-peak.
> >
> > It's working finely now. (no more peaks)
> >
> > I did the same thing some days before. ( Whoever is interested in the
> > results and the output of the oscilloscope:
> > http://www.thorstenhaas.de/alsa.php)
>
> That looks much better.
>
> We still face the problem of accessing all 4 channels at once. AFAICT in
> the .asoundrc file the multi interface option does not have the ability
> to seperately access the channels in non sequential order. Therefore we
> are currently unable to access all the channels on the card because pcm0
> and pcm1 point to the same physical channels input 1 and input 2.
>
> We need to either reorganise the pcm devices for the card or make it
> possible to secify channels in non sequential order using the multi
> interface option in a .asoundrc.

I wish I was much more experienced in programming C++ and the structure of 
ALSA. Actually I am not. So I can hardly follow you what this will mean 
concerning effort and complexity.

So, what will it be?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf

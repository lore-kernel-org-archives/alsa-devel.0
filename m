From: Anders Torger <torger@ludd.luth.se>
Subject: Re: problems with rme digi96/8
Date: Wed, 11 Jun 2003 15:48:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306111548.19324.torger@ludd.luth.se>
References: <1054808252.7022.8.camel@duff> <20030609172302.GA498@tuba.home> <1055337460.1392.45.camel@duff>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1055337460.1392.45.camel@duff>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gorm David Lai <lai@daimi.au.dk>, Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Test this:

aplay -D hw:0,1 -r 44100 -f S16_LE -c 8 /dev/zero

it should work. It works on my card.

The problem in your 

aplay -D hw:0,1 -c 8 ~/cavi/sound/01/01\ Track\ \ 1.wav

is that aplay seems to ignore your -c 8, and reads the wav header 
instead, and sets it to stereo, as you can see in the aplay output, 
where it cleary says that it plays in "Stereo".

/Anders Torger

On Wednesday 11 June 2003 15.17, Gorm David Lai wrote:
> I also have problems with aplay. Maybe this is related?
>
> The following command:
>
> aplay -D hw:0,1 -c 8 ~/cavi/sound/01/01\ Track\ \ 1.wav
>
> Which gives the following output:
>
> Playing WAVE '/users/lai/cavi/sound/01/01 Track  1.wav' : Signed 16
> bit Little Endian, Rate 44100 Hz, Stereo
> aplay: set_params:810: Channels count non available
>
>
> /Gorm
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by:  Etnus, makers of TotalView, The
> best thread debugger on the planet. Designed with thread debugging
> features you've never dreamed of, try TotalView 6 free at
> www.etnus.com. _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.

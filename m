From: Gorm David Lai <lai@daimi.au.dk>
Subject: Re: problems with rme digi96/8
Date: 11 Jun 2003 15:17:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055337460.1392.45.camel@duff>
References: <1054808252.7022.8.camel@duff> <20030605190335.GB493@tuba.home>
	<1054893994.2069.47.camel@duff>  <20030609172302.GA498@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030609172302.GA498@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I also have problems with aplay. Maybe this is related?

The following command:

aplay -D hw:0,1 -c 8 ~/cavi/sound/01/01\ Track\ \ 1.wav

Which gives the following output:

Playing WAVE '/users/lai/cavi/sound/01/01 Track  1.wav' : Signed 16 bit
Little Endian, Rate 44100 Hz, Stereo
aplay: set_params:810: Channels count non available


/Gorm



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.

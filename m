From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: Playing Surround Sound with Alsa Drivers
Date: Thu, 02 Jan 2003 10:40:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E140928.3070200@cucumelo.org>
References: <1041290061.19439.4.camel@TBird.home.net> 	<3E1384CD.9050302@cucumelo.org> <1041466757.11948.4.camel@TBird.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Miguel Pastor <MiguelPastor@adelphia.net>
Cc: Alsa Dev Mail List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>
>
>Actually the drive that I use to send sound to the rears speakers is
>"h:0,1" not "h:1,0". That's because the rear speakers controller is just
>a subdevice of my first and only sound card. That works with no problems
>sending sound only to the rear speakers but not to the four speakers.
>I'm looking for a way to create surround sound using the four speakers.
>There must be a way. Help please!
>
>  
>
Oops! sorry for my misstake, I mean hw:0,0 -> front speakers and 
hw:0,1-> rear speakers (assuming that you got only one soundcard 
installed). In such way it's possible to control each speaker 
independently, programs like xine can take advantage of this.

Then, whatever you want to do is just a software issue. It's not 
possible to send the same output to front and rear just via a simple 
"aplay ...", maybe it's possible to do magic via the .asoundrc stuff 
crearting a virtual device, but I dont know how to do that.

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: Playing Surround Sound with Alsa Drivers
Date: Thu, 02 Jan 2003 01:16:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E1384CD.9050302@cucumelo.org>
References: <1041290061.19439.4.camel@TBird.home.net>
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
>I've just installed the Alsa drivers for my Turtle Beach Santacruz card (CS46XX) 
>and everything is working fine except that I can not get surround sound
>from it. I can see a device surround40 using "amixer -l" command, but I
>cannot use the device to produce sound with aplay, even though I can
>independently send sound to the front or rear spekers.
>Any ideas what can be wrong?
>  
>
It should be possible to have surround40 with the Santa Cruz card, with 
"aplay -D hw:1,0" you should only have sound from the rear speakers.

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

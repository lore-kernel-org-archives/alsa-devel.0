From: Miguel Pastor <MiguelPastor@adelphia.net>
Subject: Re: Playing Surround Sound with Alsa Drivers
Date: 01 Jan 2003 16:19:15 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1041466757.11948.4.camel@TBird.home.net>
References: <1041290061.19439.4.camel@TBird.home.net>
	<3E1384CD.9050302@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E1384CD.9050302@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: Alsa Dev Mail List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Actually the drive that I use to send sound to the rears speakers is
"h:0,1" not "h:1,0". That's because the rear speakers controller is just
a subdevice of my first and only sound card. That works with no problems
sending sound only to the rear speakers but not to the four speakers.
I'm looking for a way to create surround sound using the four speakers.
There must be a way. Help please!

Thanks.

Miguel

On Wed, 2003-01-01 at 16:16, Benny Sjostrand wrote:
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
    _______________________________________________
    Alsa-devel mailing list
    Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
    
    



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Miguel Pastor <MiguelPastor@adelphia.net>
Subject: Re: Playing Surround Sound with Alsa Drivers
Date: 07 Jan 2003 18:07:15 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1041991640.3174.1.camel@TBird.home.net>
References: <1041290061.19439.4.camel@TBird.home.net>
	<3E1384CD.9050302@cucumelo.org> <1041466757.11948.4.camel@TBird.home.net>
	<3E140928.3070200@cucumelo.org>  <s5hvg119t82.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvg119t82.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Benny Sjostrand <gorm@cucumelo.org>, Alsa Dev Mail List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Yes I was able to play surround sound for first time. Very exciting.
Thank you for the good work pushing the penguin army to a more enjoyable
experience with Linux.

Sincerely,

Miguel

On Tue, 2003-01-07 at 01:58, Takashi Iwai wrote:
    At Thu, 02 Jan 2003 10:40:56 +0100,
    Benny Sjostrand wrote:
    > 
    > >
    > >
    > >Actually the drive that I use to send sound to the rears speakers is
    > >"h:0,1" not "h:1,0". That's because the rear speakers controller is just
    > >a subdevice of my first and only sound card. That works with no problems
    > >sending sound only to the rear speakers but not to the four speakers.
    > >I'm looking for a way to create surround sound using the four speakers.
    > >There must be a way. Help please!
    > >
    > >  
    > >
    > Oops! sorry for my misstake, I mean hw:0,0 -> front speakers and 
    > hw:0,1-> rear speakers (assuming that you got only one soundcard 
    > installed). In such way it's possible to control each speaker 
    > independently, programs like xine can take advantage of this.
    > 
    > Then, whatever you want to do is just a software issue. It's not 
    > possible to send the same output to front and rear just via a simple 
    > "aplay ...", maybe it's possible to do magic via the .asoundrc stuff 
    > crearting a virtual device, but I dont know how to do that.
    
    the latest alsa-lib cvs tree already includes the definition for
    cs46xx.  you'll be able to play a 4-channel wav file like
    
    	% aplay -Dsurround40 4channels.wav
    
    
    Takashi
    
    



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com

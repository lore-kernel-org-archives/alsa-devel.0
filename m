From: ljp <ljp@llornkcor.com>
Subject: Re: Setting alsamixer settings from API
Date: 18 Feb 2003 15:59:58 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045609200.19289.106.camel@shippin>
References: <00c801c2d79a$3a4dae20$0100a8c0@Pblaptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <00c801c2d79a$3a4dae20$0100a8c0@Pblaptop>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pete Barnard <petebarnard@tiscali.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

mixer API is a bit under documented. 
but you can look at amixer and alsamixer for hints.
There is some mixer docs generated if you have doxygen installed, but
theres no link to it from the rest of the documentation, you have to
look at the docs dir.



On Tue, 2003-02-18 at 15:08, Pete Barnard wrote:
> Hi,
> 
> I have just finished writing a sound capture program using ALSA 0.9.0rc7 and
> Red Hat Linux 7.2.  Whilst there are no problems with the operation of the
> program some users are complaining that whenever they re-boot their machines
> and re-start my sound program, they have to :
> 1. bring up alsamixer
> 2. unmute everything in alsamixer
> 3. set the ADC capture flag on in alsamixer
> 4. adjust various volume settings in alsamixer.
> 5. Bring up the gnome audiomixer gui (the sound comes out in mono until the
> audiomixer is brought up - without even changing any settings -  I don't
> know what's going on there???).
> 
> It all seems a lot of hassle for the average, non-IT trained users and I do
> like to keep them HAPPY.
> 
> Are there API function calls which allow altering alsamixer settings etc
> from within the program code?  Any information on this (or direction to
> useful documentation) would be appreciated.
> 
> Regards,
> 
> Pete
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
My cat's a debugger....

Potter, Lorn, "ljp"
core developer / Web Administrator
Project OPIE- the Open Palmtop Integrated Environment
http://opie.handhelds.org | http://www.opie.info (german) |
http://www.opie.us
IRC: irc.freenode.net #opie #opie.de

llornkcor@handhelds.org
llornkcor@helixcommunity.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

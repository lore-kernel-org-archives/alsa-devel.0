From: Mark Knecht <markknecht@comcast.net>
Subject: Re: Why does Alsa sometimes not find the HDSP 9652?
Date: Mon, 22 Dec 2003 08:28:23 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1072110503.2274.1.camel@Wizard.knechthome.com>
References: <200312221530.hBMFUxZJ015706@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312221530.hBMFUxZJ015706@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Justin Cormack <justin@street-vision.com>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-12-22 at 07:30, Paul Davis wrote:
> >Justin,
> >   I'm running Alsa-1.0.0rc2. How much more up to date could I be?
> >
> >   Also, this is an HDSP 9652 which has the firmware on the board. Why
> >is a firmware loader required at all?
> 
> its not. jaroslav used that phrase because the bug manifested itself
> most clearly when loading firmware. it was a bit more general than
> that however, since it affected interactions with the card in several
> places. 
> 
> --p

Paul,
   Did I miss a response somehow? I haven't received anything on this
from Jaroslav.

   Can you offer any insight into the root cause of this problem? Why
should lspci be able to see the card, but Alsa cannot start the driver?
(going back tot he original post.)

Thanks,
Mark



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: problems with ALSA and SDL
Date: Tue, 27 Jan 2004 23:20:42 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1075242041.366.440.camel@thor.asgaard.local>
References: <20040127190140.29693112.segfault@email.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040127190140.29693112.segfault@email.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Francesco Abbate <segfault@email.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-01-27 at 19:01, Francesco Abbate wrote:
> 
> One of the major problem I've encountered with ALSA is that it *seems*
> to be very CPU intensive.
> In fact I've compiled the SDL library with ALSA and I've discovered that
> my CPU is not fast enough to run the game when the sound is anabled.
> The CPU get a very heavy load and the sound is badly scattered (buffer
> underrun I suppose).

This is an SDL 1.2.6 problem which has been fixed in CVS, see
http://www.libsdl.org/pipermail/sdl/2003-December/058752.html and
http://www.libsdl.org/pipermail/sdl/2004-January/058861.html .


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

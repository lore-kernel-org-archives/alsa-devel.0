From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] make JACK client name unique
Date: Fri, 06 Feb 2004 00:22:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1076023366.8678.18.camel@thor.asgaard.local>
References: <1075929438.12299.163.camel@thor.asgaard.local>
	 <s5hhdy5aglj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhdy5aglj.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-02-05 at 12:52, Takashi Iwai wrote: 
> At Wed, 04 Feb 2004 22:17:19 +0100,
> Michel Dänzer wrote:
> > 
> > This patch changes the JACK plugin to use a unique client name, which
> > allows for multiple ALSA streams to share a JACK server.
> 
> thanks, committed to cvs now (with compile warning fixes - you
> shouldn't compare the int return value with sizeof()).

Whoops, thank you.


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

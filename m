From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: xine with dmix
Date: Wed, 21 Jan 2004 22:45:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074721534.371.15.camel@thor.asgaard.local>
References: <1074607760.9700.453.camel@thor.asgaard.local>
	 <Pine.LNX.4.58.0401201628140.2010@pnote.perex-int.cz>
	 <1074614789.9699.464.camel@thor.asgaard.local>
	 <1074620372.9697.480.camel@thor.asgaard.local>
	 <Pine.LNX.4.58.0401212012430.2010@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0401212012430.2010@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-01-21 at 20:19, Jaroslav Kysela wrote:
> 
> [...] I've tested xine with dmix today and I figured after several hours 
> of looking for totaly another problem, that it was 'snd_pcm_wait()' function 
> which causes trouble in conjunction with the xine ALSA code algorithm.
> 
> The result patch (attached to this mail and available also in CVS) is that
> xine works with dmix even without the slowptr option! 

Indeed, great work! Thanks again, you rock.


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

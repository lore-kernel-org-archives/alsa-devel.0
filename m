From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: xine with dmix
Date: Tue, 20 Jan 2004 18:39:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074620372.9697.480.camel@thor.asgaard.local>
References: <1074607760.9700.453.camel@thor.asgaard.local>
	 <Pine.LNX.4.58.0401201628140.2010@pnote.perex-int.cz>
	 <1074614789.9699.464.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1074614789.9699.464.camel@thor.asgaard.local>
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

On Tue, 2004-01-20 at 17:06, Michel Dänzer wrote:
> On Tue, 2004-01-20 at 16:29, Jaroslav Kysela wrote:
> > On Tue, 20 Jan 2004, Michel Dänzer wrote:
> > 
> > Could you try the attached patch? If you add a line 'slowptr yes' to your 
> > dmix pcm definition, the snd_pcm_delay() function should be more precise.
> 
> It seems to work perfectly, thank you very much!

I have to take that back. :(

I had put the slowptr in the wrong place (in the dmixer slave pcm
block), and xine silently fell back to using /dev/dsp (alsa-oss doesn't
seem to work with it). With the slowptr in the right place, I have now
verified that xine uses ALSA with it enabled, but it doesn't seem to
enhance sound quality much if at all.

Sorry for the false confirmation. Any other ideas?


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: xine with dmix
Date: Tue, 20 Jan 2004 17:06:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074614789.9699.464.camel@thor.asgaard.local>
References: <1074607760.9700.453.camel@thor.asgaard.local>
	 <Pine.LNX.4.58.0401201628140.2010@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0401201628140.2010@pnote.perex-int.cz>
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

On Tue, 2004-01-20 at 16:29, Jaroslav Kysela wrote:
> On Tue, 20 Jan 2004, Michel Dänzer wrote:
> 
> > I'm basically very happy with http://penguinppc.org/~daenzer/asound.conf
> > and alsa-oss, kudos to all ALSA developers who made this possible.
> > 
> > The only problem I'm having is that xine doesn't work well. Do you agree
> > with the analysis in
> > http://sourceforge.net/mailarchive/message.php?msg_id=6793623 ? Can
> > snd_pcm_delay() be changed to behave as expected by xine? If so, I can
> > look into it, but I'd need some pointers.
> 
> Could you try the attached patch? If you add a line 'slowptr yes' to your 
> dmix pcm definition, the snd_pcm_delay() function should be more precise.

It seems to work perfectly, thank you very much!


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: I have found a reason why dmix does not work well
	with xine.
Date: Wed, 04 Feb 2004 01:42:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1075855325.12292.96.camel@thor.asgaard.local>
References: <40203EE8.3060107@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40203EE8.3060107@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-02-04 at 01:38, James Courtier-Dutton wrote:
> See attached file.
> It contains a test program, and a readme.txt with details on how to 
> configure the dmix device in order to carry out the test.
> 
> Basically, the value of snd_pcm_delay() returned when using the dmix 
> device is wrong.

See the recent thread 'xine with dmix' on this very list; Jaroslav
introduced slowptr for this, but the problem here wasn't that but
another bug in snd_pcm_wait() which he also fixed. xine is working well
here now with an alsa-lib CVS snapshot shortly before the 1.0.2 release.


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

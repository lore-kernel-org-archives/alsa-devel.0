From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: "direct" PCM mode default?
Date: Mon, 16 Aug 2004 17:41:59 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1092692519.13981.40.camel@krustophenia.net>
References: <412124F5.1060507@findus.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <412124F5.1060507@findus.dhs.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Petter =?ISO-8859-1?Q?Sundl=F6f?= <petter.sundlof@findus.dhs.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-08-16 at 17:19, Petter Sundlöf wrote:
> Wouldn't it be a good idea to somehow make "direct" PCM mode the default 
> for applications that use it, like Quake and so on?
> 
> Or if this is unsane, can some other workaround be devised?
> 

Yes, of course.  The whole reason we need to do this horrible hackery is
to support old applications that use an obsolete sound API, we basically
have to be bug-for-bug compatible, to support old applications that the
developers cannot or will not update.  The actual fix is to update
Quake3 to use the ALSA sound API.

> A user shouldn't have to make specific workarounds 
> (http://alsa-project.org/~iwai/OSS-Emulation.html) for each application 
> that has a little quirk. Or?

No, of course not.  But anytime you want to run legacy apps on a modern
system, it won't be 100% perfect.

A shocking number of closed source applications *still* use OSS for
their new versions (flashplayer7 for example).  The only fix for this is
a LART.

Lee 



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285

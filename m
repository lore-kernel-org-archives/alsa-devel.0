From: Ted <ted@nowtsfree.freeserve.co.uk>
Subject: Re: alsa-1.0.1 and linux-2.2.25
Date: Wed, 21 Jan 2004 17:19:46 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040121171946.E48B44958@marimba.home.net>
References: <Pine.LNX.4.58.0401211032150.2010@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 21 Jan 2004 10:33:26 +0100."
             <Pine.LNX.4.58.0401211032150.2010@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net, Ted <ted@nowtsfree.freeserve.co.uk>
List-Id: alsa-devel@alsa-project.org

Jaroslav writes:
> On Wed, 21 Jan 2004, Ted wrote:
> [...]
> > I configured alsa-lib with
> > ./configure --prefix=/usr --with-versioned=no --with-debug=yes \
>                             ^^^^^^^^^^^^^^^^^^^
>
> This was the problem. I've fixed the code in CVS and sent you this patch
> in the separate mail.

Ahh, I should have guessed everyone else was using versioning.
The patch fixed it, aplay is working again.
Thankyou.

Ted.
-- 
Ted <ted@nowtsfree.freeserve.co.uk>
   http://www.nowtsfree.freeserve.co.uk


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

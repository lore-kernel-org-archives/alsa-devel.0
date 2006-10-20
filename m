From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Conexant patch
Date: Fri, 20 Oct 2006 11:37:02 -0700
Message-ID: <1161369422.26400.46.camel@razman>
References: <1161368006.15860.341.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1161368006.15860.341.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

It looks incomplete to me.  I think it needs to be submitted in patch
form, because the Makefile, hda_patch.h, and I think there's changes in
the alsa-driver tree as well.  Plus, there's no apm capabilities in the
patch.

Also, do we know this came from a gpl source?  The header is currently
licensed as follows:

        /*
         * Universal Interface for Intel High Definition Audio Codec
         *
         * HD audio interface patch for Conexant HDA audio codec
         *
         * Copyright (c) 2006 Pototskiy Akex <alex.pototskiy@gmail.com>
         *
         *
         * NO LICENSE NO WARRANTY
         *
         */

Is it original code or copied from something linuxant.com was working
on?  It looks fairly generic and benign, but I wouldn't want to be
liable.

It would be nice if someone could get the specs (I've been trying).
Even if it requires some sort of NDA (like Sigmatel).

I'll look at cleaning it up a little and making a patch, but I'm not
putting my name on the original code until we can get an official
submission with ownership.

Tobin
On Fri, 2006-10-20 at 14:13 -0400, Lee Revell wrote:
> Is the patch from
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2485 merged?
> Looks like it makes sound work for many people.
> 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2174 looks like
> the same bug.
> 
> Lee
> 
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

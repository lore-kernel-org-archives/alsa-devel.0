From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: Some proposed ALSA sysfs changes to stock kernel
 from GregKH
Date: Tue, 20 Jan 2004 10:50:30 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401201050030.1857@pnote.perex-int.cz>
References: <400C9CA1.6030706@starhub.net.sg> <yw1xllo3ouek.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <yw1xllo3ouek.fsf@ford.guide>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Jan 2004, M?ns Rullg?rd wrote:

> R Chan <rspchan@starhub.net.sg> writes:
> 
> > Greg KH is proposing some sysfs changes to the stock kernel - any
> > impact on CVS ALSA? Is it ok to rely solely on CVS ALSA - I always
> > build 2.6 from the stock tree and then immediately overwrite the
> > sound directory with ALSA CVS.
> 
> Those patches do not apply cleanly to the latest ALSA version.  There
> are some minor conflicts, all easily resolved.  I'm not sure whether
> anything else depends on the ALSA changes, but I wouldn't think so.
> I've been running ALSA 1.0.1 merged with Greg's patches for some
> time, and it seems to be working well.

We will merge these patches when they're merged to mainstream.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

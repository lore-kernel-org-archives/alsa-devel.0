From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Some proposed ALSA sysfs changes to stock kernel from GregKH
Date: Tue, 20 Jan 2004 10:12:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xllo3ouek.fsf@ford.guide>
References: <400C9CA1.6030706@starhub.net.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

R Chan <rspchan@starhub.net.sg> writes:

> Greg KH is proposing some sysfs changes to the stock kernel - any
> impact on CVS ALSA? Is it ok to rely solely on CVS ALSA - I always
> build 2.6 from the stock tree and then immediately overwrite the
> sound directory with ALSA CVS.

Those patches do not apply cleanly to the latest ALSA version.  There
are some minor conflicts, all easily resolved.  I'm not sure whether
anything else depends on the ALSA changes, but I wouldn't think so.
I've been running ALSA 1.0.1 merged with Greg's patches for some
time, and it seems to be working well.

-- 
Måns Rullgård
mru@kth.se



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

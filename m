From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Docu:: Alsa Audio API:: A minimal capture program
Date: Wed, 28 Jan 2004 16:18:37 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401281614420.11576-100000@studcom.urz.uni-halle.de>
References: <200401272240.03344.tmohr@s.netic.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200401272240.03344.tmohr@s.netic.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Torsten Mohr <tmohr@s.netic.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Torsten Mohr wrote:
> I want to write a program where some chunk of
> data is sampled from time to time, with some delay
> inbetween.

Your program wants to ignore any buffer overruns.  To do this, you
have to change the sw_params: set the stop_threshold to either 0 or
the buffer size in frames (I don't remember which).


HTH
Clemens




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

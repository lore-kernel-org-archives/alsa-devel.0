From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: SB Live! 24-Bit External: remote control support
Date: Fri, 28 Apr 2006 10:42:00 +0200
Message-ID: <20060428084200.GA26640@turing.informatik.uni-halle.de>
References: <44512925.30803@vardes.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <44512925.30803@vardes.lv>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raimonds Cicans <ray@vardes.lv>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Raimonds Cicans wrote:
> Attached patch contains support for 'SB Live! 24-Bit External' remote

It seems the codes are not compatible with the Extigy/Audigy2NX.
Are the lower 8 bits unique, or does the LIRC driver need to be updated
to read 32 bit codes?

Please provide a Signed-off-by line.


Regards,
Clemens


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

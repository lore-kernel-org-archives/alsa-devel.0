From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: C-Media MD 85217
Date: Thu, 18 May 2006 11:12:58 +0200
Message-ID: <20060518091258.GA26583@turing.informatik.uni-halle.de>
References: <20060518094959.53a5b85f@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20060518094959.53a5b85f@localhost>
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
To: Thorsten Mika <info@thorstenmika.com>
Cc: ALSA Development List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Thorsten Mika wrote:
> I just purchased a set of flat speakers in a german discount shop,
> manufactured by Medion an bearing the description MD 85217.
> 
> alsamixer recognizes the interface and shows up one volume control
> labelled "PCM", but unfortunately it does not have much effect, except
> that it turns off the speaker when switched to zero. So it only allows
> maximum output and mute.

Whatever effect the setting of a mixer control has on the sound output
depends on what the device's firmware does with it.  After sending the
control value to the device, the driver cannot do anything about it.


Regards,
Clemens


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

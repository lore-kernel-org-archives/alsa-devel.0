From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: A bug in intel8x0.c
Date: Fri, 16 Jan 2004 13:13:44 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401161308300.25394-100000@studcom.urz.uni-halle.de>
References: <40075B22.6060208@sun.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <40075B22.6060208@sun.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "freeman.liu" <freeman.liu@sun.com>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

freeman.liu wrote:
> At the end of the function snd_intel8x0_codec_semaphore. If we
> couldn't get the semaphore in 1 ms, we'll reset the register and
> return EBUSY. But to reset the register, we should do a
> iaputword ( chip, 0, 0 ), according to the datasheet, write any
> value the this register will reset the register.
> But in the code, what we did is iagetword ( chip, 0 ).

At that point, we don't want to reset the semaphore but to access a
dummy AC'97 register so that the semaphore flag is cleared even if we
actually got the semaphore (from the igetbyte in the printk).  (The
iagetword/iaputword functions access AC'97 registers, not ICH
registers.)


HTH
Clemens




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

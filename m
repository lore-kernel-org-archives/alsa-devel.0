From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: PCM format 20 bit
Date: Mon, 23 Oct 2006 09:24:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0610230909050.29404@denise.shiny.it>
References: <B9FFC3F97441D04093A504CEA31B7C41EC837A@msilexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <B9FFC3F97441D04093A504CEA31B7C41EC837A@msilexch01.marvell.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Assaf Hoffman <hoffman@marvell.com>
Cc: alsa-devel@lists.sourceforge.net, Rita Shtern <rita@marvell.com>
List-Id: alsa-devel@alsa-project.org



On Mon, 23 Oct 2006, Assaf Hoffman wrote:

> Thank you, for your answer.
> I do not understand how does it work? Obviously, the ALSA stack does not
> have such format, and by trying to extract the buffer (capture example)
> the stack will assume 32-bit sample width, getting trash on the lower 12
> bits.
> Please explain.

If the format is a 32 bits value, it is not important what the actual 
resolution is from the software POV. It's a value that ranges from -2G 
to +2G regardless the fact the x lowest bits are always 0. This is in case 
the data is left-aligned.
Instead, if the data is right-aligned, ALSA must have specific support for 
it because the values range from -512K to +512K (I assume it's signed), so 
either it has to communicate the actual format to apps, or it must be able 
to convert the data to other formats.
What is exactly the data format ?


--
Giuliano.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

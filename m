From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: plughw versus hw (fwd)
Date: Thu, 31 Jul 2003 11:02:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xptjr3w73.fsf@users.sourceforge.net>
References: <Pine.LNX.4.53.0307302230580.14824@spring>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

barat@medien.uni-weimar.de writes:

> i read that plughw does some magic conversion for samplerate and stuff. 
> how does this magic work. whats the main differenc in the concept of hw 
> and plughw. 

hw interfaces directly to the physical card.  Thus you can only use
modes supported by the hardware.  plughw will detect whether the
hardware can do what you are requesting, and automatically convert the
data to something that can be played, at the expense of CPU time.

-- 
Måns Rullgård
mru@users.sf.net



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

From: Jody McIntyre <alsa@modernduck.com>
Subject: Re: IEEE 1394 devices and ALSA
Date: Mon, 24 Jan 2005 11:08:41 -0500
Message-ID: <20050124160841.GE18792@conscoop.ottawa.on.ca>
References: <20050124031234.9420312E3B@sc8-sf-spam2.sourceforge.net> <20050124084209.65949.qmail@web60809.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050124084209.65949.qmail@web60809.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tsw@johana.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 24, 2005 at 12:42:09AM -0800, Tom Watson wrote:
> Yesterday I saw a Metric Halo Mobile I/O 2882 connected to a Mac (Laptop, but
> that's irrelevant).  It has a firewire (IEEE-1394) interface.  Has anyone
> thought about getting this magic box working on Linux?  It looks like a nice
> box to "have around the house".  It has 8 analog in/8 analog out along with a
> bunch of digital I/O's.  It has a full matrix to interconnect things.

If it's based on the dm1000 chip and runs BeBob internally, it will work
with the FreeBob driver that is under development:
http://freebob.sourceforge.net/ 

Unfortunately, I don't think it is.  If you can convince the
manufacturer to provide full documentation on their protocols, someone
may eventually write a driver.  If you can also convince them to provide
sample hardware, I will definately write a driver :)

Jody

> 
> Further thoughts??
> 
> =====
> -- 
> Tom Watson
> tsw@johana.com
> 
> 
> 		
> __________________________________ 
> Do you Yahoo!? 
> All your favorites on one personal page ? Try My Yahoo!
> http://my.yahoo.com 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl

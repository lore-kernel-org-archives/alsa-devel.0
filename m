From: Jody McIntyre <lad@modernduck.com>
Subject: Re: Capturing audio and 1010lt
Date: Wed, 26 Jan 2005 18:31:54 -0500
Message-ID: <20050126233154.GJ18792@conscoop.ottawa.on.ca>
References: <OFDAEF9790.06BB015E-ONC1256F95.003851E8@MarconiSelenia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <OFDAEF9790.06BB015E-ONC1256F95.003851E8@MarconiSelenia.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alberto.Pareto@seleniacomms.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 26, 2005 at 11:33:39AM +0100, Alberto.Pareto@seleniacomms.com wrote:

> What I'm supposed to do to get 8 different captures? Maybe this can be done
> only through the API and not with the standard tool installed with ALSA
> (like arecord and aplay)?
> Is this a limitation of the board?

I've used ardour ( http://ardour.org/ ) to capture multiple streams from
a Delta 1010 (not LT but the software's the same).  Once I got Ardour
going and figured out how to use it, the capture Just Worked.  The thing
is, there only is one capture device.  It just has 8 channels.  If you want
to split them apart and send them to separate programs, use Jack
( http://jackit.sourceforge.net/ ).  Of course, you'll then need to use
Jack-enabled recording software instead of arecord.

Jody

> 
> Thanks for advices!!!
> Alberto
> 
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

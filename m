From: "Jan \"Evil Twin\" Depner" <eviltwin69@cableone.net>
Subject: Re: Clock Rate on ICE1712
Date: 11 Jan 2003 15:50:35 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1042321836.24955.1.camel@eviltwin>
References: <Pine.LNX.4.44.0301112209120.12635-100000@eris.discordia.loc>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from scanmail3.cableone.net (scanmail3.cableone.net [24.116.0.123])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA19948
	for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2003 22:52:18 +0100
In-Reply-To: <Pine.LNX.4.44.0301112209120.12635-100000@eris.discordia.loc>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lorenzo Marcantonio <lomarcan@tin.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lorenzo,

	Jaroslav has fixed this.  I had the same problem an talked to him off
list.  You need to download the latest ALSA (all packages) from CVS.  It
is fixed in there.

Jan

On Sat, 2003-01-11 at 15:20, Lorenzo Marcantonio wrote:
> 
> I'm using alsa-0.9.0rc6 with a 2.4.18 kernel (low-latency patch applied).
> Sound card is a Terratec EWX 24/96. My problem is the following:
> at startup the master clock rate is at 48KHz. If I try to change it to
> 44.1KHz with alsamixer, amixer or envy24control it stays fixed at 48.
> HOWEVER if I set to external sync THEN to 44.1 all works properly (to get
> back to 48 I need to switch to ext-sync then to 48...)
> 
> IIRC my previous version (0.9.0beta9) worked differently... it's a bug or
> something changed and I'm missing something?
> 
> Also what the 'rate lock' and 'rate reset' controls are used for?
> 
> Thanks in advance
> 
> 				-- Lorenzo Marcantonio
> 
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com

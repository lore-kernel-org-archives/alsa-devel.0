From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp multiface pci.
Date: 19 Jan 2003 18:27:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1042997250.21518.25.camel@satellite.undata.org>
References: <3E2A952E.6060305@boosthardware.com>
	 <1042985569.1663.33.camel@satellite.undata.org>
	 <3E2AC45F.3070601@boosthardware.com>
	 <1042992464.1649.55.camel@satellite.undata.org>
	 <1042964591.10196.4.camel@Godzilla>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1042964591.10196.4.camel@Godzilla>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Patrick Shirkey <pshirkey@boosthardware.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-01-19 at 09:23, Mark Knecht wrote:
> Thomas,
>    I have possibly more than a passing interest in this subject as I use
> the HDSP 9652 card that Patrick mentioned and find this whole amixer
> language completely unfathomable.
> 
>    In your quote above, could you outline what each parameter stands
> for?
> 
> "numid=5 26,26,16384"
> 
> numid=5 - Is this a physical connection? A mixer input or output? An
> abstract number just used to keep track of things?
> 
numid=5 is a way to identify the control we want to work with, i.e. the
matrix mixer.
Controls are defined on a per soundcard basis to address specific driver
needs uncovered by the "simple controls" you can access through
alsamixer.

> 26,26 - clearly Patrick and I were thinking that these two numbers
> related to specific hardware inputs and outputs, but apparently not.
> 
Yes they are. To understand them you should refer to the table Patrick
gave (quoting the HDSP alsa page, link follows). 

> 16384 - a mixer volume?
> 
Yes, you should read Marcus Andersson's comments on this here:
http://www.alsa-project.org/alsa-doc/doc-php/template.php3?company=RME&card=Hammerfall+DSP&chip=FPGA&module=hdsp
(at the end of the page)

Thomas




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en

From: Ken Smith <kens@kensnet.org>
Subject: ICE1712 SPDIF Output format
Date: Fri, 15 Sep 2006 22:38:14 +0100
Message-ID: <450B1D46.3010906@kensnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, Is there a problem with the SPDIF output format with the ice1712 
driver? I'm using FC5, CCRMA, Ardour etc...

I have a M-Audio Delta1010 whose SPDIF output is routed to a Yamaha 
Surround AMP, in turn the Yamaha's SPDIF output is also routed to a 
M-Audio DAC. I get sound output from the M-Audio DAC (via the Yamaha) 
but no output from the Yamaha itself. I have noticed that using the 
M-Audio Windows driver the Yamaha only produces output when I select 
"consumer" format output and it mutes when I select "Pro" format in the 
Windows M-Audio 1010 control panel. Trying these settings in 
envy24control does not influence the output.

Is this an ice1712 driver  or a envy24control problem or something else?

Any suggestions?

Thanks

Ken



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

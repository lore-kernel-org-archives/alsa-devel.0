From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp rpm
Date: Sun, 03 Sep 2006 10:14:22 -0400
Message-ID: <1157292863.28228.32.camel@localhost.localdomain>
References: <44F51F73.1070807@chello.at>
Reply-To: paul@linuxaudiosystems.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <44F51F73.1070807@chello.at>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Karl Grill <kgrill@chello.at>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-08-30 at 07:17 +0200, Karl Grill wrote:
> Hi all,
> I got a rme hammerfall dsp rpm from ebay (not yet, actually) under the 
> wrong(?) assumption that  all of rme's  cards work under linux. looking 
> a little bit closer, i found that the rpm is not listed as a supported 
> card (well, the list on alsa-project org says it hasn't been updated in 
> more than a year), and, apparently, the only places where it is 
> mentioned are a few support requests and a Jan 2005 answer from thomas 
> charbonnel on alsa-user where he states that he might come up with 
> something within a week - but I didn't see the results.
> Has anything happened about this? If not, what can I do to make this 
> work? I'm ready to dive into a disaasembly of the windows driver (not my 
> first time) but any pointers as to where to look would be greatly 
> appreciated.

disassembling the windows driver would be an absolutely insane approach.

RME's HDSP line is a relatively "modular" product series, based around
the Xilinix FPGA chip. RME have gotten quite good at re-programming the
chip to make it do new things. none of the HDSP product series is
radically different from the others, and the driver can be tweaked to
support the new variants. However, for this to happen, RME needs to be
reminded that (a) Linux continues to exist and RME users on Linux
continue to grow, (b) to support the new HDSP products we need
information. RME have never pro-actively sent myself or Thomas or
(AFAIK) the ALSA project information on new products - we have to wait
for someone to complain loudly enough, then I write to RME, they send me
stuff. If I have time, I fix it, if I don't have time, it stays broken.

I have not had time for a long time, and that's not likely to change
anytime soon. Thomas has essentially vanished into the berlin meatspace;
Takashi has done "maintainance" on the HDSP driver but no further
developement. So I do not know what to advise you to do.

--p



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

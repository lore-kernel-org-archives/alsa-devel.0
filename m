From: "Vishwas P S" <vishwas.ps@gmail.com>
Subject: Re: Recording problem
Date: Fri, 15 Sep 2006 20:38:46 +0530
Message-ID: <64cf23610609150808s10735a2chaa87442b74c35c7a@mail.gmail.com>
References: <64cf23610609150319n190d4005sf78af65dc7159e5f@mail.gmail.com>
	<1158318061.22950.43.camel@localhost.localdomain>
	<64cf23610609150416k477d2d2cl4a080cddd22cfb7a@mail.gmail.com>
	<1158327548.22950.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1887425532=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1158327548.22950.86.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============1887425532==
Content-Type: multipart/alternative;
	boundary="----=_Part_5051_29342587.1158332926248"

------=_Part_5051_29342587.1158332926248
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Liam,

Thanks for those inputs.
I'll give it a try and let you know what happens.

Thanks again
Vishwas


On 9/15/06, Liam Girdwood <liam.girdwood@wolfsonmicro.com> wrote:
>
> On Fri, 2006-09-15 at 16:46 +0530, Vishwas P S wrote:
> > Hi Liam,
> >
> > Thanks for the quick response.
> > I've checked that audio path and there are no programmable amps. The
> > audio chip has only one set of register bits for gain control and I've
> > kept it at a minimum. (Also the gain knob in the Mic at a minimum)
> > But still the problems exist
> > (For the same config and same hardware OSS produces very feeble sound)
> >
> > Is there any configuration that I need to edit in asla.conf or
> > asoundrc
> > Is there any place in software where the recorded stream could be
> > getting boosted or mixed??
>
> A software gain can be ruled out by recording from the hardware directly
> i.e.
>
> arecord -f cd -Dhw:0,0 > file.wav
>
> This will record directly from the hardware without any pcm plugins. If
> the clipping is still audible, then I would compare a hardware register
> dump between your OSS and ALSA drivers.
>
> Another possibility is that your digital audio interface (DAI) is
> incorrectly configured between your codec and controller. This could
> cause the audio MSB to be shifted wrt the controller by 1 bit to the
> left. This would cause high gain and a lot of clipping.
>
> Liam
>
>
>
>

------=_Part_5051_29342587.1158332926248
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Liam,</div>
<div>&nbsp;</div>
<div>Thanks for those inputs.</div>
<div>I'll give it a try and let you know what happens.</div>
<div>&nbsp;</div>
<div>Thanks again</div>
<div>Vishwas<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 9/15/06, <b class="gmail_sendername">Liam Girdwood</b> &lt;<a href="mailto:liam.girdwood@wolfsonmicro.com">liam.girdwood@wolfsonmicro.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Fri, 2006-09-15 at 16:46 +0530, Vishwas P S wrote:<br>&gt; Hi Liam,<br>&gt;<br>&gt; Thanks for the quick response.
<br>&gt; I've checked that audio path and there are no programmable amps. The<br>&gt; audio chip has only one set of register bits for gain control and I've<br>&gt; kept it at a minimum. (Also the gain knob in the Mic at a minimum)
<br>&gt; But still the problems exist<br>&gt; (For the same config and same hardware OSS produces very feeble sound)<br>&gt;<br>&gt; Is there any configuration that I need to edit in asla.conf or<br>&gt; asoundrc<br>&gt; Is there any place in software where the recorded stream could be
<br>&gt; getting boosted or mixed??<br><br>A software gain can be ruled out by recording from the hardware directly<br>i.e.<br><br>arecord -f cd -Dhw:0,0 &gt; file.wav<br><br>This will record directly from the hardware without any pcm plugins. If
<br>the clipping is still audible, then I would compare a hardware register<br>dump between your OSS and ALSA drivers.<br><br>Another possibility is that your digital audio interface (DAI) is<br>incorrectly configured between your codec and controller. This could
<br>cause the audio MSB to be shifted wrt the controller by 1 bit to the<br>left. This would cause high gain and a lot of clipping.<br><br>Liam<br><br><br><br></blockquote></div><br>

------=_Part_5051_29342587.1158332926248--


--===============1887425532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1887425532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1887425532==--

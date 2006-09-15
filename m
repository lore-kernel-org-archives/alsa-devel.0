From: "Vishwas P S" <vishwas.ps@gmail.com>
Subject: Re: Recording problem
Date: Fri, 15 Sep 2006 16:46:12 +0530
Message-ID: <64cf23610609150416k477d2d2cl4a080cddd22cfb7a@mail.gmail.com>
References: <64cf23610609150319n190d4005sf78af65dc7159e5f@mail.gmail.com>
	<1158318061.22950.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0468001872=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1158318061.22950.43.camel@localhost.localdomain>
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

--===============0468001872==
Content-Type: multipart/alternative;
	boundary="----=_Part_1209_19965749.1158318972594"

------=_Part_1209_19965749.1158318972594
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Liam,

Thanks for the quick response.
I've checked that audio path and there are no programmable amps. The audio
chip has only one set of register bits for gain control and I've kept it at
a minimum. (Also the gain knob in the Mic at a minimum)
But still the problems exist
(For the same config and same hardware OSS produces very feeble sound)

Is there any configuration that I need to edit in asla.conf or asoundrc
Is there any place in software where the recorded stream could be getting
boosted or mixed??

Regards
Vishwas


On 9/15/06, Liam Girdwood <liam.girdwood@wolfsonmicro.com> wrote:
>
> On Fri, 2006-09-15 at 15:50 +0530, Vishwas P S wrote:
> > Hi group,
> >
> > I have a noise problem whenever I record sound with arecord.
> > The sound seems to be very loud and it often gets clipped .. looks
> > like the signal gets overloaded and gets clipped often.\
> > I've ensured that the Mic gain is kept at a minimum and still it
> > happens.
> > (For the same config OSS gives a very low volume)
> >
> > What could be the problem. Pl help out
>
> Your correct in that your input signal is being clipped because the gain
> is too high.
>
> It's worth checking the audio path between your mic and ADC to make sure
> that there an no other amplifiers increasing the input gain. Please note
> that some ADC's can also increase gain.
>
> It's also possible that your hardware has ALC/AGC (Automatic Level|Gain
> control). This automatically changes the gain depending on the volume of
> the input signal so that the volume captured is constant. This will also
> cause clipping if the settings are too high.
>
> Liam
>
>
>
>

------=_Part_1209_19965749.1158318972594
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Liam,</div>
<div>&nbsp;</div>
<div>Thanks for the quick response.</div>
<div>I've checked that audio path and there are no programmable amps. The audio chip has only one set of register bits for gain control and I've kept it at a minimum. (Also the gain knob in the Mic at a minimum)</div>
<div>But still the problems exist</div>
<div>(For the same config and same hardware OSS produces very feeble sound)</div>
<div>&nbsp;</div>
<div>Is there any configuration that I need to edit in asla.conf or asoundrc</div>
<div>Is there any place in software where the recorded stream could be getting boosted or mixed??</div>
<div>&nbsp;</div>
<div>Regards</div>
<div>Vishwas<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 9/15/06, <b class="gmail_sendername">Liam Girdwood</b> &lt;<a href="mailto:liam.girdwood@wolfsonmicro.com">liam.girdwood@wolfsonmicro.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Fri, 2006-09-15 at 15:50 +0530, Vishwas P S wrote:<br>&gt; Hi group,<br>&gt;<br>&gt; I have a noise problem whenever I record sound with arecord.
<br>&gt; The sound seems to be very loud and it often gets clipped .. looks<br>&gt; like the signal gets overloaded and gets clipped often.\<br>&gt; I've ensured that the Mic gain is kept at a minimum and still it<br>&gt; happens.
<br>&gt; (For the same config OSS gives a very low volume)<br>&gt;<br>&gt; What could be the problem. Pl help out<br><br>Your correct in that your input signal is being clipped because the gain<br>is too high.<br><br>It's worth checking the audio path between your mic and ADC to make sure
<br>that there an no other amplifiers increasing the input gain. Please note<br>that some ADC's can also increase gain.<br><br>It's also possible that your hardware has ALC/AGC (Automatic Level|Gain<br>control). This automatically changes the gain depending on the volume of
<br>the input signal so that the volume captured is constant. This will also<br>cause clipping if the settings are too high.<br><br>Liam<br><br><br><br></blockquote></div><br>

------=_Part_1209_19965749.1158318972594--


--===============0468001872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0468001872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0468001872==--

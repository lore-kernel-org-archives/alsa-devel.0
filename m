From: "Ronald Stewart" <ronaldjstewart@gmail.com>
Subject: Re: Hi ALSA Team - serious technical question from Ron
Date: Mon, 12 Jun 2006 09:23:08 -0700
Message-ID: <4c84399f0606120923t18e90c09w718643cc49670f9a@mail.gmail.com>
References: <4c84399f0606042324o10e15f92t3320621c2f9064f9@mail.gmail.com>
	<4489CAAD.4010900@boosthardware.com>
	<1150109573.21190.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1874645609=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1150109573.21190.13.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>, liam.girdwood@wolfsonmicro.com, Patrick Shirkey <pshirkey@boosthardware.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============1874645609==
Content-Type: multipart/alternative;
	boundary="----=_Part_7953_18023388.1150129388865"

------=_Part_7953_18023388.1150129388865
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 6/12/06, Liam Girdwood <liam.girdwood@wolfsonmicro.com> wrote:Oh yeah
this is AWESOME!!!
this is beautiful but lee mentioned it was available in the sources section,
how do I find alsa-kernel/arm/pxa2xx* and other sources?
I am so happy right nwo I cant standmyself!!!
thank you
ron
any links you can send me would be great!




On Sat, 2006-06-10 at 02:23 +0700, Patrick Shirkey wrote:
> >
> > Ronald Stewart wrote:
>
> > > Hey guys,
> > >
> > > Can someone point me to the correct email address to ask this
> question?
> > >
> > > I built a portable linux based multitrack studio/field recorder but we
> > > have yet
> > > to get 24 bit audio sampling achieved on our prototypes.  Now we use a
> Soc
> > > utilizing the Intel PXA270 and we have disabled the ac97 codec on
> board and
> > > we are connecting the PXA to an AKM 4620A codec.  However, I was
> wondering
> > > how much development has occured for this if at all.
> > > Anyway I have many questions.  I decided over a year ago when I began
> that
> > > we would always be a Linux based product, for all the right reasons
> and now
> > > I could really use some help finishing this for producing the retail
> > > versions.
> > >
>
> You may be interested in an embedded ALSA project I'm working on:-
>
> http://www.rpsys.net/openzaurus/patches/alsa/info.html
>
> We currently have support for the SSP, I2S and AC97 interfaces on the
> PXA2xx SoC. You will need to use the SSP interface for 24bit audio, as
> the AC97 and I2S interfaces only support 16bit samples on the PXA27x.
>
> We don't have your codec (AKM4620A) supported atm, but it's quite
> trivial to add new codecs (there are lots of examples). With a few other
> minor changes to the ssp driver (adding 24 bit support) you should be
> able to start playing/capturing some audio.
>
> Liam
>
>

------=_Part_7953_18023388.1150129388865
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 6/12/06, <b class="gmail_sendername">Liam Girdwood</b> &lt;<a href="mailto:liam.girdwood@wolfsonmicro.com">liam.girdwood@wolfsonmicro.com</a>&gt; wrote:</span><div>Oh yeah this is AWESOME!!!
<br>this is beautiful but lee mentioned it was available in the sources section,<br>how do I find  alsa-kernel/arm/pxa2xx* and other sources?<br>I am so happy right nwo I cant standmyself!!!<br>thank you<br>ron<br>any links you can send me would be great!
<br><br><br>&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On Sat, 2006-06-10 at 02:23 +0700, Patrick Shirkey wrote:<br>&gt;<br>
&gt; Ronald Stewart wrote:<br><br>&gt; &gt; Hey guys,<br>&gt; &gt;<br>&gt; &gt; Can someone point me to the correct email address to ask this question?<br>&gt; &gt;<br>&gt; &gt; I built a portable linux based multitrack studio/field recorder but we
<br>&gt; &gt; have yet<br>&gt; &gt; to get 24 bit audio sampling achieved on our prototypes.&nbsp;&nbsp;Now we use a Soc<br>&gt; &gt; utilizing the Intel PXA270 and we have disabled the ac97 codec on board and<br>&gt; &gt; we are connecting the PXA to an AKM 4620A codec.&nbsp;&nbsp;However, I was wondering
<br>&gt; &gt; how much development has occured for this if at all.<br>&gt; &gt; Anyway I have many questions.&nbsp;&nbsp;I decided over a year ago when I began that<br>&gt; &gt; we would always be a Linux based product, for all the right reasons and now
<br>&gt; &gt; I could really use some help finishing this for producing the retail<br>&gt; &gt; versions.<br>&gt; &gt;<br><br>You may be interested in an embedded ALSA project I'm working on:-<br><br><a href="http://www.rpsys.net/openzaurus/patches/alsa/info.html">
http://www.rpsys.net/openzaurus/patches/alsa/info.html</a><br><br>We currently have support for the SSP, I2S and AC97 interfaces on the<br>PXA2xx SoC. You will need to use the SSP interface for 24bit audio, as<br>the AC97 and I2S interfaces only support 16bit samples on the PXA27x.
<br><br>We don't have your codec (AKM4620A) supported atm, but it's quite<br>trivial to add new codecs (there are lots of examples). With a few other<br>minor changes to the ssp driver (adding 24 bit support) you should be
<br>able to start playing/capturing some audio.<br><br>Liam<br><br></blockquote></div><br>

------=_Part_7953_18023388.1150129388865--


--===============1874645609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1874645609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1874645609==--

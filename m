From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: How to proper handle surround sound setups
Date: Tue, 20 Feb 2007 07:08:24 -0800
Message-ID: <1171984104.6106.41.camel@razman.gruemaster.com>
References: <1171975258.10279.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1562155517=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1171975258.10279.48.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Christian F.K. Schaller" <christian@fluendo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1562155517==
Content-Type: multipart/alternative; boundary="=-gdV3mGfixO7Rjyyyt9Ht"


--=-gdV3mGfixO7Rjyyyt9Ht
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Based on the Intel HD Audio solutions I've seen in newer laptops, the
only way to do this is to query separately for digital output, as most
laptops will have the full surround capability through the spdif ports.
The codecs they are using range from the simple two channel sound chip
to the 8 channel (7.1 Surround) codecs.  We try to disable the unused
ports, but that doesn't always work due to the system hardware
configurations.

Some of the systems do have a channel mode defined in the driver, maybe
there is a way to query this from an external application, the same way
that alsamixer does.

Just my thoughts.

Tobin

On Tue, 2007-02-20 at 13:40 +0100, Christian F.K. Schaller wrote:

> Hi Alsa devs,
> We have a long discussion today in the GStreamer community about how to
> correctly handle surround sound setups.
> 
> The ideal solution we are looking for is a situation where the user do
> not need to configure anything, things just work in an optimal fashion
> depending on their hardware. We are not sure however what exactly is the
> status of a lot of things both in theory and in practice. So I am
> sending out this email to you.
> 
> GStreamer currently queries the alsadevice for its capabilities and
> tries to negotiate an optimal path through its playback pipeline with a
> little quality loss as possible.
> 
> This means that if the soundcard reports supporting surround sound and
> you are playing a multichannel file then GStreamer will output surround
> sound by default in most cases.
> 
> The discussion started as it seems my ICH4 laptop mistakenly reporting
> supporting surround sound on the PCM device, while its only supports
> surround sound indirectly through its s/pdif output(is this a known
> bug?). This caused me to get only the side speaker output in my
> headphones which meant almost all dialog in the movie clips where gone.
> 
> I thus started arguing that we should default to stereo due to this and
> only do surround sound if the users selects it on the application level
> as even if the user truly has a surround capable system they don't
> necessarily have more than two stereo speakers connected.
> 
> The debate then turned to whether connected speakers connected can be
> autodetected or not. Some people reported that their Mac's and Vista
> systems did detect at least some speaker detection, but I was not able
> to clarify if the systems could actually tell you that you have for
> instance LF, center and LR + a woofer connected and so on.
> 
> So my questions to you are:
> a) do most modern soundcards actually report what is connected to them
> so the computer could use that information to automatically choose the
> correct sound output?
> b) if so what is the state of supporting that functionality in ALSA? Is
> it widely implemented or in the process of being so an can it be queried
> using the libalsa API?
> 
> The second issue might be caused by our limited understanding of ALSA. 
> So in the expected case of not being able to detect number of speakers
> connected we need to default to stereo as that is the only way to give
> all users something sane out of the box. The question is how we should
> do this within GStreamer. Currently we are querying ALSA and negotiating
> based on the optimal capabilities of the card and the sound stream.
> 
> We now have two ways to resolve the issue. One is to keep the current
> approach and set 'stereo' as the preferred channels layout through
> something we call a capsfilter. This approach has some drawbacks as it
> requires a lot of logic in the application when overriding the default
> of stereo or you risk your surround config being interpreted as a wish
> for upmixing of mono/stereo streams to surround.
> 
> The other alternative we are looking at which might simplify things for
> us is to use the virtual devices which expose the different surround
> scenarios like using for instance:
> 
> defaults.pcm.surround51.device for surround51 output.
> 
> In this scenario we use the stereo device by default which would then
> only report back support for stereo and thus negotiate correctly to
> stereo with all elements. Users can then through the applications choose
> the 5.1 audio device at which point we would change to the 5.1 device
> like the one above. Our worry the by the playback autoplugger which as
> you know is rarely the casere though is what happens with stereo output
> as we of course do not want that upmixed. Do these 5.1 virtual devices
> also handle stereo correctly? What would be the expected result when
> querying these devices through the libalsa API
> 
> Christian
> 
> 
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-gdV3mGfixO7Rjyyyt9Ht
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
Based on the Intel HD Audio solutions I've seen in newer laptops, the only way to do this is to query separately for digital output, as most laptops will have the full surround capability through the spdif ports.&nbsp; The codecs they are using range from the simple two channel sound chip to the 8 channel (7.1 Surround) codecs.&nbsp; We try to disable the unused ports, but that doesn't always work due to the system hardware configurations.<BR>
<BR>
Some of the systems do have a channel mode defined in the driver, maybe there is a way to query this from an external application, the same way that alsamixer does.<BR>
<BR>
Just my thoughts.<BR>
<BR>
Tobin<BR>
<BR>
On Tue, 2007-02-20 at 13:40 +0100, Christian F.K. Schaller wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hi Alsa devs,</FONT>
<FONT COLOR="#000000">We have a long discussion today in the GStreamer community about how to</FONT>
<FONT COLOR="#000000">correctly handle surround sound setups.</FONT>

<FONT COLOR="#000000">The ideal solution we are looking for is a situation where the user do</FONT>
<FONT COLOR="#000000">not need to configure anything, things just work in an optimal fashion</FONT>
<FONT COLOR="#000000">depending on their hardware. We are not sure however what exactly is the</FONT>
<FONT COLOR="#000000">status of a lot of things both in theory and in practice. So I am</FONT>
<FONT COLOR="#000000">sending out this email to you.</FONT>

<FONT COLOR="#000000">GStreamer currently queries the alsadevice for its capabilities and</FONT>
<FONT COLOR="#000000">tries to negotiate an optimal path through its playback pipeline with a</FONT>
<FONT COLOR="#000000">little quality loss as possible.</FONT>

<FONT COLOR="#000000">This means that if the soundcard reports supporting surround sound and</FONT>
<FONT COLOR="#000000">you are playing a multichannel file then GStreamer will output surround</FONT>
<FONT COLOR="#000000">sound by default in most cases.</FONT>

<FONT COLOR="#000000">The discussion started as it seems my ICH4 laptop mistakenly reporting</FONT>
<FONT COLOR="#000000">supporting surround sound on the PCM device, while its only supports</FONT>
<FONT COLOR="#000000">surround sound indirectly through its s/pdif output(is this a known</FONT>
<FONT COLOR="#000000">bug?). This caused me to get only the side speaker output in my</FONT>
<FONT COLOR="#000000">headphones which meant almost all dialog in the movie clips where gone.</FONT>

<FONT COLOR="#000000">I thus started arguing that we should default to stereo due to this and</FONT>
<FONT COLOR="#000000">only do surround sound if the users selects it on the application level</FONT>
<FONT COLOR="#000000">as even if the user truly has a surround capable system they don't</FONT>
<FONT COLOR="#000000">necessarily have more than two stereo speakers connected.</FONT>

<FONT COLOR="#000000">The debate then turned to whether connected speakers connected can be</FONT>
<FONT COLOR="#000000">autodetected or not. Some people reported that their Mac's and Vista</FONT>
<FONT COLOR="#000000">systems did detect at least some speaker detection, but I was not able</FONT>
<FONT COLOR="#000000">to clarify if the systems could actually tell you that you have for</FONT>
<FONT COLOR="#000000">instance LF, center and LR + a woofer connected and so on.</FONT>

<FONT COLOR="#000000">So my questions to you are:</FONT>
<FONT COLOR="#000000">a) do most modern soundcards actually report what is connected to them</FONT>
<FONT COLOR="#000000">so the computer could use that information to automatically choose the</FONT>
<FONT COLOR="#000000">correct sound output?</FONT>
<FONT COLOR="#000000">b) if so what is the state of supporting that functionality in ALSA? Is</FONT>
<FONT COLOR="#000000">it widely implemented or in the process of being so an can it be queried</FONT>
<FONT COLOR="#000000">using the libalsa API?</FONT>

<FONT COLOR="#000000">The second issue might be caused by our limited understanding of ALSA. </FONT>
<FONT COLOR="#000000">So in the expected case of not being able to detect number of speakers</FONT>
<FONT COLOR="#000000">connected we need to default to stereo as that is the only way to give</FONT>
<FONT COLOR="#000000">all users something sane out of the box. The question is how we should</FONT>
<FONT COLOR="#000000">do this within GStreamer. Currently we are querying ALSA and negotiating</FONT>
<FONT COLOR="#000000">based on the optimal capabilities of the card and the sound stream.</FONT>

<FONT COLOR="#000000">We now have two ways to resolve the issue. One is to keep the current</FONT>
<FONT COLOR="#000000">approach and set 'stereo' as the preferred channels layout through</FONT>
<FONT COLOR="#000000">something we call a capsfilter. This approach has some drawbacks as it</FONT>
<FONT COLOR="#000000">requires a lot of logic in the application when overriding the default</FONT>
<FONT COLOR="#000000">of stereo or you risk your surround config being interpreted as a wish</FONT>
<FONT COLOR="#000000">for upmixing of mono/stereo streams to surround.</FONT>

<FONT COLOR="#000000">The other alternative we are looking at which might simplify things for</FONT>
<FONT COLOR="#000000">us is to use the virtual devices which expose the different surround</FONT>
<FONT COLOR="#000000">scenarios like using for instance:</FONT>

<FONT COLOR="#000000">defaults.pcm.surround51.device for surround51 output.</FONT>

<FONT COLOR="#000000">In this scenario we use the stereo device by default which would then</FONT>
<FONT COLOR="#000000">only report back support for stereo and thus negotiate correctly to</FONT>
<FONT COLOR="#000000">stereo with all elements. Users can then through the applications choose</FONT>
<FONT COLOR="#000000">the 5.1 audio device at which point we would change to the 5.1 device</FONT>
<FONT COLOR="#000000">like the one above. Our worry the by the playback autoplugger which as</FONT>
<FONT COLOR="#000000">you know is rarely the casere though is what happens with stereo output</FONT>
<FONT COLOR="#000000">as we of course do not want that upmixed. Do these 5.1 virtual devices</FONT>
<FONT COLOR="#000000">also handle stereo correctly? What would be the expected result when</FONT>
<FONT COLOR="#000000">querying these devices through the libalsa API</FONT>

<FONT COLOR="#000000">Christian</FONT>




<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">Join SourceForge.net's Techsay panel and you'll get the chance to share your</FONT>
<FONT COLOR="#000000">opinions on IT &amp; business topics through brief surveys-and earn cash</FONT>
<FONT COLOR="#000000"><A HREF="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</A></FONT>
<FONT COLOR="#000000">_______________________________________________</FONT>
<FONT COLOR="#000000">Alsa-devel mailing list</FONT>
<FONT COLOR="#000000"><A HREF="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</A></FONT>
<FONT COLOR="#000000"><A HREF="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</A></FONT>
</PRE>
</BLOCKQUOTE>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-gdV3mGfixO7Rjyyyt9Ht--



--===============1562155517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1562155517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1562155517==--

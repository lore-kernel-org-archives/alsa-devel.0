From: paul santa clara <kesserich1@comcast.net>
Subject: Re: Direct Delivery of NoteOn events
Date: Wed, 25 Oct 2006 19:56:01 -0400
Message-ID: <68553F7D-DBC4-4D0E-A5A4-071B94359269@comcast.net>
References: <46195E17-B17F-40C2-A77A-7CABB4B9E742@comcast.net>
	<1161676827.21456.274067836@webmail.messagingengine.com>
	<99C795AE-FCD2-4E95-ABE0-145AA81EFB58@comcast.net>
	<1161764738.26435.274165147@webmail.messagingengine.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/mixed; boundary="===============1685813149=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1161764738.26435.274165147@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1685813149==
Content-Type: multipart/alternative; boundary=Apple-Mail-1-977251067


--Apple-Mail-1-977251067
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On Oct 25, 2006, at 4:25 AM, Clemens Ladisch wrote:
>
> What is your program doing after this call?

The function enters into an infinite while{} which bombards alsa with  
events.   No relevant variables go out of scope.

int i=1;
while (1) {
	event.data.note.note = i;
	snd_seq_event_output( our_parcel->seq, &event );
	snd_seq_drain_output( our_parcel->seq );
	printf("sleep\n");
	sleep(1);
	i++;
	if (i > 127)
		i = 1;
	}

> If you don't wait until the
> event has been delivered, the queue with the events still in it  
> will be
> destroyed.

Hmmm...I'm not sure you what you mean here.  Is there a function i  
can call to block the thread until ALSA has delivered the events?   
How exactly is the Queue destroyed?

thanks,
-paul santa clara


--Apple-Mail-1-977251067
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><BR><DIV><DIV>On Oct 25, 2006, =
at 4:25 AM, Clemens Ladisch wrote:</DIV><BLOCKQUOTE type=3D"cite"><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">What is =
your program doing after this call?<SPAN =
class=3D"Apple-converted-space">=A0<BR></SPAN></DIV></BLOCKQUOTE><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>The function enters into an =
infinite while{} which bombards alsa with events.=A0 =A0No relevant =
variables go out of scope.</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#760F50" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;"><BR class=3D"khtml-block-placeholder"></SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" color=3D"#760F50" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">int i=3D1;</SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" color=3D"#760F50" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">while</SPAN></FONT><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13px;"> =
(</SPAN></FONT><FONT class=3D"Apple-style-span" color=3D"#0000FF" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">1</SPAN></FONT><FONT class=3D"Apple-style-span"=
 face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">) {</SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><SPAN class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</SPAN><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">event.data.note.note =3D <FONT =
class=3D"Apple-style-span" color=3D"#0000FF">i</FONT></SPAN></FONT><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">;</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</SPAN><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">snd_seq_event_output( our_parcel-&gt;seq, &amp;event =
);</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><SPAN class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</SPAN><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">snd_seq_drain_output( our_parcel-&gt;seq =
);</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><SPAN class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</SPAN><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">printf(</SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#891315" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">"sleep\n"</SPAN></FONT><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">);</SPAN></FONT></DIV><DIV style=3D"margin-top:=
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</SPAN><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">sleep(</SPAN></FONT><FONT class=3D"Apple-style-span" =
color=3D"#0000FF" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">1</SPAN></FONT><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">);</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13px;"><SPAN =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</SPAN>i++;</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13px;"><SPAN =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</SPAN>if (i =
&gt; 127)</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13px;"><SPAN =
class=3D"Apple-tab-span" style=3D"white-space:pre">		</SPAN>i =
=3D 1;</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</SPAN><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">}</SPAN></FONT></DIV><BR><BLOCKQUOTE type=3D"cite"><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><SPAN class=3D"Apple-converted-space"> </SPAN>If you =
don't wait until the</DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">event has been delivered, =
the queue with the events still in it will be</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; =
">destroyed.</DIV></BLOCKQUOTE><BR></DIV><DIV>Hmmm...I'm not sure you =
what you mean here.=A0 Is there a function i can call to block the =
thread until ALSA has delivered the events?=A0 How exactly is the Queue =
destroyed?</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>thanks,</DIV><DIV>-paul =
santa clara</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV></BODY></HTML>=

--Apple-Mail-1-977251067--


--===============1685813149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1685813149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1685813149==--

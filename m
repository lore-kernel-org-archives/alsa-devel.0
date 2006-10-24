From: paul santa clara <kesserich1@comcast.net>
Subject: Re: Direct Delivery of NoteOn events
Date: Tue, 24 Oct 2006 18:24:23 -0400
Message-ID: <3CFA48A6-F313-42A8-A639-C26E8F400598@comcast.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/mixed; boundary="===============0752866384=="
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


--===============0752866384==
Content-Type: multipart/alternative; boundary=Apple-Mail-1-885353445


--Apple-Mail-1-885353445
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Hi Clemens!

This applies only to note events, not to note on events.
Note events are split into a note on and a note off event.

Gotcha. That is what I meant. :)

int queue = snd_seq_alloc_queue( our_parcel->seq );

You must create the queue before you try to send events through it.

I attempted this which still does not work correctly.  >>> indicates  
changes.

//Queue
	snd_seq_queue_tempo_t *tempo;
 >>>	int queue = snd_seq_alloc_named_queue( our_parcel->seq, "Q1" );
	snd_seq_queue_tempo_alloca( &tempo );
	snd_seq_queue_tempo_set_tempo( tempo, 1000000);
	snd_seq_queue_tempo_set_ppq( tempo, 48 );
	snd_seq_set_queue_tempo( our_parcel->seq, queue, tempo );
 >>>	snd_seq_start_queue( our_parcel->seq, queue, NULL );

	snd_seq_ev_clear( &event );	
	snd_seq_ev_set_source( &event, our_parcel->out_port );
	//snd_seq_ev_set_subs( &event );
	snd_seq_ev_set_dest( &event, dest.client, dest.port );
	snd_seq_ev_schedule_tick(  &event, queue, 0, 20000 );
	snd_seq_ev_set_note( &event, 1, 67, 127, 800 );

Note, that above I have tried both using subscriptions and directly  
sending to the destination port. Neither works correctly when i am  
sending the alsa event to another process, but snd_seq_ev_set_dest()  
does work when sending to another port in the SAME process/client.  I  
verified this using another thread listening on the 2nd port. Pretty  
odd.  Finally, I output the event and drain the output...

 >>>snd_seq_event_output( our_parcel->seq, &event );
	snd_seq_drain_output( our_parcel->seq );

I've read thru a couple of small programs now which seem to do just  
this but actually work.  Any idea what i am missing?
thanks a bunch ,
-paul



--Apple-Mail-1-885353445
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Hi =
Clemens!</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
12px/normal Helvetica; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" =
color=3D"#000FDD">This applies only to note events, not to note on =
events.</FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><FONT class=3D"Apple-style-span" =
color=3D"#000FDD">Note events are split into a note on and a note off =
event.</FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
12px/normal Helvetica; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Gotcha. That is what I meant. :)</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; font: normal normal normal 12px/normal Helvetica; =
min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#116213">int queue =3D =
snd_seq_alloc_queue( our_parcel-&gt;seq );</FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; font: normal normal normal 12px/normal Helvetica; =
min-height: 14px; "><FONT class=3D"Apple-style-span" =
color=3D"#000FDD"><BR></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" color=3D"#000FDD">You must create the queue =
before you try to send events through it.</FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; font: normal normal normal 12px/normal Helvetica; =
min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">I attempted =
this which still does not work correctly.=A0 &gt;&gt;&gt; indicates =
changes.</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
12px/normal Helvetica; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">//Queue</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</SPAN><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">snd_seq_queue_tempo_t *tempo;</SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">&gt;&gt;&gt;<SPAN class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</SPAN><FONT class=3D"Apple-style-span" =
color=3D"#741150" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">int</SPAN></FONT><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: 13px;"> =
queue =3D snd_seq_alloc_named_queue( our_parcel-&gt;seq, =
</SPAN></FONT><FONT class=3D"Apple-style-span" color=3D"#881414" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">"Q1"</SPAN></FONT><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13px;"> =
);</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><SPAN class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</SPAN><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">snd_seq_queue_tempo_alloca( &amp;tempo =
);</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><SPAN class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</SPAN><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">snd_seq_queue_tempo_set_tempo( tempo, =
</SPAN></FONT><FONT class=3D"Apple-style-span" color=3D"#0011FF" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">1000000</SPAN></FONT><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">);=A0</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</SPAN><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">snd_seq_queue_tempo_set_ppq( tempo, </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#0011FF" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">48</SPAN></FONT><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: 13px;"> =
);</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><SPAN class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</SPAN><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">snd_seq_set_queue_tempo( our_parcel-&gt;seq, =
queue, tempo );</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">&gt;&gt;&gt;<SPAN class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</SPAN><FONT class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">snd_seq_start_queue( our_parcel-&gt;seq, queue, =
</SPAN></FONT><FONT class=3D"Apple-style-span" color=3D"#741150" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">NULL</SPAN></FONT><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13px;"> =
);</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
12px/normal Helvetica; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><SPAN class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</SPAN><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">snd_seq_ev_clear( &amp;event =
);</SPAN></FONT><SPAN class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</SPAN></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><SPAN class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</SPAN><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">snd_seq_ev_set_source( &amp;event, =
our_parcel-&gt;out_port );</SPAN></FONT></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</SPAN><FONT =
class=3D"Apple-style-span" color=3D"#286D26" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">//snd_seq_ev_set_subs( &amp;event );</SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><SPAN class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</SPAN><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">snd_seq_ev_set_dest( &amp;event, dest.client, =
dest.port );</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><SPAN =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</SPAN><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">snd_seq_ev_schedule_tick(=A0 &amp;event, queue, =
</SPAN></FONT><FONT class=3D"Apple-style-span" color=3D"#0011FF" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">0</SPAN></FONT><FONT class=3D"Apple-style-span"=
 face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">, </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#0011FF" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">20000</SPAN></FONT><FONT class=3D"Apple-style-span" face=3D"Monaco"=
 size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: 13px;"> =
);</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><SPAN class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</SPAN><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">snd_seq_ev_set_note( &amp;event, =
</SPAN></FONT><FONT class=3D"Apple-style-span" color=3D"#0011FF" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">1</SPAN></FONT><FONT class=3D"Apple-style-span"=
 face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">, </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#0011FF" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">67</SPAN></FONT><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: 13px;">, =
</SPAN></FONT><FONT class=3D"Apple-style-span" color=3D"#0011FF" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">127</SPAN></FONT><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13px;">, =
</SPAN></FONT><FONT class=3D"Apple-style-span" color=3D"#0011FF" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">800</SPAN></FONT><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13px;"> =
);</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
13px/normal Monaco; min-height: 17px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Note, that above I have tried both using =
subscriptions and directly sending to the destination port. Neither =
works correctly when i am sending the alsa event to another process, but =
snd_seq_ev_set_dest() does work when sending to another port in the SAME =
process/client.=A0 I verified this using another thread listening on the =
2nd port. Pretty odd.=A0 Finally, I output the event and drain the =
output...</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
13px/normal Monaco; min-height: 17px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">&gt;&gt;&gt;snd_seq_event_output( our_parcel-&gt;seq, &amp;event =
);</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><SPAN class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</SPAN><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">snd_seq_drain_output( our_parcel-&gt;seq =
);</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
12px/normal Helvetica; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">I've read thru a couple of small programs now which =
seem to do just this but actually work.=A0 Any idea what i am =
missing?</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">thanks a bunch ,</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">-paul</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font: normal =
normal normal 12px/normal Helvetica; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; font: normal normal normal 12px/normal Helvetica; =
min-height: 14px; "><BR =
class=3D"khtml-block-placeholder"></DIV></BODY></HTML>=

--Apple-Mail-1-885353445--


--===============0752866384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0752866384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0752866384==--

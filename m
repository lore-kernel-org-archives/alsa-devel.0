From: paul santa clara <kesserich1@comcast.net>
Subject: Direct Delivery of NoteOn events
Date: Mon, 23 Oct 2006 15:58:33 -0400
Message-ID: <46195E17-B17F-40C2-A77A-7CABB4B9E742@comcast.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/mixed; boundary="===============0742679201=="
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


--===============0742679201==
Content-Type: multipart/alternative; boundary=Apple-Mail-1-790203799


--Apple-Mail-1-790203799
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Hi everyone,
	I am having difficulty getting alsa to actually delivery a noteon  
event for me.  I am came across a list posting from 2004 which  
claimed that Queue's were necessary for NoteOn's to allow alsa to  
schedule the concomitant Noteoff at the appropriate time.   
Nevertheless, i can find nothing in the documentation which  
collaborates this.  Still, i did attempt to use to a Q but was unable  
to produce any results.  Here is the offending code:

snd_seq_ev_clear( &event );	
snd_seq_ev_set_source( &event, our_parcel->out_port );
snd_seq_ev_set_subs( &event );						//subscription was graphically  
verified with Qjack
snd_seq_ev_set_direct( &event );
snd_seq_ev_schedule_tick(  &event, queue, 0, 4 );
snd_seq_ev_set_note( &event, 1, 67, 127, 8 );

//Queue stuff
snd_seq_queue_tempo_t *tempo;
int queue = snd_seq_alloc_queue( our_parcel->seq );
snd_seq_queue_tempo_alloca( &tempo );
snd_seq_queue_tempo_set_tempo( tempo, 100000);
snd_seq_queue_tempo_set_ppq( tempo,64 );
snd_seq_set_queue_tempo( our_parcel->seq, queue, tempo );

snd_seq_start_queue( our_parcel->seq, queue, NULL );
snd_seq_drain_output( our_parcel->seq );

Any help would be much appreciated.
thanks in advance,
-paul


--Apple-Mail-1-790203799
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; ">Hi everyone,<DIV><SPAN =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</SPAN>I am =
having difficulty getting alsa to actually delivery a noteon event for =
me.=A0 I am came across a list posting from 2004 which claimed that =
Queue's were=A0necessary for NoteOn's to allow alsa to schedule the =
concomitant Noteoff at the appropriate time.=A0 Nevertheless, i can find =
nothing in the documentation which collaborates this.=A0 Still, i did =
attempt to use to a Q but was unable to produce any results.=A0 Here is =
the offending code:</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13px;">snd_seq_ev_clear( =
&amp;event );</SPAN></FONT><SPAN class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</SPAN></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">snd_seq_ev_set_source( &amp;event, our_parcel-&gt;out_port =
);</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">snd_seq_ev_set_subs( &amp;event );<SPAN =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
		</SPAN>//subscription was graphically verified with =
Qjack</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">snd_seq_ev_set_direct( &amp;event );</SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">snd_seq_ev_schedule_tick(</SPAN></FONT><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13px;">=A0 =
</SPAN></FONT><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">&amp;event, queue, </SPAN></FONT><FONT class=3D"Apple-style-span" =
color=3D"#0000FF" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">0</SPAN></FONT><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: 13px;">, =
</SPAN></FONT><FONT class=3D"Apple-style-span" color=3D"#0000FF" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">4</SPAN></FONT><FONT class=3D"Apple-style-span"=
 face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;"> );</SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">snd_seq_ev_set_note( &amp;event, </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#0000FF" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">1</SPAN></FONT><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: 13px;">, =
</SPAN></FONT><FONT class=3D"Apple-style-span" color=3D"#0000FF" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">67</SPAN></FONT><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13px;">, =
</SPAN></FONT><FONT class=3D"Apple-style-span" color=3D"#0000FF" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">127</SPAN></FONT><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13px;">, =
</SPAN></FONT><FONT class=3D"Apple-style-span" color=3D"#0000FF" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">8</SPAN></FONT><FONT class=3D"Apple-style-span"=
 face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;"> );</SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;"><BR class=3D"khtml-block-placeholder"></SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">//Queue stuff</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">snd_seq_queue_tempo_t *tempo;</SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" color=3D"#760F50" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">int</SPAN></FONT><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13px;"> queue =3D =
snd_seq_alloc_queue( our_parcel-&gt;seq );</SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">snd_seq_queue_tempo_alloca( &amp;tempo );</SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">snd_seq_queue_tempo_set_tempo( tempo, </SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#0000FF" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">100000</SPAN></FONT><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">);</SPAN></FONT><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">=A0</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">snd_seq_queue_tempo_set_ppq( tempo,</SPAN></FONT><FONT =
class=3D"Apple-style-span" color=3D"#0000FF" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">64</SPAN></FONT><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: 13px;"> =
);</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">snd_seq_set_queue_tempo( our_parcel-&gt;seq, =
queue, tempo );</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13px;"><BR =
class=3D"khtml-block-placeholder"></SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">snd_seq_start_queue( our_parcel-&gt;seq, queue, =
</SPAN></FONT><FONT class=3D"Apple-style-span" color=3D"#760F50" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">NULL</SPAN></FONT><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13px;"> =
);</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;">snd_seq_drain_output( our_parcel-&gt;seq =
);</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><FONT class=3D"Apple-style-span" =
face=3D"Monaco" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13px;"><BR =
class=3D"khtml-block-placeholder"></SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">Any help would be much appreciated.</SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" face=3D"Monaco" =
size=3D"3"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13px;">thanks in advance,</SPAN></FONT></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13px;">-paul</SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" face=3D"Monaco" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13px;"><BR =
class=3D"khtml-block-placeholder"></SPAN></FONT></DIV></BODY></HTML>=

--Apple-Mail-1-790203799--


--===============0742679201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0742679201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0742679201==--

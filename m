From: Alberto.Pareto@seleniacomms.com
Subject: Re: Capturing audio and 1010lt
Date: Thu, 27 Jan 2005 10:35:05 +0100
Message-ID: <OF02C1932E.0682A136-ONC1256F96.003253F7@MarconiSelenia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jody McIntyre <lad@modernduck.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



>> What I'm supposed to do to get 8 different captures? Maybe this can be
done
>> only through the API and not with the standard tool installed with ALSA
>> (like arecord and aplay)?
>> Is this a limitation of the board?

>I've used ardour ( http://ardour.org/ ) to capture multiple streams from
>a Delta 1010 (not LT but the software's the same).  Once I got Ardour
>going and figured out how to use it, the capture Just Worked.  The thing
>is, there only is one capture device.  It just has 8 channels.  If you
want
>to split them apart and send them to separate programs, use Jack
>( http://jackit.sourceforge.net/ ).  Of course, you'll then need to use
>Jack-enabled recording software instead of arecord.


Thanks Jody.
Thus I have to split single channels from a unique stream of data ... but
are they
interleaved? I mean:

 1st byte:   from ch1
 2nd byte:  from ch2
...
 8th byte:   from ch8
 9th byte:   from ch1
10th byte:  from ch2
...
16th bye: from ch8
?

And, in the stream, are there  always all the (8) channels or the selected
channels only?

Do you have informations about the devices that can be seen in alsamixer
application?
I'm not able to understand their meaning.

I see that arecord has a '-c' option that means 'The number of channels'.
I find it a bit strange to specify how many channels and not which channels
to capture... What I'm supposed to do if I'm interested in recording only
some
channels, i.e., 3 and 6?

Sorry for abusing your time!

Alberto



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl

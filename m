From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: mtpav revisited.. MTC/SMPTE
Date: Sun, 15 Jun 2003 15:25:06 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19Rd30-0001QX-00@sc8-sf-list1.sourceforge.net>
References: <1055703160.25641.38.camel@littlewolf2.littlewolf>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "16 Jun 2003 04:52:40 +1000."
             <1055703160.25641.38.camel@littlewolf2.littlewolf>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Allan Klinbail <allank@labyrinth.net.au>
Cc: Alsa-dev <alsa-devel@lists.sourceforge.net>, MusE list <muse@seh.de>
List-Id: alsa-devel@alsa-project.org

>This occurs in both MusE and ardour  but I'm kind of ignoring the ardour
>results as I can't find where the frame rate is setup..  I haven't used
>any other clients.. I ahve to check with MusE list to see if MTC is
>fully implemented 

if you mean audio frame rate, ardour doesn't set it - its up to JACK.
if you mean the SMPTE frame rate, its in the session state file. there
is no way to set the value from the GUI at this time.



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5

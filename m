From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: How do I make -D hw:0,1 default?
Date: Tue, 3 Jun 2003 11:36:42 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGCEBCCGAB.mknecht@controlnet.com>
References: <Pine.LNX.4.44.0306032028280.1174-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306032028280.1174-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > .asoundrc from Alsa site:
> >
> >         pcm.via82xx {
> >            type hw
> >            card 0
> >         }
> >
> >         ctl.via82xx {
> >            type hw
> >            card 0
> >         }
> >
> > Maybe I need to include the ',1' interface somehow? How would I do that?
>
> Add 'device 1' to {} section.
>
> 						Jaroslav

Thanks Jaroslav!

Will this make device 1 default for all applications that require sound but
do not ask for anything specific in terms of interfaces?

Also, please ignore the email I just sent to alsa-devel 10 seconds before
your answer arrived at my desk.

Cheers,
Mark




-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5

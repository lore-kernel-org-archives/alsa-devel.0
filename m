From: "Nick French" <nick@greensignal.com>
Subject: Re: Multiple PCM files
Date: Tue, 30 Jul 2002 14:58:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <104d01c237d1$412cc1e0$360110ac@dillon>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

New to this sound thing most of the stuff we have done is graphical what is
the formula for mixing n streams is it as simple as  (stream 1 / number
streams) + ( stream 2 / number of streams ) ..... + (stream n / number of
streams ). What about different sample rates, stereo and mono. Any sample
code around?


Cheers

Nick

----- Original Message -----
From: "Paul Davis" <pbd@op.net>
To: "Nick French" <nick@greensignal.com>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Tuesday, July 30, 2002 2:18 PM
Subject: Re: [Alsa-devel] Multiple PCM files


> >So does JACKs allow two separate applications to stream PCM audio at the
> >same time to the same device and if so will it then overlay them? If it
will
> >why would two threads each registering with JACKs not work.
>
> it might, but it would be very inefficient. every JACK connection
> requires a new thread in the client, and implies an IPC per client per
> process() callback cycle.
>
> the code to mix down your own threads' output buffers is a few
> lines. why bother with anything else?
>
> --p
>



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
